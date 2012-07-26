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

extern int yylineno;

/* funcs */
int yylex();
void yyerror(char * s);

/* only needed in here */
struct Keyval { Key key; int val; };

/* custom funcs */
struct Keyval * newkeyval(Key k, int v);
Map_t newmap(const struct Keyval * kv);
Sprite_t sprite_append(Sprite_t sprite, char * str);

/*

   Simple "Map"
   Just 4 this parser purpose
   Not Generic , sorry.

*/
#define NMAPKEYS 4
#define MAP_SIZE (sizeof(int)*NMAPKEYS)
#define VAL_UNDEF -1

extern char * map_key_names[];

typedef int * Map_t;

/*  the FOUR horsemen */
typedef enum {
    K_QUANTUM,
    K_TIME,
    K_COLOR,
    K_SPEED,
} Key;

/*  Print a sample map
    (w all textual info from 'map_key_names' */
void puts_map(const Map_t m, int n_pads);

#endif
