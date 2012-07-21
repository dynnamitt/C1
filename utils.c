/*
 * =====================================================================================
 *
 *       Filename:  utils.c
 *
 *    Description:  The IMPL file for UTILS, DOH
 *
 *        Version:  1.0
 *        Created:  07/21/2012 10:15:58 AM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  KDM,
 *   Organization:  Dynnamitt.net
 *
 * =====================================================================================
 */
#include <stdlib.h>
#include <ctype.h>

#include "utils.h"

/*!
 \brief A quick TOUPPER func
*/
int string_toupper(char * string)
{
    const char * p = string;
    while(*string++) {
        *string = toupper(*string);
    }
    return string - p;
}

/*!
 \brief An even better char-func loop
*/
int each_char(char * string, int (*charfunc)(int) )
{
    const char * p = string;
    while(*string++) {
        *string = charfunc(*string);
    }
    return string - p;
}



