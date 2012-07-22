#ifndef _LEVEL_H
#define _LEVEL_H


typedef char ** Sprite_t;

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


/* Simple "Maps" */
#define NMAPKEYS 4
#define VAL_UNDEF -1

extern char * map_key_names[];

typedef int * Map_t;
typedef enum {
    K_QUANTUM,
    K_TIME,
    K_COLOR,
    K_SPEED,
} Key;

/*  Print a sample map
    (w all textual info from 'map_key_names' */
void lvl_puts_map(Map_t m, int n_pads);

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
typedef struct {
    Color fresh;
    Color dead;
    int height; /* we seldom use MAX below */
    Sprite_t sprite_fresh;
    Sprite_t sprite_dead;
} Player_t;

/*
    BADGUY
*/
typedef struct {
    char * sprite;
    int speed;
    Color color;
} Badguy_t;

/* BADGUY ARR */
typedef struct { int len; Badguy_t elems[]; } Badguy_varr;

/* SILVER */
typedef struct {
    char * sprite;
    int quantum;
    int time;
    int speed;
    Color color;
} Silver_t;

/* SILVER ARR */
typedef struct { int len; Silver_t elems[]; } Silver_varr;

/*
   SILVER,
   FRAME,
   BOTTOMLINE
*/

/*
    LEVEL
*/
typedef struct {
    int duration; /* lasting seconds */
    int seed; /* predictable random departure */
    Player_t player;
    Badguy_varr badguy_varr;
    Silver_varr silver_varr;
} Level_t;


#endif
