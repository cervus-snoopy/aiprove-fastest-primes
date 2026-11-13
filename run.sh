#!/bin/sh
# Run command for the AIProve sandbox: build (if needed) then run.
# Usage: ./run.sh  (reads N from stdin, prints prime count)
cd "$(dirname "$0")"
[ -x ./primes ] || gcc -O3 -o primes primes.c
exec ./primes
