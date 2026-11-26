#!/usr/bin/env python3
"""n=6: bipartite graph between alpha in C1+C2 and D in C5+C6, edge iff (alpha+D) meets -(C3+C4).
mode fixed: pairing 12|34|56 with 34 as middle;  mode any: exists a choice of three disjoint cherries and
middle cherry making the graph connected."""
import sys, itertools
sys.path.insert(0,'.')
from sumset import *
d=int(sys.argv[1]); mode=sys.argv[2]
V=vecs(d)
def neg(v): return (v[0],v[3],v[2],v[1])
def tr(v,t): return tuple(v[(s-t)%4] for s in range(4))
def wsum(v): return sum(s*v[s] for s in range(4))%4
classes=sorted({min(tr(v,t) for t in range(4)) for v in V})
def conn(C,A,Mid,B):
    UA=oplus(C[A[0]],C[A[1]]); UB=oplus(C[B[0]],C[B[1]]); W={neg(g) for g in oplus(C[Mid[0]],C[Mid[1]])}
    parent={}
    def find(x):
        while parent[x]!=x: parent[x]=parent[parent[x]]; x=parent[x]
        return x
    for al in UA:
        for be in UB:
            if oplus(al,be) & W:
                a,b=('a',al),('b',be)
                parent.setdefault(a,a); parent.setdefault(b,b)
                ra,rb=find(a),find(b)
                if ra!=rb: parent[ra]=rb
    if not parent: return None
    return len({find(x) for x in parent})==1
pairings=[]
for p in itertools.permutations(range(6)):
    A,Mi,B=tuple(sorted(p[0:2])),tuple(sorted(p[2:4])),tuple(sorted(p[4:6]))
    if A<B and (A,Mi,B) not in pairings: pairings.append((A,Mi,B))
bad=0; tot=0
for first in itertools.combinations_with_replacement(classes,5):
    s=sum(wsum(c) for c in first)
    for last in V:
        if (s+wsum(last))%4: continue
        C=first+(last,)
        if any(max(c)==d for c in C): continue      # constant column: reduces to n=5
        if mode=='fixed':
            r=conn(C,(0,1),(2,3),(4,5))
        else:
            r=None
            for P in pairings:
                r=conn(C,*P)
                if r: break
        if r is None: continue
        tot+=1
        if not r:
            bad+=1
            if bad<=5: print("  disconnected:",C,flush=True)
print(f"n=6 d={d} mode={mode}: margins {tot}, disconnected {bad}",flush=True)
