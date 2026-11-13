#!/bin/sh
# Test against public cases + known pi(5,000,000)=348513
set -e
cd "$(dirname "$0")"
[ -x ./primes ] || gcc -O3 -o primes primes.c
check() {
  got=$(echo "$1" | ./primes)
  if [ "$got" = "$2" ]; then echo "OK   N=$1 -> $got"; else echo "FAIL N=$1 -> $got expected $2"; exit 1; fi
}
check 10 4
check 100 25
check 1000 168
check 100000 9592
check 1000000 78498
check 5000000 348513
check 1 0
check 2 1
check 3 2
echo "--- timing (N=5,000,000, best of 3) ---"
python3 -c "
import subprocess, time
ts=[]
for _ in range(5):
    t=time.perf_counter()
    subprocess.run(['./primes'], input=b'5000000', capture_output=True, check=True)
    ts.append(time.perf_counter()-t)
print(f'best {min(ts)*1000:.2f} ms (5 runs, incl. process spawn)')
"
echo "ALL TESTS PASSED"
