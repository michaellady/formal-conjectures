# Independent re-derivation of the Z/17 claims (own code; reads only the JSON data file as data).
import json, sys, itertools
from fractions import Fraction
from collections import Counter
import sympy as sp
d = json.load(open(sys.argv[1]))
n = d["modulus"]; A = [tuple(r) for r in d["A"]]; B = [tuple(r) for r in d["B"]]
assert len(A)==len(B)==18 and all(sum(r)%n==0 for r in A+B)
mA=[Counter(r[j] for r in A) for j in range(3)]; mB=[Counter(r[j] for r in B) for j in range(3)]
print("margins equal:", mA==mB, " disjoint supports:", not(set(A)&set(B)))
S=[sorted(mA[j]) for j in range(3)]
E=sorted(r for r in itertools.product(*S) if sum(r)%n==0)
print("sizes", [len(s) for s in S], "allowed types", len(E))
M=sp.Matrix([[int(r[j]==v) for r in E] for j in range(3) for v in S[j]])
print("shape", M.shape, "rank", M.rank())
ns=M.nullspace(); print("nullity", len(ns))
ca,cb=Counter(A),Counter(B); u=[cb[r]-ca[r] for r in E]
print("u=B-A:", u, "in kernel:", M*sp.Matrix(u)==sp.zeros(23,1))
from sympy.matrices.normalforms import smith_normal_form
snf=smith_normal_form(M, domain=sp.ZZ)
print("Smith diag:", [snf[i,i] for i in range(min(snf.shape))])
N=M.extract([i for i in range(23) if i not in (15,22)], list(range(21)))
print("stated minor det:", N.det())
# all 22 minors obtained by deleting one column (rows 16,23 deleted)
R=M.extract([i for i in range(23) if i not in (15,22)], list(range(22)))
dets=[R.extract(list(range(21)),[c for c in range(22) if c!=k]).det() for k in range(22)]
print("all column-deleted minors:", dets)
# brute-force fibre enumeration (independent DFS over type counts)
marg=[dict(mA[j]) for j in range(3)]
sols=[]
def rec(i, rem, cur):
    if i==len(E):
        if all(v==0 for m in rem for v in m.values()): sols.append(tuple(cur))
        return
    r=E[i]; hi=min(rem[j][r[j]] for j in range(3))
    for k in range(hi+1):
        for j in range(3): rem[j][r[j]]-=k
        cur.append(k); rec(i+1, rem, cur); cur.pop()
        for j in range(3): rem[j][r[j]]+=k
rec(0,[dict(m) for m in marg],[])
print("fibre size:", len(sols), [sum(s) for s in sols])
