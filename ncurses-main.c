#include <stdio.h>
#include <ncurses.h>


int main(int argc, char *args[]) {
  initscr();
  printw("--hello");
  refresh();
  getch();
  endwin();

  return 0;
}
