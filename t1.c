#include <zmq.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>

int main (void)
{
	void *ctx = zmq_init (1);

	printf("Do nada...");
	zmq_term (ctx);
	return 0;
}
