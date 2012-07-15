#include <stdio.h>
#include <assert.h>
/*#include <stddef.h>*/
#include "level.h"

int 
main( int argc, const char * args[] ) 
{
    int level_size = sizeof( Level_t ); 
    printf( "Size was %d.\n", level_size );

    Badguy_t bad_guys[] = {
	{
	  .sprite = "Y",
	  .speed = 33,
	  .color = YELLOW
	},
	{
	  .sprite = "V",
	  .speed = 22,
	  .color = RED
	}
    };

    Badguy_list * bgl = malloc( sizeof(int) + sizeof(Badguy_t)*2 );
    Badguy_t * bgl_p = malloc( sizeof(Badguy_t)*3 );


    bgl->len = 2;
    bgl->elems[0] = bad_guys[0];
    bgl->elems[1].sprite = "WW" ;

    
    bgl_p[0] = bad_guys[0];
    
    bgl_p[1] = bad_guys[1] ;
    
    bgl_p[2].sprite="w";
    bgl_p[2].color=GREEN;

    bgl_p[3] = bad_guys[1] ; /* bug, check valgrind !! */


    Level_t lvl = { 
      .seed = 1234,
      .time = 240,
      .badguy_list = *bgl
    }; 


    printf( "fun yet?.\n" );
    return 0;
}

