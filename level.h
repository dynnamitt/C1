#ifndef _LEVEL_H
#define _LEVEL_H 1

#define SPRITE_MAX_ROWS 5

/* ConfigObjects */
#define CO_TITLE 0
#define CO_DURATION 1
#define CO_SEED 2
#define CO_PLAYER_ATTRIB 3
#define CO_PLAYER_SPRITE 4
#define CO_BADGUY 5
#define CO_SILVER 6
#define CO_FRAME 7
#define CO_BOTTOMLINE 8


/* MapKeys */
#define K_QUANTUM 0
#define K_TIME 1
#define K_COLOR 2
#define K_SPEED 3

/*

   Color .. TODO: match against ncurses..
*/
typedef enum {
    BLACK,
    WHITE,
    YELLOW,
    BLUE,
    GREEN,
    RED,
    ETC   
} Color;

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
