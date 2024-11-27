/*
 * File:   advance.c
 * Author: USER
 *
 * Created on 2023?10?16?, ?? 10:21
 */


#include "xc.h"

extern unsigned int multi_signed(unsigned char a, unsigned char b);

void main(void) {
    volatile unsigned int res = multi_signed(-30,8);
    while(1);
    return;
}
