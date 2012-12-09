#include<stdio.h>

int main()
{
    int a = 0, b = 1;
    for(int i = 0; i<=10;i++) {
        a = a+i;
        if(a%2 == 0) {
            a = a+3;    
        } else {
            a = a+5;
        }
    }
    printf("%d",a);
    return a;
}
