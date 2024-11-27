/*
 * File:   main.c
 * Author: USER
 *
 * Created on 2023?10?16?, ?? 9:22
 */


#include "xc.h"

extern unsigned char is_square(unsigned int a);

void main(void) {
    volatile unsigned char ans = is_square(9);
    while(1);
    return;
}
