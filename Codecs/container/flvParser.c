#include <stdio.h>
#include <stdlib.h>

#define FLVFILE "/home/gary/Videos/Container/FLV/test.flv"
#define FLVHEADERLEN 9
#define DEBUG 0
#define AUDIOESFILE "/tmp/audioes"
#define VIDEOESFILE "/tmp/videoes"

enum TAG_TYPE {
    TAG_TYPE_AUDIO = 8,
    TAG_TYPE_VIDEO = 9,
    TAG_TYPE_SCRIPT_DATA = 18
};

//Audio properties
struct AudioData {
    unsigned char format:4;
    unsigned char rate:2;
    unsigned char size:1;
    unsigned char type:1;
};

char *audioFormat[] = {
    "Linear PCM, platform endian",
    "ADPCM",
    "MP3",
    "Linear PCM, little endian",
    "Nellymoser 16-kHz mono",
    "Nellymoser 8-kHz mono",
    "Nellymoser",
    "G.711 A-law logarithmic PCM",
    "G.711 mu-law logarithmic PCM",
    "reserved",
    "AAC",
    "Speex",
    "NOT DEFINED",
    "NOT DEFINED",
    "MP3 8-Khz",
    "Device-specific sound",
};
char *audioRate[] = {
    "5.5-kHz",
    "11-kHz",
    "22-kHz",
    "44-kHz",
};
char *audioSize[] = {
    "snd8Bit",
    "snd16Bit",
};
char *audioType[] = {
    "sndMono",
    "sndStereo",
};

int set_adts_head(unsigned char *adts, unsigned char *extraData, int extraDataSize, int aacSize) {
    if (extraData == NULL || extraDataSize < 2) {
        printf("no extraData(%p) or extraDataSize(%d) less than 2\n", extraData, extraDataSize);
    }
    int profile, sampleRateIdx, channel;
    profile = (extraData[0] >> 3) & 0x1F;
    if (profile == 31) {
        int profileExt = (extraData[0] << 3 | extraData[1] >> 5) & 0x3F;
        profile = 32 + profileExt;
        sampleRateIdx = (extraData[1] >> 1) & 0x0F;
        if (sampleRateIdx == 0x0F) {
            channel = (extraData[4] << 3 | extraData[5] >> 5) & 0x0F;
        } else {
            channel = (extraData[1] << 3 | extraData[2] >> 5) & 0x0F;
        }
    } else {
        sampleRateIdx = (extraData[0] << 1 | extraData[1] >> 7) & 0x0F;
        if (sampleRateIdx == 0x0F) {
            channel = (extraData[4] >> 3) & 0x0F;
        } else {
            channel = (extraData[1] >> 3) & 0x0F;
        }
    }
    profile--;
    unsigned char byte;
    adts[0] = 0xFF;
    adts[1] = 0xF1;
    byte = 0;
    byte |= (profile & 0x03) << 6;
    byte |= (sampleRateIdx & 0x0F) << 2;
    byte |= (channel & 0x07) >> 2;
    adts[2] = byte;
    byte = 0;
    byte |= (channel & 0x07) << 6;
    byte |= (7 + aacSize) >> 11;
    adts[3] = byte;
    byte = 0;
    byte |= (7 + aacSize) >> 3;
    adts[4] = byte;
    byte = 0;
    byte |= ((7 + aacSize) & 0x07) << 5;
    byte |= (0x7FF >> 6) & 0x1f;
    adts[5] = byte;
    byte = 0;
    byte |= (0x7FF & 0x3F) << 2;
    adts[6] = byte;
}

//Video properties
struct VideoData {
    unsigned char frameType:4;
    unsigned char codecId:4;
};

char *videoFrameType[] = {
    "UNDEFINED",
    "keyframe",
    "inter frame",
    "disposable inter frame",
    "generated keyframe",
    "video info/command frame",
    "UNDEFINED",
    "UNDEFINED",
};
char *videoCodecId[] = {
    "UNDEFINED",
    "JPEG",
    "Sorenson H.263",
    "Screen video",
    "On2 VP6",
    "On2 VP6 with alpha channel",
    "Screen video version 2",
    "AVC",
};

//Script data propertyes
enum script_data_type {
    Number = 0,
    Boolean,
    String,
    Object,
    MovieClip,
    Null,
    Undefined,
    Reference,
    EcmaArray,
    ObjectEndMarker,
    StringArray,
    Date,
    LongString,
 };


int main(int argc, const char *args[]) {
    if (argc < 2) {
        printf("Please specify the flv file\n");
        return 1;
    }
    FILE *fp = fopen(args[1], "rb"); 
    if (fp == NULL) {
        printf("Can not open %s\n", args[1]);
        return 1;
    }
    char flvHeader[FLVHEADERLEN] = {0};
    fread(flvHeader, 1, FLVHEADERLEN, fp);

    int i = 0;
    if (DEBUG) {
        for (i = 0; i < FLVHEADERLEN; i++) {
            if (i == 0) printf("FLV header:");
            printf("  0x%02x", flvHeader[i]);
            if (i == FLVHEADERLEN-1) printf("\n");
        }
    }
    if (flvHeader[0] != 'F'
            || flvHeader[1] != 'L'
            || flvHeader[2] != 'V') {
        printf("%s is not a FLV file!!!\n", FLVFILE);
        return 1;
    }
    FILE *audioFp = NULL;
    FILE *videoFp = NULL;
    if (flvHeader[4] & 0x04) {
        audioFp = fopen(AUDIOESFILE, "w+");
        if (audioFp == NULL) {
            printf("Failed to open audio es file");
        }
    }
    if (flvHeader[4] & 0x01) {
        videoFp = fopen(VIDEOESFILE, "w+");
        if (videoFp == NULL) {
            printf("Failed to open video es file");
        }
    }

    /* Parse tags:
     * TagType UI8 - 8:audio, 9:video, 18:script data, others:reserved
     * DataSize UI24 - Length of the data in the Data filed
     * Timestamp UI24 - the lower 3 bytes of the timestamp, big endian
     * TimestampExtended UI8 - the upper 1 byte of the timestamp
     * StreamID UI24 - Awlays 0
     */
    int tagType = 0, dataSize = 0, streamId = 0;
    int timestamp = 0, timestampLower = 0, timestampExt = 0;
    const char *type = "";
    int sequence = 0;

    //AVC
    int nalLen = 0;
    const char nalStart[] = {0, 0, 0, 1};

    //AAC
    unsigned char *extraData = NULL;
    int extraDataSize = 0;
    unsigned char adts[7] = {0};

    //skip PreviousTagSize0
    fseek(fp, 4L, 1);

    tagType = fgetc(fp);
    while (!feof(fp)) {
        //Parse tag type
        switch (tagType) {
            case TAG_TYPE_AUDIO:
                type = "audio";
                break;
            case TAG_TYPE_VIDEO:
                type = "video";
                break;
            case TAG_TYPE_SCRIPT_DATA:
                type = "script data";
                break;
            default:
                type = "reserved type";
                break;
        }
        int i;
        //Parse data size
        dataSize = 0;
        for (i = 0; i < 3; i++) {
            dataSize <<= 8;
            dataSize |= fgetc(fp);
        }
        //Parse timestamp
        timestampLower = 0;
        for (i = 0; i < 3; i++) {
            timestampLower <<= 8;
            timestampLower |= fgetc(fp);
        }
        timestampExt = fgetc(fp);
        timestamp = (timestampExt << 24) | timestampLower;
        //Parse streamID
        streamId = 0;
        for (i = 0; i < 3; i++) { streamId <<= 8;
            streamId |= fgetc(fp);
        }


        int sizeReaded = 0;
        if (tagType == TAG_TYPE_AUDIO) {
            struct AudioData audioData;
            unsigned char data = fgetc(fp);
            sizeReaded += 1;
            audioData.format = data >> 4;
            //audioData.rate = (data << 4) >> 6;
            audioData.rate = (data & 0x0c) >> 2;
            audioData.size = (data & 0x02) >> 1;
            audioData.type = data & 0x01;
            printf("%-5d| %s dataSize(%d) timestamp(%d) (%s|%s|%s|%s)\n",
                    sequence, type, dataSize, timestamp,
                    audioFormat[audioData.format],
                    audioRate[audioData.rate],
                    audioSize[audioData.size],
                    audioType[audioData.type]);
            if (audioData.format == 10) {
                unsigned char aacPacketType = fgetc(fp); sizeReaded++;
                if (aacPacketType == 0) {
                    extraDataSize = dataSize - sizeReaded;
                    extraData = (unsigned char *) malloc(extraDataSize);
                    int ret = fread(extraData, 1, extraDataSize, fp); sizeReaded += ret;
                    if (ret != extraDataSize) {
                        printf("extraDataSize(%d), ret(%d)\n", extraDataSize, ret);
                    } else {
                        int i;
                        printf("extraDataSize(%d)\n", extraDataSize);
                        for (i = 0; i < extraDataSize; i++) {
                            printf("extraData[%d]:0x%02X\n", i, extraData[i]);
                        }
                    }
                    if (extraData == NULL) {
                        printf("Failed to malloc(%d bytes) for audio extra data\n", extraDataSize);
                    }
                } else {
                    if (audioFp != NULL) {
                        int bufLen = dataSize - sizeReaded;
                        unsigned char* buf = (unsigned char*) malloc(bufLen+7);
                        set_adts_head(adts, extraData, extraDataSize, bufLen);
                        if (buf != NULL) {
                            int ret = fread(buf, 1, bufLen, fp);
                            sizeReaded += ret;
                            if (ret == bufLen) {
                                fwrite(adts, 1, 7, audioFp);
                                fwrite(buf, 1, bufLen, audioFp);
                                fflush(audioFp);
                            }
                            free(buf);
                        }
                    }
                }
            }
        } else if (tagType == TAG_TYPE_VIDEO) {
            struct VideoData videoData;
            unsigned char data = fgetc(fp);
            sizeReaded += 1;
            videoData.frameType = data >> 4;
            videoData.codecId = data & 0x0F;
            if (videoData.codecId == 7) { //AVC type, pick AVCVIDEOPACKET
                const char *avcPacketType[] ={
                    "AVC sequence header",
                    "AVC NALU",
                    "AVC end of sequence",
                };
                struct {
                    unsigned char type;
                    int compositionTime; //occupy 3 bytes, big endian
                } avcPacket = {0,0};
                avcPacket.type = fgetc(fp);
                int i;
                for (i = 0; i < 3; i++) {
                    avcPacket.compositionTime << 8;
                    avcPacket.compositionTime |= fgetc(fp);
                }
                sizeReaded += 4;
                printf("%-5d| %s dataSize(%d) timestamp(%d) (%s|%s|%s|timeoffset(%d))\n",
                        sequence, type, dataSize, timestamp,
                        videoFrameType[videoData.frameType],
                        videoCodecId[videoData.codecId],
                        avcPacketType[avcPacket.type],
                        avcPacket.compositionTime
                        );
                if (avcPacket.type == 1 && videoFp != NULL) {
                    while (sizeReaded < dataSize - 4) {
                        int bufLen = fgetc(fp); sizeReaded++;
                        bufLen <<= 8; bufLen |= fgetc(fp); sizeReaded++;
                        bufLen <<= 8; bufLen |= fgetc(fp); sizeReaded++;
                        bufLen <<= 8; bufLen |= fgetc(fp); sizeReaded++;
                        unsigned char* buf = (unsigned char*) malloc(bufLen);
                        if (buf != NULL) {
                            fwrite(nalStart, 1, 4, videoFp);
                            int ret = fread(buf, 1, bufLen, fp);
                            sizeReaded += ret;
                            if (ret == bufLen) {
                                fwrite(buf, 1, bufLen, videoFp);
                                fflush(audioFp);
                            }
                            free(buf);
                        }
                    }
                } else if (avcPacket.type == 0) {
                    unsigned char configurationVersion = fgetc(fp); sizeReaded++;
                    unsigned char avcProfileIndication = fgetc(fp); sizeReaded++;
                    unsigned char profile_compatibility = fgetc(fp); sizeReaded++;
                    unsigned char avcLevelIndication = fgetc(fp); sizeReaded++;
                    unsigned char lengthSizeMinusOne = fgetc(fp); sizeReaded++;
                    nalLen = (lengthSizeMinusOne & 0x03) + 1;
                    unsigned char numOfSequenceParameterSets = fgetc(fp); sizeReaded++;
                    int SPSNum = numOfSequenceParameterSets & 0x1F;
                    int sequenceParameterSetLength = fgetc(fp); sizeReaded++;
                    sequenceParameterSetLength <<= 8;
                    sequenceParameterSetLength |= fgetc(fp); sizeReaded++;
                    char *spsNal = (char *) malloc(sequenceParameterSetLength);
                    if (spsNal) {
                        int ret = fread(spsNal, 1, sequenceParameterSetLength, fp);
                        sizeReaded += ret;
                        if (ret != sequenceParameterSetLength) {
                            printf("sps size: %d, but only read: %d\n", sequenceParameterSetLength, ret);
                        }
                    }
                    unsigned char numOfPictureParameterSets = fgetc(fp); sizeReaded++;
                    int pictureParameterSetLength = fgetc(fp); sizeReaded++;
                    pictureParameterSetLength <<= 8;
                    pictureParameterSetLength |= fgetc(fp); sizeReaded++;
                    char *ppsNal = (char *) malloc(pictureParameterSetLength);
                    if (ppsNal) {
                        int ret = fread(ppsNal, 1, pictureParameterSetLength, fp);
                        sizeReaded += ret;
                        if (ret != pictureParameterSetLength) {
                            printf("pps size: %d, but only read: %d\n", pictureParameterSetLength, ret);
                        }
                    }
                    if (videoFp) {
                        fwrite(nalStart, 1, sizeof(nalStart)/sizeof(char), videoFp);
                        fwrite(spsNal, 1, sequenceParameterSetLength, videoFp);
                        fwrite(nalStart, 1, sizeof(nalStart)/sizeof(char), videoFp);
                        fwrite(ppsNal, 1, pictureParameterSetLength, videoFp);
                        fflush(audioFp);
                        free(spsNal);
                        free(ppsNal);
                    }
                }
            } else {
                if (VIDEOESFILE != NULL) {
                    int bufLen = dataSize - sizeReaded;
                    unsigned char* buf = (unsigned char*) malloc(bufLen);
                    if (buf != NULL) {
                        int ret = fread(buf, 1, bufLen, fp);
                        sizeReaded += ret;
                        if (ret == bufLen) {
                            fwrite(buf, 1, bufLen, videoFp);
                            fflush(audioFp);
                        }
                        free(buf);
                    }
                }
                printf("%-5d| %s dataSize(%d) timestamp(%d) (%s|%s)\n",
                        sequence, type, dataSize, timestamp,
                        videoFrameType[videoData.frameType],
                        videoCodecId[videoData.codecId]);
            }
        } else if (TAG_TYPE_SCRIPT_DATA) {
            enum script_data_type dataType;
            dataType = fgetc(fp);
            sizeReaded++;
            int len = 0;
            len |= fgetc(fp);
            sizeReaded++;
            len <<= 8;
            len |= fgetc(fp);
            sizeReaded++;
            int i;
            for (i = 0; i < len; i++) {
                printf("%c", fgetc(fp));
                sizeReaded++;
            }
            printf("\n");
            dataType = fgetc(fp);
            sizeReaded++;
            if (dataType != EcmaArray) {
                printf("not ecma array after \"onMetadata\"\n");
            } else {
                len = 0;
                for (i = 0; i < 4; i++) {
                    len <<= 8;
                    len |= fgetc(fp);
                    sizeReaded++;
                }
                for (i = 0; i < len; i++) {
                    int len_name = 0;
                    int value_type = 0;
                    int len_value = 0;
                    len_name = 0;
                    len_name |= fgetc(fp); sizeReaded++;
                    len_name <<= 8; len_name |= fgetc(fp); sizeReaded++;
                    int j = 0;
                    for (j = 0; j < len_name; j++) {
                        printf("%c", fgetc(fp));
                        sizeReaded++;
                    }
                    printf(":");
                    value_type = fgetc(fp); sizeReaded++;
                    if (value_type == 0) {
                        len_value = 8;
                        double value = 0.0;
                        double *pV = &value;
                        for (j = 0; j < len_value; j++) {
                            *((char *)pV + (7-j)) = fgetc(fp);
                            sizeReaded++;
                        }
                        printf("%lg\n", value);
                    } else if (value_type == 1) {
                        len_value = 1;
                        char value;
                        value = fgetc(fp); sizeReaded++;
                        printf("%d\n", value);
                    } else if (value_type == 2) {
                        len_value = 0;
                        len_value = fgetc(fp); sizeReaded++;
                        len_value <<= 8; len_value |= fgetc(fp); sizeReaded++;
                        for (j = 0; j < len_value; j++) {
                            printf("%c", fgetc(fp));
                            sizeReaded++;
                        }
                        printf("\n");
                    } else {
                        printf("Unexpected value type:%d\n", value_type);
                    }
                }
                for (i = 0; i < 3; i++) {
                    printf("  0x%02x", fgetc(fp));
                    sizeReaded++;
                }
                printf("\n");
            }
        } else {
            printf("%-5d| %s dataSize(%d) timestamp(%d)\n",
                    sequence, type, dataSize, timestamp);
        }
        //Skip data field and previous tag size field
        fseek(fp, (long)(dataSize-sizeReaded+4), 1);

        tagType = fgetc(fp);
        sequence++;
        //usleep(1000);
    }
    if (fp != NULL) {
        fclose(fp);
    }
    if (audioFp != NULL) {
        fclose(audioFp);
    }
    if (videoFp != NULL) {
        fclose(videoFp);
    }
    if (extraData != NULL) {
        free(extraData);
    }

    return 0;
}
