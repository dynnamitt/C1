/*
 * =====================================================================================
 *
 *       Filename:  utils.h
 *
 *    Description:  Small utils DOH
 *
 *        Version:  1.0
 *        Created:  07/21/2012 10:14:47 AM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  KDM (), 
 *   Organization:  Dynnamitt.net
 *
 * =====================================================================================
 */
#ifndef _UTILS_H
#define _UTILS_H

int string_toupper(char * string);
int each_char(char * string, int (*charfunc)(int));
void string_ins_char(char * s, unsigned int len,
                     const char input, unsigned int multiply);


#endif
