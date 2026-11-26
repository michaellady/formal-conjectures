#!/usr/bin/env python3
"""Test the ideal-theoretic intersection property I_claw = sum of glued-tree ideals for Z/4.
For each fibre (margin) of degree d on n leaves, join two tables if they share a row, or if for some
split A|B (2<=|A|<=n-2) they have the same multiset of partial sums over A (then the binomial lies in the
ideal of the glued tree for that split).  Run for d = 2,3,... in order; a disconnected fibre means the
binomials of that multidegree are NOT in the sum of the glued-tree ideals."""
import sys, itertools
from collections import Counter
sys.argv=[sys.argv[0]]+sys.argv[1:]
n=int(sys.argv[1]); dmax=int(sys.argv[2])
import importlib.util
M=4
def run(d):
    global_ns={}
    src=open('/home/user/proofs-archive/runs/z4/fibre_check.py').read()
    src=src.split('log=f"results')[0]
    sys.argv=['x',str(n),str(d)]
    exec(src,global_ns)
    margins,fibre=global_ns['margins'],global_ns['fibre']
    splits=[A for k in range(2,n-1) for A in itertools.combinations(range(n),k) if (0 in A) or 2*k<n]
    bad=0; tot=0; gens=0
    for m in margins():
        F=fibre(m)
        if len(F)<2: continue
        tot+=1
        parent=list(range(len(F)))
        def find(x):
            while parent[x]!=x: parent[x]=parent[parent[x]]; x=parent[x]
            return x
        def union(a,b):
            a,b=find(a),find(b)
            if a!=b: parent[a]=b
        seen={}
        for i,t in enumerate(F):
            for r in set(t):
                if r in seen: union(i,seen[r])
                else: seen[r]=i
        if len({find(i) for i in range(len(F))})>1: gens+=1
        for A in splits:
            key={}
            for i,t in enumerate(F):
                k=tuple(sorted(sum(r[a] for a in A)%M for r in t))
                if k in key: union(i,key[k])
                else: key[k]=i
        c=len({find(i) for i in range(len(F))})
        if c>1:
            bad+=1
            if bad<=5: print("  NOT in J:",m,"fibre",len(F),"components",c,flush=True)
    print(f"n={n} d={d}: margins with |F|>1: {tot}; share-row-disconnected (minimal generators): {gens}; not in sum of glued ideals: {bad}",flush=True)
for d in range(2,dmax+1): run(d)
