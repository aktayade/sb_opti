// test 4:  has conflict, USES of LOAD also should be removed
#include "stdio.h"

int a[100];
int b[100];

int main()
{
		int x = 0,i;
		int *ptra = a;

		for (i=0;i<100;i++){
			a[i] = i;
		}

		for (i=0;i<100;i++){
			if (a[i] > 95){ 
				a[i+1] = 1;
			}
			b[i] = (a[97]+5)*3 ;
	  }
		printf ("%d, %d, %d\n",b[97],b[98],b[99]);
	  return 0;
}
