#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <faad.h>

/*typedef struct NeAACDecConfiguration
{
    unsigned char defObjectType;
    unsigned long defSampleRate;
    unsigned char outputFormat;
    unsigned char downMatrix;
    unsigned char useOldADTSFormat;
    unsigned char dontUpSampleImplicitSBR;
} NeAACDecConfiguration, *NeAACDecConfigurationPtr;*/

void printConfig(NeAACDecConfigurationPtr conf) {
    printf("[defObjectType]          :%u\n", conf->defObjectType);
    printf("[defSampleRate]          :%lu\n", conf->defSampleRate);
    printf("[outputFormat]           :%u\n", conf->outputFormat);
    printf("[downMatrix]             :%u\n", conf->downMatrix);
    printf("[useOldADTSFormat]       :%u\n", conf->useOldADTSFormat);
    printf("[dontUpSampleImplicitSBR]:%u\n", conf->dontUpSampleImplicitSBR);
}

/*typedef struct NeAACDecFrameInfo
{
    unsigned long bytesconsumed;
    unsigned long samples;
    unsigned char channels;
    unsigned char error;
    unsigned long samplerate;
    unsigned char sbr; //SBR: 0: off, 1: on; upsample, 2: on; downsampled, 3: off; upsampled
    unsigned char object_type; //MPEG-4 ObjectType
    unsigned char header_type; //AAC header type; MP4 will be signalled as RAW also
    unsigned char num_front_channels; //multichannel configuration
    unsigned char num_side_channels;
    unsigned char num_back_channels;
    unsigned char num_lfe_channels;
    unsigned char channel_position[64];
    unsigned char ps; //PS: 0: off, 1: on
} NeAACDecFrameInfo;*/
void
printFrameInfo(NeAACDecFrameInfo* info) {
    printf("[bytesconsumed]     :%lu\n", info->bytesconsumed);
    printf("[samples]           :%lu\n", info->samples);
    printf("[channels]          :%u\n", info->channels);
    printf("[error]             :%u\n", info->error);
    printf("[samplerate]        :%lu\n", info->samplerate);
    printf("[sbr]               :%u\n", info->sbr);
    printf("[object_type]       :%u\n", info->object_type);
    printf("[header_type]       :%u\n", info->header_type);
    printf("[num_front_channels]:%u\n", info->num_front_channels);
    printf("[num_side_channels] :%u\n", info->num_side_channels);
    printf("[num_back_channels] :%u\n", info->num_back_channels);
    printf("[num_lfe_channels]  :%u\n", info->num_lfe_channels);
    printf("[channel_position]  :");
    int i, j;
    for (j = 0; j < 4; j++) {
        for (i = 0; i < 16; i++) {
            printf("%0X ", info->channel_position[j*16+i]);
            if (i == 8) printf("   ");
        }
        if (j < 3) {
            printf("\n                     ");
        } else {
            printf("\n");
        }
    }
    printf("[ps]                :%u\n", info->ps);
}

typedef struct _AdtsFrame {
    unsigned char *buf;
    unsigned  long buf_size;
} AdtsFrame; 

void freeAdtsFrame(AdtsFrame* frame) {
    if (frame != NULL) {
        if (frame->buf != NULL) free(frame->buf);
        free(frame);
    }
}

AdtsFrame*
get_an_adts_frame(FILE *fp) {
    unsigned char header[7];
    while (fread(header, 1, 7, fp) == 7) {
        if (header[0] != 0xFF || (header[1] & 0xF0) != 0xF0) {
            printf("Failed to check syncword!\n");
            int i;
            for (i = 1; i < 6; i++) {
                if (header[i] == 0xFF && (header[i+1] & 0xF0) == 0xF0) {
                    break;
                }
            }
            if (i == 6) {
                fseek(fp, (long)-1, 1);
            } else {
                fseek(fp, (long)(i-7), 1);
            }
            continue;
        }
        int frameLength = header[3] & 0x03;
        frameLength <<= 8;
        frameLength |= header[4];
        frameLength <<= 3;
        frameLength |= (header[5] >> 5);
        AdtsFrame* frame = (AdtsFrame *) malloc(sizeof(AdtsFrame));
        if (NULL == frame) {
            printf("Failed to malloc AdtsFrame!\n");
            return NULL;
        }
        frame->buf = (unsigned char *) malloc(frameLength);
        if (frame->buf == NULL) {
            printf("Failed to malloc buf for AdtsFrame!\n");
            freeAdtsFrame(frame);
            frame = NULL;
            return frame;
        }
        frame->buf_size = frameLength;
        memcpy(frame->buf, header, 7);
        fread(frame->buf+7, 1, frameLength-7, fp);
        return frame;
    }
    return NULL;
}

int main(int argc, const char *args[]) {
    if (argc < 2) {
        printf("Please specifi an aac file!\n");
        return 1;
    }
    FILE *fp = fopen(args[1], "rb");
    if (fp == NULL) {
        printf("Can not open %s\n", args[1]);
        return 1;
    }

    unsigned long cap = NeAACDecGetCapabilities();
    printf("caps:0x%lX\n", cap);

    NeAACDecHandle hAac = NeAACDecOpen();
    NeAACDecConfigurationPtr conf = NeAACDecGetCurrentConfiguration(hAac);
    printConfig(conf);
    conf->dontUpSampleImplicitSBR = 1;
    NeAACDecSetConfiguration(hAac, conf);
    unsigned long samplerate;
    unsigned char channels;
    AdtsFrame *frame = get_an_adts_frame(fp);
    if (NULL == frame) {
        printf("Failed to find an adts frame\n");
        return 1;
    }
    long ret = NeAACDecInit(hAac, frame->buf, frame->buf_size, &samplerate, &channels);
    if (ret < 0) {
        printf("Failed to init the aac decoder!\n");
        return 1;
    } else {
        printf("init aac decoder successed!\n");
        printf("samplerate:%lu, channels:%u, byteRead:%ld\n", samplerate, channels, ret);
    }
    NeAACDecFrameInfo frameInfo;
    int num = 0;
    void *sample_buffer;
    sample_buffer = NeAACDecDecode(hAac, &frameInfo, frame->buf+ret, frame->buf_size-ret);
    if (NULL != sample_buffer) {
        printf("decode frame %d, samples:%lu\n", ++num, frameInfo.samples);
    } else {
        printf("Failed to decode frame %d, exit!\n", ++num);
        return 1;
    }
    freeAdtsFrame(frame);
    printFrameInfo(&frameInfo);
    FILE *pcmout = fopen("/tmp/pcmout", "w+");
    if (NULL == pcmout) {
        printf("Failed to open pcmout!\n");
        return 1;
    }
    while (frame = get_an_adts_frame(fp)) {
        sample_buffer = NeAACDecDecode(hAac, &frameInfo, frame->buf+ret, frame->buf_size-ret);
        freeAdtsFrame(frame);
        if (frameInfo.samples > 0) {
            fwrite(sample_buffer, 1, frameInfo.samples*2, pcmout);
        }
        if (sample_buffer == NULL) {
            printf("Failed to decode the frame %d, exit!\n", ++num);
            return 1;
        } else {
            //printf("decode frame %d, samples:%lu\n", ++num, frameInfo.samples);
        }
    }
    fflush(pcmout);
    fclose(fp);
    fclose(pcmout);
    NeAACDecClose(hAac);
    return 0;
}
