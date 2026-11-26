import sys, itertools
from fractions import Fraction
from math import gcd
sys.path.insert(0,'.')
from sumset import *
import numpy as np
from scipy.spatial import ConvexHull
from collections import Counter
cnt=Counter()
for d in range(4,9):
    V=vecs(d)
    for a in V:
        for b in V:
            if a>b: continue
            S=oplus(a,b)
            P=np.array([z[1:] for z in S],float)
            if len(S)<5 or np.linalg.matrix_rank(P-P[0])<3: continue
            h=ConvexHull(P)
            for e in h.equations:
                v=e[:3]; v=v/np.max(np.abs(v)); 
                # rationalize
                fr=[Fraction(x).limit_denominator(12) for x in v]
                L=1
                for f in fr: L=L*f.denominator//gcd(L,f.denominator)
                iv=[int(f*L) for f in fr]; g=0
                for x in iv: g=gcd(g,abs(x))
                iv=tuple(x//g for x in iv)
                cnt[iv]+=1
    print(d,len(cnt),flush=True)
# express normals in 4 coords with z0 coefficient 0: normal n.(z1,z2,z3) <= h
for k,v in sorted(cnt.items(),key=lambda x:-x[1]): print(k,v)
