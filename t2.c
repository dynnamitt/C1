#include <stdio.h>

#include <apr-1.0/apr_general.h>
#include <apr-1.0/apr_getopt.h>

int
main(int argc, const char * args[])
{
    apr_initialize();
    printf("Do nada...%s ", "æøå");
    apr_pool_t * pool;


    apr_terminate();

    return 0;
}

