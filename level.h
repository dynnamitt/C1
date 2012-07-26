#ifndef _LEVEL_H
#define _LEVEL_H

#define SPRITE_SIZE sizeof(char**) 
typedef char **Sprite_t;

Sprite_t sprite_append(Sprite_t sprite, char * str);
void lvl_puts_sprite(const Sprite_t sprite, int n_pads);




/* Color ... */
extern char * colors[];
typedef enum {
    COLOR_NONE = -1,
    BLACK = 0,
    RED,
    GREEN,
    YELLOW,
    BLUE,
    MAGENTA,
    CYAN,
    WHITE,
} Color;
/* Func to find the ENUM int from a string */
Color color_lookup(const char * string);

/*
    PLAYER
*/
typedef struct Player_t {
    Color fresh;
    Color dead;
    int height; /* just to speed things up */
    Sprite_t sprite_fresh;
    Sprite_t sprite_dead;
} Player_t;

/*
    BADGUY
*/
typedef struct Badguy_t {
    char * sprite;
    int speed;
    Color color;
} Badguy_t;

/* BADGUY VARARR */
typedef struct Badguy_varr { int len; Badguy_t elems[]; } Badguy_varr;

/* SILVER */
typedef struct Silver_t {
    char * sprite;
    int quantum;
    int time;
    int speed;
    Color color;
} Silver_t;

/* SILVER VARARR */
typedef struct Silver_varr { int len; Silver_t elems[]; } Silver_varr;

/*
   SILVER,
   FRAME,
   BOTTOMLINE
*/

/*
    LEVEL
*/

typedef struct Level_t {
    char * title;
    int duration; /* lasting seconds */
    int seed; /* predictable random departure */
    char * bottomline;
    Player_t * player;
    Badguy_varr * badguys;
    Silver_varr * silvers;
} Level_t;

void lvl_puts_level(const Level_t * lvl);

#endif
