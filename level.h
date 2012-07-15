#define SPRITE_MAX_ROWS 5

/*
   Color
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
  int time; /* lasting seconds */
  int seed; /* predictable random departure */
  Player_t player; 
  Badguy_list badguy_list;
  Silver_list silver_list;
} Level_t;



