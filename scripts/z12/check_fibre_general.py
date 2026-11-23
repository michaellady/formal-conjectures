#!/usr/bin/env python3
"""Independent exhaustive fibre check for a claimed two-table counterexample over Z/m, 3 leaves.
Written separately from the scripts that found the examples; reads only the two tables."""
import json, sys, collections
d = json.load(open(sys.argv[1])); m = d["modulus"]
def expand(T): return [tuple(r) for r, k in T for _ in range(k)]
A, B = expand(d["A"]), expand(d["B"])
assert len(A) == len(B)
assert all(len(r) == 3 and sum(r) % m == 0 and all(0 <= x < m for x in r) for r in A + B), "rows must be zero-sum"
col = lambda T, i: collections.Counter(r[i] for r in T)
assert all(col(A, i) == col(B, i) for i in range(3)), "tables not compatible"
need = [col(A, i) for i in range(3)]
cands = sorted((a, b, (-a - b) % m) for a in need[0] for b in need[1] if (-a - b) % m in need[2])
rem = [dict(c) for c in need]; sols = []
def dfs(k, left, cur):
    if left == 0:
        if all(v == 0 for c in rem for v in c.values()): sols.append(tuple(cur))
        return
    if k == len(cands): return
    a, b, c = cands[k]
    for t in range(min(rem[0][a], rem[1][b], rem[2][c], left), -1, -1):
        rem[0][a] -= t; rem[1][b] -= t; rem[2][c] -= t
        dfs(k + 1, left - t, cur + [(cands[k], t)] if t else cur)
        rem[0][a] += t; rem[1][b] += t; rem[2][c] += t
dfs(0, len(A), [])
asM = lambda T: tuple(sorted(collections.Counter(T).items()))
print(f"Z/{m}: rows per table={len(A)}  zero-sum+compatible: ok  common rows: {len(set(A) & set(B))}  "
      f"admissible row types: {len(cands)}  fibre size: {len(sols)}  fibre=={{A,B}}: {set(map(lambda s: tuple(sorted(s)), sols)) == {asM(A), asM(B)}}  "
      f"=> degree {len(A)} {'>' if len(A) > m else '<='} |G|={m}")
