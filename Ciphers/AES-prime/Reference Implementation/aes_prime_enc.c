// AES-prime encryption for p=2^7-1

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

const uint8_t Rcon[14] = {0x01, 0x03, 0x09, 0x1B, 0x51, 0x74, 0x5E, 0x1C, 0x54, 0x7D, 0x79, 0x6D, 0x49, 0x5C};

void KeyExpansion(uint8_t* RoundKey, const uint8_t* Key)
{
    for(int i=0; i<4; i++)
    {
        RoundKey[(i*4)+0] = Key[(i*4)+0];
        RoundKey[(i*4)+1] = Key[(i*4)+1];
        RoundKey[(i*4)+2] = Key[(i*4)+2];
        RoundKey[(i*4)+3] = Key[(i*4)+3];
    }

    for(int i=4; i<60; i++)
    {
        uint8_t intermediate[4];
        intermediate[0] = RoundKey[(i-1)*4+0];
        intermediate[1] = RoundKey[(i-1)*4+1];
        intermediate[2] = RoundKey[(i-1)*4+2];
        intermediate[3] = RoundKey[(i-1)*4+3];

        if (i%4==0)
        {
            uint8_t tmp = intermediate[0];
            intermediate[0] = intermediate[1];
            intermediate[1] = intermediate[2];
            intermediate[2] = intermediate[3];
            intermediate[3] = tmp;

            intermediate[0] = (((intermediate[0]*intermediate[0])%127)*((intermediate[0]*intermediate[0])%127)*intermediate[0]+2)%127;
            intermediate[1] = (((intermediate[1]*intermediate[1])%127)*((intermediate[1]*intermediate[1])%127)*intermediate[1]+2)%127;
            intermediate[2] = (((intermediate[2]*intermediate[2])%127)*((intermediate[2]*intermediate[2])%127)*intermediate[2]+2)%127;
            intermediate[3] = (((intermediate[3]*intermediate[3])%127)*((intermediate[3]*intermediate[3])%127)*intermediate[3]+2)%127;
            intermediate[0] = (intermediate[0]+Rcon[i/4-1])%127;
        }

        RoundKey[i*4+0] = (RoundKey[(i-4)*4+0]+intermediate[0])%127;
        RoundKey[i*4+1] = (RoundKey[(i-4)*4+1]+intermediate[1])%127;
        RoundKey[i*4+2] = (RoundKey[(i-4)*4+2]+intermediate[2])%127;
        RoundKey[i*4+3] = (RoundKey[(i-4)*4+3]+intermediate[3])%127;
    }
}

void AddRoundKey(uint8_t round, uint8_t** state, const uint8_t* RoundKey)
{
    for(int i=0; i<4; i++)
        for(int j=0; j<4; j++)
            state[i][j] = (state[i][j]+RoundKey[(round*16)+(i*4)+j])%127;
}

void SubBytes(uint8_t** state)
{
    for(int i=0; i<4; i++)
        for(int j=0; j<4; j++)
            state[i][j] = (((state[i][j]*state[i][j])%127)*((state[i][j]*state[i][j])%127)*state[i][j]+2)%127;
}

void ShiftRows(uint8_t** state)
{
    uint8_t tmp = state[0][1];
    state[0][1] = state[1][1];
    state[1][1] = state[2][1];
    state[2][1] = state[3][1];
    state[3][1] = tmp;

    tmp = state[0][2];
    state[0][2] = state[2][2];
    state[2][2] = tmp;

    tmp = state[1][2];
    state[1][2] = state[3][2];
    state[3][2] = tmp;

    tmp = state[0][3];
    state[0][3] = state[3][3];
    state[3][3] = state[2][3];
    state[2][3] = state[1][3];
    state[1][3] = tmp;
}

uint8_t Mul2(uint8_t x)
{
    return ((x&0x3F)<<1)^((x>>6)&1);
}

uint8_t Mul4(uint8_t x)
{
    return Mul2(Mul2(x));
}

uint8_t Mul16(uint8_t x)
{
    return Mul4(Mul4(x));
}

void MixColumns(uint8_t** state)
{
    for(int i=0; i<4; i++)
    {
        uint8_t s0 = state[i][0];
        uint8_t s1 = state[i][1];
        uint8_t s2 = state[i][2];
        uint8_t s3 = state[i][3];
        state[i][0] = (s0+s1+s2+s3)%127;
        state[i][1] = (s0+Mul2(s1)+Mul4(s2)+Mul16(s3))%127;
        state[i][2] = (s0+Mul4(s1)+Mul16(s2)+Mul2(s3))%127;
        state[i][3] = (s0+Mul16(s1)+Mul2(s2)+Mul4(s3))%127;
    }
}

int Encrypt(uint8_t *Plaintext, const uint8_t* Key, uint8_t *Ciphertext)
{
    uint8_t **state;
    state = (uint8_t**)calloc(4, sizeof(uint8_t*));

    if(state == NULL) return -1;

    for(int i=0; i<4; i++)
    {
        state[i] = (uint8_t*)calloc(4, sizeof(uint8_t));
        if(state[i] == NULL) return -1;

        for(int j=0; j<4; j++)
            state[i][j] = Plaintext[i*4+j];
    }

    uint8_t *RoundKey;
    RoundKey = (uint8_t*)calloc(240, sizeof(uint8_t));
    if(RoundKey == NULL) return -1;

    KeyExpansion(RoundKey, Key);

    AddRoundKey(0, state, RoundKey);
    for(int i=1; i<15; i++)
    {
        SubBytes(state);
        ShiftRows(state);
        if(i != 14)MixColumns(state);
        AddRoundKey(i, state, RoundKey);
    }

    for(int i=0; i<4; i++)
        for(int j=0; j<4; j++)
            Ciphertext[i*4+j] = state[i][j];

    return 1;
}

int main()
{
    uint8_t plaintext[16] = {0x52, 0x30, 0x34, 0x67, 0x37, 0x0d, 0x0e, 0x27, 0x24, 0x57, 0x48, 0x62, 0x7b, 0x6f, 0x7b, 0x19};
    uint8_t key[16] = {0x2d, 0x60, 0x05, 0x6d, 0x3b, 0x2e, 0x0c, 0x1e, 0x15, 0x2a, 0x6b, 0x55, 0x07, 0x11, 0x10, 0x26};
    uint8_t ciphertext[16];

    if(Encrypt(plaintext, key, ciphertext))
    {
        for(int i=0; i<16; i++)
        {
            printf("0x%02X, ", ciphertext[i]);
        }
    }

    printf("\n");
    return 0;
}
