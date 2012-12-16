#include<stdio.h>
#include <sys/types.h>
#include <sys/time.h>
struct timeval t_start, t_end;
double t_diff;

int main()
{
    int a = 0, b = 1,i;
    gettimeofday(&t_start,NULL);
    for(i = 1; i<=30000;i+=2) {
        a = b+i;
     if(a%10 == 0) {
            a = b+3;
	    a = b*3;
	    a = b-3;
        } else {
            a = b+5;
	    a = b*5;
	    a = b-5;
        }
    }
    printf("%d",a);
    gettimeofday(&t_end,NULL);
    t_diff = (t_end.tv_sec - t_start.tv_sec) + (double)(t_end.tv_usec - t_start.tv_usec)/1000000;
    printf(" ---  time spent = %.6f  --- \n", t_diff);

    return a;
}
