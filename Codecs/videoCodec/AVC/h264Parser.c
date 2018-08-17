#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef enum NALU_TYPE {
    NALU_TYPE_SLICE = 1,
    NALU_TYPE_DPA,
    NALU_TYPE_DPB,
    NALU_TYPE_DPC,
    NALU_TYPE_IDR,
    NALU_TYPE_SEI,
    NALU_TYPE_SPS,
    NALU_TYPE_PPS,
    NALU_TYPE_AUD,
    NALU_TYPE_EOSEQ,
    NALU_TYPE_EOSTREAM,
    NALU_TYPE_FILL,
} NaluType;

const char *nalu_type[] = {
    "not defined",
    "SLICE",
    "DPA",
    "DPB",
    "DPC",
    "IDR",
    "SEI",
    "SPS",
    "PPS",
    "AUD",
    "EOSEQ",
    "EOSTREAM",
    "FILL",
};

typedef enum {
    NALU_PRIORITY_DISPOSABLE = 0,
    NALU_PRIRITY_LOW,
    NALU_PRIORITY_HIGH,
    NALU_PRIORITY_HIGHEST,
} NaluPriority;
const char *nalu_priority[] = {
    "DISPOSABLE",
    "LOW",
    "HIGH",
    "HIGHEST"
};

typedef struct _NaluData {
    int num;
    int pos;
    int size;
    NaluType type;
    NaluPriority priority;
    struct _NaluData *next;
} NaluData;

NaluData *parseNalu(FILE *fp) {
    int sizeReaded = 0;
    int num = 0;
    unsigned char startCode[4] = {0xff};
    NaluData * pHead = NULL;
    NaluData * pTail = NULL;
    NaluData * pCur = NULL;
    int ret = fread(startCode, 1, 4, fp);
    sizeReaded += ret;
    while (ret == 4) {
        if (startCode[0] == 0
                && startCode[1] == 0
                && startCode[2] == 1) {
            if (pCur == NULL) {
                pCur = (NaluData *) malloc(sizeof(NaluData));
                if (pCur == NULL) {
                    printf("Failded malloc a NaluData");
                    break;
                }
                memset(pCur, 0, sizeof(NaluData));
                unsigned char data = startCode[3];
                fseek(fp, (long) -1, 1); sizeReaded--;
                pCur->num = num++;
                pCur->pos = sizeReaded-3;
                pCur->type = data & 0x1f; //lower 5bit
                pCur->priority = (data & 0x60) >> 5; //2bit
                ret = fread(startCode, 1, 4, fp);
                sizeReaded += ret;
            } else {
                pCur->size = sizeReaded - 3 - pCur->pos;
                pCur->next = NULL;
                if (pHead == NULL) {
                    pHead = pTail = pCur;
                } else {
                    pTail->next = pCur;
                    pTail = pCur;
                }
                pCur = NULL;
            }
        } else if (startCode[0] == 0
                && startCode[1] == 0
                && startCode[2] == 0
                && startCode[3] == 1) {
            if (pCur == NULL) {
                pCur = (NaluData *) malloc(sizeof(NaluData));
                if (pCur == NULL) {
                    printf("Failded malloc a NaluData");
                    break;
                }
                memset(pCur, 0, sizeof(NaluData));
                pCur->num = num++;
                pCur->pos = sizeReaded-4;
                unsigned char data = fgetc(fp); fseek(fp, (long)-1, 1);
                pCur->type = data & 0x1f; //lower 5bit
                pCur->priority = (data & 0x60) >> 5; //2bit
                ret = fread(startCode, 1, 4, fp);
                sizeReaded += ret;
            } else {
                pCur->size = sizeReaded - 4 - pCur->pos;
                pCur->next = NULL;
                if (pHead == NULL) {
                    pHead = pTail = pCur;
                } else {
                    pTail->next = pCur;
                    pTail = pCur;
                }
                pCur = NULL;
            }
        } else {
            int rewind = 0;
            while (rewind < 4 && startCode[3 - rewind] == 0) {
                rewind++;
            }
            sizeReaded -= rewind;
            fseek(fp, (long) (0-rewind), 1);
            ret = fread(startCode, 1, 4, fp);
            sizeReaded += ret;
        }
    }
    return pHead;
}


int main(int argc, const char *args[]) {
    if (argc < 2) {
        printf("Please specify the h264 file\n");
    }
    FILE *fp = fopen(args[1], "rb");
    if (fp == NULL) {
        printf("Failed to open %s\n", args[1]);
        return 1;
    }

    printf("-----+-------- NALU Table ------+---------+\n");
    printf(" NUM |    POS  |    IDC |  TYPE |   LEN   |\n");
    printf("-----+---------+--------+-------+---------+\n");

    NaluData * head = NULL;

    head = parseNalu(fp);
    NaluData *tmp = NULL;
    while (head) {
        printf("%5d|%9d|%8s|%7s|%9d|\n",
                head->num, head->pos, nalu_priority[head->priority], nalu_type[head->type], head->size);
        tmp = head->next;
        free(head);
        head = tmp;

    }

    if (fp != NULL) {
        fclose(fp);
    }
    return 0;
}
