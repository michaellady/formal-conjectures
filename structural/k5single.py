import sys, itertools
sys.path.insert(0,'.')
from sumset import *
d=int(sys.argv[1]); V=vecs(d)
def neg(v): return (v[0],v[3],v[2],v[1])
def tr(v,t): return tuple(v[(s-t)%4] for s in range(4))
def wsum(v): return sum(s*v[s] for s in range(4))%4
classes=sorted({min(tr(v,t) for t in range(4)) for v in V})
def conn(C,A,m,B):
    UA=oplus(C[A[0]],C[A[1]]); UB=oplus(C[B[0]],C[B[1]]); t=neg(C[m])
    parent={}
    def find(x):
        while parent[x]!=x: parent[x]=parent[parent[x]]; x=parent[x]
        return x
    for al in UA:
        for be in UB:
            if t in oplus(al,be):
                a,b=('a',al),('b',be); parent.setdefault(a,a); parent.setdefault(b,b)
                ra,rb=find(a),find(b)
                if ra!=rb: parent[ra]=rb
    if not parent: return None
    return len({find(x) for x in parent})==1
trip=[]
for m in range(5):
    rest=[i for i in range(5) if i!=m]
    for A in itertools.combinations(rest,2):
        B=tuple(i for i in rest if i not in A)
        if A<B: trip.append((A,m,B))
bad=0; tot=0; hist={}
for first in itertools.combinations_with_replacement(classes,4):
    s=sum(wsum(c) for c in first)
    for last in V:
        if (s+wsum(last))%4: continue
        C=first+(last,)
        if any(max(c)==d for c in C): continue
        res=[conn(C,*P) for P in trip]
        if all(r is None for r in res): continue
        tot+=1; k=sum(1 for r in res if r)
        hist[k]=hist.get(k,0)+1
        if k==0:
            bad+=1
            if bad<=5: print("  no single pair works:",C,flush=True)
print(f"d={d}: margins {tot}, no single pair: {bad}; histogram of #working pairs (of 15): {sorted(hist.items())}",flush=True)
