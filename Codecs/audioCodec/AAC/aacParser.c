#include <stdio.h>

//#define FILENAME "/home/gary/Study/codecs/AAC/test.aac"
#define HEADERLEN 7

typedef unsigned char uchar;

const char* audioObjectType[] = {
    "NULL",
    "AAC MAIN",
    "AAC LC",
    "AAC SSR",
    "AAC LTP"
};

const char* sampleFrequency[] = {
    "96000 HZ",
    "88200 HZ",
    "64000 HZ",
    "48000 HZ",
    "44100 HZ",
    "32000 HZ",
    "24000 HZ",
    "22050 HZ",
    "16000 HZ",
    "12000 HZ",
    "11025 HZ",
    "8000 HZ",
    "7350 HZ",
    "reserved",
    "reserved",
    "escape value",
};

const char* channelConfiguration[] = {
    "defined in AOT related SpecificConfig",
    "1",
    "2",
    "3",
    "4",
    "5",
    "5.1",
    "7,1",
};

struct ADTSHeader {
    //int syncword;                             //12bit, always 0xFFF
    uchar mpeg_version;                         //1bit, 0 for MPEG-4, 1 for MPEG-2
    uchar layer;                                //2bit, always '00'
    uchar protection_absent;                    //1bit, 1 without CRC, 0 with CRC
    uchar profile;                              //2bit, equal to (Audio Object Type - 1)
    uchar sample_frequency_index;               //4bit
    uchar private_bit;                          //1bit, set to 0 when encoding, ignore when decoding
    uchar channel_configuration;                //3bit
    uchar original_copy;                        //1bit, set to 0 when encoding, ignore when decoding
    uchar home;                                 //1bit, set to 0 when encoding, ignore when decoding

    uchar copyright_identification_bit;         //1bit, set to 0 when encoding, ignore when decoding
    uchar copyright_identification_start;       //1bit, set to 0 when encoding, ignore when decoding
    int aac_frame_length;                       //13bit
    int adts_buffer_fullness;                   //11bit
    uchar number_of_raw_data_blocks_in_frame;   //2bit

};

void printAACHeader(int num, const struct ADTSHeader* h) {
    printf(" %4d |", num);
    printf(" %s |", h->mpeg_version ? "MPEG-2" : "MPEG-4");
    printf(" %d |", h->layer);
    printf(" %s |", h->protection_absent ? "noCRC" : "withCRC");
    printf(" %s |", audioObjectType[h->profile+1]);
    printf(" %s |", sampleFrequency[h->sample_frequency_index]);
    printf(" %d |", h->private_bit);
    printf(" %s channels |", channelConfiguration[h->channel_configuration]);
    printf(" %d |", h->original_copy);
    printf(" %d |", h->home);
    printf(" %d |", h->copyright_identification_bit);
    printf(" %d |", h->copyright_identification_start);
    printf(" %d |", h->aac_frame_length);
    printf(" 0x%X |", h->adts_buffer_fullness);
    printf(" %d\n", h->number_of_raw_data_blocks_in_frame+1);
}

int main(int argc, char *args[]) {
    if (argc < 2) {
        printf("Please specify the aac file\n");
    }
    FILE *fp = fopen(args[1], "rb");
    if (fp == NULL) {
        printf("Failed to open %s\n", args[1]);
        return 1;
    }

    printf("| num |mpeg_version|layer|protection|profile|sample rate|private_bit|channels|original_copy|home|copyright_bit|copyright_start|frame_length|buffer_fullness|AACPerADTS\n");

    uchar header[HEADERLEN];
    struct ADTSHeader adtsHeader;
    int num = 1;
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
        adtsHeader.mpeg_version = header[1] & 0x08;
        adtsHeader.mpeg_version >>= 3;
        adtsHeader.layer = (header[1] & 0x06) >> 1;
        adtsHeader.protection_absent = header[1] & 0x01;
        adtsHeader.profile = header[2] >> 6;
        adtsHeader.sample_frequency_index = header[2] & 0x3F;
        adtsHeader.sample_frequency_index >>= 2;
        adtsHeader.private_bit = header[2] & 0x02;
        adtsHeader.channel_configuration = header[2] & 0x01;
        adtsHeader.channel_configuration <<= 2;
        adtsHeader.channel_configuration |= (header[3] >> 6);
        adtsHeader.original_copy = header[3] & 0x20;
        adtsHeader.home = header[3] & 0x10;
        adtsHeader.copyright_identification_bit = header[3] & 0x08;
        adtsHeader.copyright_identification_start = header[3] & 0x04;
        adtsHeader.aac_frame_length = header[3] & 0x03;
        adtsHeader.aac_frame_length <<= 8;
        adtsHeader.aac_frame_length |= header[4];
        adtsHeader.aac_frame_length <<= 3;
        adtsHeader.aac_frame_length |= (header[5] >> 5);
        adtsHeader.adts_buffer_fullness = header[5] & 0x1F;
        adtsHeader.adts_buffer_fullness <<= 6;
        adtsHeader.adts_buffer_fullness |= header[6] >> 2;
        adtsHeader.number_of_raw_data_blocks_in_frame = header[6] & 0x03;
        printAACHeader(num, &adtsHeader);
        num++;
        fseek(fp, adtsHeader.aac_frame_length - HEADERLEN, 1);
    }
}
