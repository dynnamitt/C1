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
#include <assert.h>

#include "level.h"
#include "utils.h"

#define MAX_SPACES 40



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

//! \brief Not quite clever shit yet
Sprite_t sprite_append(Sprite_t sprite, char * str)
{
    assert(sprite && "Cannot handle NULL ptr."
           " Need atleast one elem pointing to a NULL string");

    Sprite_t start_p = sprite;
    int len = 1;

    if(*sprite != NULL) {
        /* nav to NULL */
        while(*sprite) {
            ++sprite;
        }

        len += sprite - start_p;
    }

    *sprite = str; /* set str into LAST elem */

    ++len; /* VERY IMP! */

    size_t sz = SPRITE_SIZE * (len) ;

    Sprite_t realloced_ptr = (Sprite_t)realloc(start_p, sz);

    assert(realloced_ptr && "Cannot expand var.");

    realloced_ptr[len - 1] = NULL;
    return realloced_ptr;
}

void lvl_puts_level(const Level_t * lvl)
{

}

void lvl_puts_sprite(const Sprite_t sprite, int n_pads)
{
    char padding[MAX_SPACES] = ""; /* mutable string */
    if(n_pads > 0) {
        string_ins_char(padding, MAX_SPACES, ' ' , n_pads);
    }

    Sprite_t ptr = sprite;
    while(*ptr) {
        printf("%s%s\n", padding, *ptr);
        ptr++;
    }

}



