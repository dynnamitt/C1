/*
 * =====================================================================================
 *
 *       Filename:  parser-support.h
 *
 *    Description:  All the C stuff used in the Bison part
 *
 *        Version:  1.0
 *        Created:  07/26/2012 08:16:20 AM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  KDM,
 *   Organization:  Dynnamitt.net
 *
 * =====================================================================================
 */
#ifndef _PSUPP_H
#define _PSUPP_H

#include "level.h" /*  need Level_t struct */

extern int yylineno;

/* funcs */
int yylex();
void yyerror(char * s);



/*

   Simple "Map"
   Just 4 this parser purpose
   Not Generic , sorry.

*/
#define NMAPKEYS 4
#define MAP_SIZE (sizeof(int)*NMAPKEYS)
#define VAL_UNDEF -1

extern char * map_key_names[];

typedef int * Map_t; //array

/*  the FOUR horsemen */
typedef enum {
    K_QUANTUM,
    K_TIME,
    K_COLOR,
    K_SPEED,
} Key;

/* ConfigObjects */
extern char * obj_names[];
typedef enum {
    O_TITLE,
    O_DURATION,
    O_SEED,
    O_PLAYER_ATTRIB,
    O_PLAYER_SPRITE,
    O_BADGUY,
    O_SILVER,
    O_FRAME,
    O_BOTTOMLINE,
} Object;


/*  Print a sample map
    (w all textual info from 'map_key_names' */
struct Keyval { Key key; int val; };

/* custom funcs */
struct Keyval * newkeyval(Key k, int v);
Map_t newmap(const struct Keyval * kv);
void puts_map(const Map_t m, int n_pads);
void push(Level_t * lvl,  const Object obj, 
          const char * text, const void * data);

#endif
