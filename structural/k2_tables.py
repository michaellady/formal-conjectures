#!/usr/bin/env python3
"""K2 test on actual fibres: join tables with the same multiset mu of g1+g2, or the same multiset of
partial sums over X for X in XS (subsets of the last leaves).  If S(n-|X|+1) holds, same-D_X tables
are connected by quadratic + mu-kernel moves, so connectivity here gives S(n)."""
import sys, itertools
n=int(sys.argv[1]); dlist=[int(x) for x in sys.argv[2].split(',')]; xs=sys.argv[3]
M=4
if xs=='last2': XS=[(n-2,n-1)]
else: XS=[X for k in range(2,n-2) for X in itertools.combinations(range(2,n),k)]
for d in dlist:
    ns={}; src=open('/home/user/proofs-archive/runs/z4/fibre_check.py').read().split('log=f"results')[0]
    sys.argv=['x',str(n),str(d)]; exec(src,ns); fibre=ns['fibre']; classes=ns['classes']; allms=ns['allms']
    def margins():
        for p in itertools.combinations_with_replacement(classes,2):
            for mid in itertools.product(classes,repeat=n-3):
                s=sum(sum(c) for c in p+mid)
                for last in allms:
                    if (s+sum(last))%M==0: yield p+mid+(last,)
    bad=0; tot=0
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
        for A in [(0,1)]+XS:
            key={}
            for i,t in enumerate(F):
                k=tuple(sorted(sum(r[a] for a in A)%M for r in t))
                if k in key: union(i,key[k])
                else: key[k]=i
        c=len({find(i) for i in range(len(F))})
        if c>1:
            bad+=1
            if bad<=5: print("  disconnected:",m,"fibre",len(F),"components",c,flush=True)
    print(f"n={n} d={d} XS={xs}: fibres {tot}, disconnected {bad}",flush=True)
