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
#include <assert.h>

#include "utils.h"

/*!
 \brief A quick(and naive) TOUPPER func
*/
int string_toupper(char * string)
{
    const char * p = string;
    while(*string) {
        *string = toupper(*string);
	string++;
    }
    return string - p;
}

/*!
 \brief An even better GENERIC char-func
*/
int each_char(char * string, int (*charfunc)(int) )
{
    const char * p = string;

    while(*string) {
        *string = charfunc(*string);
	string++;
    }
    return string - p;
}

/*!
    /brief Insert into string 's' the char 'input' 'multiply' times.

    Inserts \0 after last char inserted 
    or just before len is reached.
*/
void string_ins_char(char * s, int len,
                     const char input, unsigned int multiply)
{
    assert(len > 1 && "Cannot fit a thing in the string");
    assert(multiply > 0 && "multiply must be > 0.");

    int i;
    for(i = 0; i < multiply; i++) {
        if((len - 1) == i) {
            break;
        }
        s[i] = input;
    }
    s[i] = '\0';

}
