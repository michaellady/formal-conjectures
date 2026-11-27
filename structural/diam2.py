#!/usr/bin/env python3
"""Fast check: is every pair of tables in a fibre within split-class distance 2?  Bitset version."""
import sys, itertools
from collections import Counter
n=int(sys.argv[1]); dlist=[int(x) for x in sys.argv[2].split(',')]
M=4
splits=[A for k in range(2,n-1) for A in itertools.combinations(range(n),k) if (0 in A) or 2*k<n]
for d in dlist:
    ns={}; src=open('/home/user/proofs-archive/runs/z4/fibre_check.py').read().split('log=f"results')[0]
    sys.argv=['x',str(n),str(d)]; exec(src,ns); fibre=ns['fibre']; margins=ns['margins']
    hist=Counter(); bad=[]
    for m in margins():
        if any(max(Counter(c).values())==d for c in m): continue
        F=fibre(m)
        if len(F)<2: continue
        cls=[[(A,tuple(sorted(sum(r[a] for a in A)%M for r in t))) for A in splits] for t in F]
        bits={}
        for i,cs in enumerate(cls):
            for c in cs: bits[c]=bits.get(c,0)|(1<<i)
        reach=[0]*len(F)
        for i,cs in enumerate(cls):
            r=0
            for c in cs: r|=bits[c]
            reach[i]=r
        full=(1<<len(F))-1
        diam=1
        for i in range(len(F)):
            if reach[i]!=full: diam=2; break
        if diam==2:
            for i in range(len(F)):
                for j in range(i+1,len(F)):
                    if not (reach[i]>>j)&1 and not (reach[i]&reach[j]):
                        diam=3; break
                if diam==3: break
        hist[diam]+=1
        if diam==3 and len(bad)<3: bad.append((m,len(F)))
    print(f"n={n} d={d}: diameter (1, 2, or >=3) histogram {sorted(hist.items())}; examples >=3: {bad}",flush=True)
