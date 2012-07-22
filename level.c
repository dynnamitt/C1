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
#include <stdio.h>
#include <string.h>
#include "level.h"
#include "utils.h"

#define MAX_SPACES 40

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

    char * ucase_k = strdup(k);
    each_char(ucase_k, toupper);

    char ** p;
    int idx = 0;
    for(p = colors; *p != NULL; p++, idx++) {
        /*printf("has %s == %s \n", *p, ucase_k);*/
        if(strcmp(*p , ucase_k) == 0) {
            color = (Color)idx;
            break;
        }
    }

    free(ucase_k);
    return color;
}


void lvl_puts_map(Map_t m, int n_pads)
{
    int i;
    char padding[MAX_SPACES] = "";

    if(n_pads > 0) {
        string_ins_char(padding, MAX_SPACES, ' ', n_pads);
    }

    for(i = 0; i < NMAPKEYS; i++) {
        if(m[i] != VAL_UNDEF) {
            if(K_COLOR != i) {
                printf("%s%7s : %d\n", padding, map_key_names[i], m[i]);
            } else {
                printf("%s%7s : %s\n", padding, map_key_names[i], colors[i]);
            }
        }
    }
}

