/*
 * =====================================================================================
 *
 *       Filename:  parser-support.c
 *
 *    Description:  Impl part of support
 *
 *        Version:  1.0
 *        Created:  07/26/2012 08:31:37 AM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  KDM,
 *   Organization:  Dynnamitt.net
 *
 * =====================================================================================
 */
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>


char * map_key_names[] = { "Quantum", "Time", "Color", "Speed",
                           NULL
                         };

void push(Object obj, char * text, void * data)
{
    switch(obj) {

    }
}



void yyerror(char * s)
{
    fprintf(stderr, "At lineno %d, ", yylineno);
    fprintf(stderr, "an ERROR, msg: '%s'\n", s);
    exit(-1);
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

/*
    kv data-struct
   */
struct Keyval * newkeyval(Key k, int v)
{
    struct Keyval * kv = malloc( sizeof(struct Keyval) );
    assert(kv && "Cannot create Keyval var.");
    kv->key = k;
    kv->val = v;
    return kv;
}

/* create, init and set a new "map" */
Map_t newmap(const struct Keyval * kv)
{
    // create
    Map_t m = malloc( MAP_SIZE ) ; 
    assert(m && "Cannot create Map_t var.");	
    int i;

    // init
    for( i = 0; i < NMAPKEYS; i++ ) {
	    m[i] = VAL_UNDEF;
    }

    // set
    if( kv != NULL) {    
        m[kv->key] = kv->val;
    }

    return (int*)m;
}


/*!
    
    /brief For debugging
    
*/
void puts_map(const Map_t m, int n_pads)
{
    int i;
    char padding[MAX_SPACES] = ""; /* mutable string */

    if(n_pads > 0) {
        string_ins_char(padding, MAX_SPACES, ' ', n_pads);
    }

    for(i = 0; i < NMAPKEYS; i++) {
        int v = m[i];
        if(v != VAL_UNDEF) {
            if(K_COLOR != i) {
                printf("%s%7s : %d\n", padding, map_key_names[i], v);
            } else {
                printf("%s%7s : %s\n", padding, map_key_names[i], colors[v]);
            }
        }
    }
}
