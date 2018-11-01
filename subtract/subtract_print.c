/**
 * @file subtract.c
 * @author your name (you@domain.com)
 * @brief 
 * @version 0.1
 * @date 2018-10-30
 * 
 * @copyright Copyright (c) 2018
 * 
 */
#include <stdio.h>
#include "subtract.h"
/**
 * @brief 
 * 
 * @param x 
 * @param y 
 * @return int 
 */
int subtract_print(int x, int y)
{
    int ret = subtract(x,y);
    printf("%d - %d = %d\n",x,y,ret);
    return ret;
}
