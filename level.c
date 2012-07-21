/*
 * =====================================================================================
 *
 *       Filename:  level.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  07/21/2012 10:35:09 AM
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
/*#include <stdio.h>*/
#include <string.h>
#include "level.h"
#include "utils.h"

char * map_key_names[] = { "Quantum", "Time", "Color", "Speed", NULL };

char * obj_names[] = { "Title", "Duration", "Seed", "PlayerAttrib",
                       "PlayerSprite", "Badguy", "Silver", "Frame",
                       "Bottomline", NULL
                     };

char * colors[] = { "BLACK", "RED", "GREEN", "YELLOW",
                    "BLUE", "MAGENTA", "CYAN", "WHITE",
                    NULL
                  };

Color color_lookup(const char * k)
{
    Color color = COLOR_NONE;
    char ** p;
    char * ucase_k = strdup(k);
    each_char(ucase_k, toupper);

    int idx = 0;
    for(p = colors; *p != NULL; p++, idx++ ) {
        /*printf("has %s == %s \n", *p, ucase_k);*/
        if(strcmp(*p , ucase_k) == 0) {
            color = (Color)idx;
            break;
        }
    }

    free(ucase_k);
    return color;
}
