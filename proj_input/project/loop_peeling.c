#include<stdio.h>


int main()
{
    int a = 0, b = 1,i;
    for(i = 0; i<=100;i++) {
        a = a+i;
     if(a%10 == 0) {
            a = a+3;   
        } else {
            a = a+5;
        }

    }
    printf("%d",a);
    return a;
}

/*
int main()
{
    int a = 0, b = 1,i;
    for(i = 0; i<=100;i++) {
        a = a+i;
     if(1) {
            a = a+3;   
        } else {
            a = a+5;
        }

    }
    printf("%d",a);
    return a;
}
*/
