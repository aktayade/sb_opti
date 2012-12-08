#include<stdio.h>

int main()
{
	int a = 10, b = 5, c = 6 , d = 20;
	for(int i=0;i<100;i++)
	{
	if(a == b)
	{
		c= a+b;
	}
	else
	{
		c= a-b;
	}
	if(d == b)
        {
                d= a+b;
        }
        else
        {
                c= a-b;
        }
	if(a == b)
        {
                c= a+b;
        }
        else
        {
                c= a-b;
        }
	}
	printf("%d,%d,%d,%d\n",a,b,c,d);
	return 0;
}
