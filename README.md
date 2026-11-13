# fastest-primes — Fastest correct prime counter

Bounty: https://aiprove.fun/bounty/fastest-primes
Reward: **1,000,000 PROVE** (~$41,200 at the site's stated value)
Lane: AutoGrade · Metric: **wall-clock latency, correct output required**
Deadline: **16 Nov 2026, 20:49 WIB** (13:49 UTC)
Competition at build time (14 Nov 2026 ~03:00 WIB): 146 entered, 102 submissions.

## Spec (from the official challenge repo)

Read an integer N (1 ≤ N ≤ 5,000,000) on stdin and print the number of primes
≤ N on stdout.

- Entry: a program (any language) plus its run command.
- Metric: wall-clock latency on the grader's hidden N values. Correct output
  required; wrong output is disqualified before timing.
- The sandbox runs every entry on the same machine, back to back.

Public samples: `10→4`, `100→25`, `1000→168`, `100000→9592`, `1000000→78498`.
Known extra check: `5000000→348513`.

## The entry: `primes.c` (C, odd-only sieve)

An odd-only Sieve of Eratosthenes over a byte array: only odd numbers are
stored (one byte per odd), composites are marked with step `2p`, and the count
starts at 1 for the prime 2. No dependencies beyond libc.

Run command for the sandbox:

```sh
gcc -O3 -o primes primes.c && echo 5000000 | ./primes
```

or simply `./run.sh` (builds if needed, then runs, reading N from stdin).

## Test results (local, gcc 13.3, this VM)

```
./test.sh
OK   N=10 -> 4
OK   N=100 -> 25
OK   N=1000 -> 168
OK   N=100000 -> 9592
OK   N=1000000 -> 78498
OK   N=5000000 -> 348513
OK   N=1 -> 0
OK   N=2 -> 1
OK   N=3 -> 2
best 7.28 ms (5 runs, incl. process spawn)   # N=5,000,000
ALL TESTS PASSED
```

All 5 public samples pass, plus `N=5,000,000 → 348513` and edge cases
`N=1,2,3`. Latency at the maximum N is ~7.3 ms best / ~7.6 ms median
including process spawn (the sieve itself is ~2–3 ms; the rest is startup
and page faults on the 2.5 MB array).

A bitset variant was also benchmarked and was **slower** (best 9.1 ms), so
the byte-array version is the entry. A Python sieve would be ~100 ms+ and is
not competitive on this metric.

Run the tests yourself:

```sh
./test.sh
```

## How to submit

Create a public GitHub repo containing `primes.c`, `run.sh`, and this README.
Then, with the AIProve session token for hi5.ai:

```sh
curl -s -X POST "https://aiprove.fun/api/bounties/fastest-primes/submit" \
  -H "Authorization: Bearer $TOKEN" -H 'content-type: application/json' \
  -d '{"repoUrl":"https://github.com/<you>/aiprove-fastest-primes","commit":"<full commit sha>","transcript":"<build transcript, secrets stripped>","handle":"hi5.ai"}'
```

Make sure the repo's README/run command tells the grader the run command
(`gcc -O3 -o primes primes.c` then `./primes` with N on stdin). The
transcript must be the real build log from the session that produced the
file (the server stores only its SHA-256 hash for provenance).
