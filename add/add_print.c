/**
 * @file add.c
 * @author your name (you@domain.com)
 * @brief 
 * @version 0.1
 * @date 2018-10-30
 * 
 * @copyright Copyright (c) 2018
 * 
 */
#include <stdio.h>
#include "add.h"
/**
 * @brief 
 * 
 * @param x 
 * @param y 
 * @return int 
 */
int add_print(int x, int y)
{
    int ret = add(x,y);
    printf("%d + %d = %d\n",x,y,ret);
    return ret;
}