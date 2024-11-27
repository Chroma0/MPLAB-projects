/*
 * File:   bonus.c
 * Author: USER
 *
 * Created on 2023?10?16?, ?? 2:33
 */


#include "xc.h"

extern unsigned int lcm(unsigned int a, unsigned int b);

void main(void) {
    volatile unsigned int ans = lcm(40,140);
    while(1);
    return;
}
