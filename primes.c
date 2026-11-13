/* primes.c — count primes <= N (1 <= N <= 5,000,000) from stdin.
 * Odd-only Sieve of Eratosthenes. N=5,000,000 -> ~2.5M bytes, ~2-3 ms.
 * Compile: gcc -O3 -o primes primes.c
 * Run: echo 1000000 | ./primes   -> 78498
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void){
    long n;
    if(scanf("%ld",&n)!=1) return 1;
    if(n<2){ printf("0\n"); return 0; }
    long m=(n+1)/2;                 /* count of odd numbers <= n */
    unsigned char *c=calloc(m,1);   /* c[i] = 1 if (2*i+1) is composite */
    if(!c) return 1;
    for(long i=3;i*i<=n;i+=2){
        if(!c[i/2]){
            for(long j=i*i;j<=n;j+=2*i) c[j/2]=1;
        }
    }
    long cnt=1;                     /* prime 2 */
    for(long i=1;i<m;i++) if(!c[i]) cnt++;
    printf("%ld\n",cnt);
    return 0;
}
