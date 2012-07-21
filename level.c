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
#include <string.h>
#include "level.h"
#include "utils.h"

char * map_key_names[] = { "quantum", "time", "color", "speed", NULL };

char * obj_names[] = { "title", "duration", "seed", "player_attrib",
                       "player_sprite", "badguy", "silver", "frame",
                       "bottomline", NULL
                     };

char * colors[] = { "BLACK", "RED", "GREEN", "YELLOW",
                    "BLUE", "MAGENTA", "CYAN", "WHITE",
                    NULL
                  };

Color color_lookup(const char * string)
{
    Color color = -1;
    char ** p;
    char * ucase_str = strdup(string);
    each_char( ucase_str, toupper );

    for(p = colors; *p != NULL; p++) {
        if(strcmp(*p , ucase_str) == 0) {
	    color = (Color)(*p - string);
	    break;
        }
    }

    free(ucase_str);
    return color;
}
