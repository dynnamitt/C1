#ifndef _LEVEL_H
#define _LEVEL_H 

#define SPRITE_MAX_ROWS 5

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


/* MapKeys */
extern char * map_key_names[];
typedef enum {
  K_QUANTUM,
  K_TIME,
  K_COLOR,
  K_SPEED,
} Key;

/*

   Color .. TODO: match against ncurses..
*/

extern char * colors[];
typedef enum {
  BLACK,
  RED,
  GREEN,
  YELLOW,
  BLUE,
  MAGENTA,
  CYAN,
  WHITE,
} Color;
/* 
#define COLOR_BLACK	0
#define COLOR_RED	1
#define COLOR_GREEN	2
#define COLOR_YELLOW	3
#define COLOR_BLUE	4
#define COLOR_MAGENTA	5
#define COLOR_CYAN	6
#define COLOR_WHITE	7
*/

/*
    PLAYER
*/
typedef struct {
    Color fresh;
    Color dead;
    int height; /* we seldom use MAX below */
    char * sprite_fresh[SPRITE_MAX_ROWS];
    char * sprite_dead[SPRITE_MAX_ROWS];
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
typedef struct { int len; Badguy_t elems[]; } Badguy_list;

/* SILVER */
typedef struct {
  char * sprite;
  int quantum;
  int time;
  int speed;
  Color color;
} Silver_t;

/* SILVER ARR */
typedef struct { int len; Silver_t elems[]; } Silver_list;

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
  Badguy_list badguy_list;
  Silver_list silver_list;
} Level_t;


#endif
