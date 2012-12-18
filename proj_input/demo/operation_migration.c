#include<stdio.h>
#include <time.h>

int main()
{
    register int a=0,b,c = 10;    
    b = 10+c;
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
