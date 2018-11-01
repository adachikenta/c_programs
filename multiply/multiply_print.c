/**
 * @file multiply.c
 * @author your name (you@domain.com)
 * @brief 
 * @version 0.1
 * @date 2018-10-30
 * 
 * @copyright Copyright (c) 2018
 * 
 */
#include <stdio.h>
#include <multiply.h>
/**
 * @brief 
 * 
 * @param x 
 * @param y 
 * @return int 
 */
int multiply_print(int x, int y)
{
    int ret = multiply(x,y);
    printf("%d * %d = %d\n",x,y,ret);
    return ret;
}
