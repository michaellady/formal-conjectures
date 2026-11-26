#!/usr/bin/env python3
"""Lemma S test with the split FIXED to leaves {1,2} (columns 0,1): in each fibre join tables differing by a
quadratic move or having the same multiset of g1+g2.  Margins: columns 0,1 as an unordered pair of
translation classes, columns 2..n-2 as a multiset of classes, last column free (absorbs translations)."""
import sys, itertools
n=int(sys.argv[1]); dlist=[int(x) for x in sys.argv[2].split(',')]
M=4
def load(d):
    ns={}; src=open('/home/user/proofs-archive/runs/z4/fibre_check.py').read().split('log=f"results')[0]
    sys.argv=['x',str(n),str(d)]; exec(src,ns); return ns
for d in dlist:
    ns=load(d); fibre=ns['fibre']; classes=ns['classes']; allms=ns['allms']
    def margins():
        for p in itertools.combinations_with_replacement(classes,2):
            for mid in itertools.combinations_with_replacement(classes,n-3):
                s=sum(sum(c) for c in p+mid)
                for last in allms:
                    if (s+sum(last))%M==0: yield p+mid+(last,)
    ns['margins']=margins
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
        grp={}
        for i,t in enumerate(F):
            for a,b in itertools.combinations(range(d),2):
                k=t[:a]+t[a+1:b]+t[b+1:]
                if k in grp: union(i,grp[k])
                else: grp[k]=i
        key={}
        for i,t in enumerate(F):
            k=tuple(sorted((r[0]+r[1])%M for r in t))
            if k in key: union(i,key[k])
            else: key[k]=i
        c=len({find(i) for i in range(len(F))})
        if c>1:
            bad+=1
            if bad<=5: print("  disconnected:",m,"fibre",len(F),"components",c,flush=True)
    print(f"n={n} d={d} fixed split {{1,2}}: fibres {tot}, disconnected {bad}",flush=True)
