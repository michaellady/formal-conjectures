#!/usr/bin/env python3
"""Alignment test.  In each fibre join tables that differ by a QUADRATIC move (share d-2 rows), and
tables with the same multiset of partial sums over a split A (glued-tree / toric-fibre-product class).
If every fibre is connected for all d, then phi(n) <= max(2, phi(3), phi(n-1)) by Sullivant's
toric fibre product theorem.  mode: 'pair01' uses only the split {1,2}; 'pairs' all 2-subsets;
'all' all splits."""
import sys, itertools
n=int(sys.argv[1]); dlist=[int(x) for x in sys.argv[2].split(',')]; mode=sys.argv[3]
M=4
def load(d):
    ns={}; src=open('/home/user/proofs-archive/runs/z4/fibre_check.py').read().split('log=f"results')[0]
    sys.argv=['x',str(n),str(d)]; exec(src,ns); return ns['margins'],ns['fibre']
for d in dlist:
    margins,fibre=load(d)
    if mode=='pair01': splits=[(0,1)]
    elif mode=='pairs': splits=list(itertools.combinations(range(n),2))
    else: splits=[A for k in range(2,n-1) for A in itertools.combinations(range(n),k)]
    bad=0; tot=0; worst=None
    for m in margins():
        F=fibre(m)
        if len(F)<2: continue
        tot+=1; parent=list(range(len(F)))
        def find(x):
            while parent[x]!=x: parent[x]=parent[parent[x]]; x=parent[x]
            return x
        def union(a,b):
            a,b=find(a),find(b)
            if a!=b: parent[a]=b
        grp={}
        for i,t in enumerate(F):
            for a,b in itertools.combinations(range(d),2):
                k=t[:a]+t[a+1:b]+t[b+1:]
                if k in grp: union(i,grp[k])
                else: grp[k]=i
        for A in splits:
            key={}
            for i,t in enumerate(F):
                k=(A,tuple(sorted(sum(r[a] for a in A)%M for r in t)))
                if k in key: union(i,key[k])
                else: key[k]=i
        c=len({find(i) for i in range(len(F))})
        if c>1:
            bad+=1
            if bad<=3: print("  disconnected:",m,"fibre",len(F),"components",c,flush=True)
    print(f"n={n} d={d} mode={mode}: fibres {tot}, disconnected {bad}",flush=True)
