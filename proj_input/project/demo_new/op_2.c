#include<stdio.h>
#include <sys/types.h>
#include <sys/time.h>

struct timeval t_start, t_end;
double t_diff;

int main(int argc, char* argv[])
{
	int x = atoi(argv[1]),y=0;
	int i = 0;
	gettimeofday(&t_start,NULL);
	for(i=0;i<10000;i++){
		y+=func(x);
	}
	printf("In main : %d",y);
	gettimeofday(&t_end,NULL);
	t_diff = (t_end.tv_sec - t_start.tv_sec) + (double)(t_end.tv_usec - t_start.tv_usec)/1000000;
        printf(" ---  time spent = %.6f  --- \n", t_diff);

}

int func(int x)
{
    register int a=0,b=0,aa,bb,aaa,bbb;
    int c = x + 10;
    int d = x +3;
	int cc = x + 100;
    int dd = x +30;
int cccc = x + 1000;
    int dddd = x +300;

    if(c == 0){
        a = 10*c;
        b = 4*d;
	aa = 10*cc;
        bb = 4*dd;
	aaa = 10*cccc;
        bbb = 4*dddd;

	
    } else {
        a = 20*c;
	b = 6 * d;
	aa = 10*cc;
        bb = 4*dd;
	aaa = 10*cccc;
        bbb = 4*dddd;

    }
    if(rand() % 99 == 0) {
    //    printf("%d",b);
    } else {
        printf("In else: %d,%d,%d,%d,%d,%d",a,b,aa,bb,aaa,bbb);
    }
}


/*int main(int argc, char* argv[])
{
    register int a=0,b;
    int x = atoi(argv[1]),y=0;
    int c = x + 10;
    if(c == 0){
        a = 10*c;
    } else {
        a = 20*c;
    }
    if(rand() % 2 == 0) {
        printf("%d",b);
    } else {
        printf("In else: %d,%d",a,b);
    }
}
*/
