#include <stdio.h>

#include <apr_general.h>
#include <apr_getopt.h>

int
main(int argc, const char * args[])
{
    apr_initialize();
    printf("Do nada...%s ", "æøå");
    apr_terminate();
    return 0;
}

