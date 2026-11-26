#!/usr/bin/env python3
"""K2'(5): for a 5-leaf margin (count vectors C1..C5), nodes are (cherry {i,j}, alpha) with alpha in Ci+Cj
(multiset sumset); join (ij,alpha)-(kl,beta) for disjoint cherries with middle leaf m when -Cm in alpha+beta
(then some table has mu_ij=alpha and mu_kl=beta).  If the graph on nodes with an edge is connected, the
fibre is connected by toric-fibre-product moves, which have degree <= 4 since phi(3)=phi(4)=4."""
import sys, itertools
sys.path.insert(0,'.')
from sumset import *
d=int(sys.argv[1])
V=vecs(d)
def neg(v): return (v[0],v[3],v[2],v[1])
def tr(v,t): return tuple(v[(s-t)%4] for s in range(4))
def wsum(v): return sum(s*v[s] for s in range(4))%4
classes=sorted({min(tr(v,t) for t in range(4)) for v in V})
cher=list(itertools.combinations(range(5),2))
pairs=[(A,B) for A in cher for B in cher if A<B and not set(A)&set(B)]
bad=0; tot=0
for first in itertools.combinations_with_replacement(classes,4):
    s=sum(wsum(c) for c in first)
    for last in V:
        if (s+wsum(last))%4: continue
        C=first+(last,)
        U={A:oplus(C[A[0]],C[A[1]]) for A in cher}
        parent={}
        def find(x):
            while parent[x]!=x: parent[x]=parent[parent[x]]; x=parent[x]
            return x
        def union(a,b):
            parent.setdefault(a,a); parent.setdefault(b,b)
            a,b=find(a),find(b)
            if a!=b: parent[a]=b
        for A,B in pairs:
            m=({0,1,2,3,4}-set(A)-set(B)).pop(); t=neg(C[m])
            for al in U[A]:
                for be in U[B]:
                    if t in oplus(al,be): union((A,al),(B,be))
        if not parent: continue   # empty fibre
        tot+=1
        c=len({find(x) for x in parent})
        if c>1:
            bad+=1
            if bad<=5: print("  disconnected:",C,"components",c,flush=True)
print(f"d={d}: margins with nonempty fibre {tot}, disconnected {bad}",flush=True)
