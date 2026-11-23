#!/usr/bin/env python3
"""Independent check of the Z/17 counterexample to the Sturmfels-Sullivant degree bound.
Reads only the two tables A, B from the JSON file; everything else is recomputed here.
Enumerates EVERY multiset of zero-sum triples over Z/17 with the same column multisets."""
import json, sys, collections
d = json.load(open(sys.argv[1])); m = d["modulus"]; A = [tuple(r) for r in d["A"]]; B = [tuple(r) for r in d["B"]]
assert m == 17 and len(A) == len(B) == 18
assert all(sum(r) % m == 0 and all(0 <= x < m for x in r) for r in A + B), "rows must be zero-sum"
col = lambda T, i: collections.Counter(r[i] for r in T)
assert all(col(A, i) == col(B, i) for i in range(3)), "tables not compatible"
print("zero-sum rows: ok; compatible (equal column multisets): ok")
print("row supports disjoint:", not (set(A) & set(B)))
need = [col(A, i) for i in range(3)]
cands = sorted((a, b, (-a - b) % m) for a in need[0] for b in need[1] if (-a - b) % m in need[2])
print("candidate zero-sum rows with entries in the column supports:", len(cands))
sols = []
rem = [dict(c) for c in need]
def dfs(k, left, cur):
    if left == 0:
        if all(v == 0 for c in rem for v in c.values()): sols.append(tuple(cur))
        return
    if k == len(cands): return
    a, b, c = cands[k]
    mx = min(rem[0][a], rem[1][b], rem[2][c], left)
    for t in range(mx, -1, -1):
        rem[0][a] -= t; rem[1][b] -= t; rem[2][c] -= t
        # prune: remaining candidates must be able to cover remaining demand of each symbol
        ok = True
        if ok: dfs(k + 1, left - t, cur + [(cands[k], t)] if t else cur)
        rem[0][a] += t; rem[1][b] += t; rem[2][c] += t
dfs(0, 18, [])
print("number of multisets in the fibre:", len(sols))
asM = lambda T: tuple(sorted(collections.Counter(T).items()))
found = {tuple(sorted(s)) for s in sols}
print("fibre == {A, B}:", found == {asM(A), asM(B)})
