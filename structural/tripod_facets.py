import itertools, numpy as np
from scipy.spatial import ConvexHull
from fractions import Fraction
from math import gcd
V=[]
for a in range(4):
    for b in range(4):
        c=(-a-b)%4; v=[0]*12; v[a]=1; v[4+b]=1; v[8+c]=1; V.append(v)
V=np.array(V,float)
# coordinates: drop x_{1,0}, x_{2,0}, x_{3,0} (block sums 1) -> 9 dims
keep=[i for i in range(12) if i not in (0,4,8)]
P=V[:,keep]
h=ConvexHull(P)
facets=set()
for e in h.equations:
    v=e/np.max(np.abs(e))
    fr=[Fraction(x).limit_denominator(24) for x in v]
    L=1
    for f in fr: L=L*f.denominator//gcd(L,f.denominator)
    iv=[int(f*L) for f in fr]; g=0
    for x in iv: g=gcd(g,abs(x))
    facets.add(tuple(x//g for x in iv))
print(len(facets),"facets")
# express as homogeneous inequality on 12 counts: sum c_i x_i >= 0 using block sums = t (degree)
out=[]
for f in sorted(facets):
    # equation: n.y + off <= 0  with y = kept coords; homogenize: off -> off * (block1 total)
    nvec=f[:9]; off=f[9]
    c=[0]*12
    for j,i in enumerate(keep): c[i]=-nvec[j]
    # -n.y - off >= 0 ; replace constant by off* x-block-1 total? use symmetric: add -off/3 per block total
    out.append((c,-off))
for c,o in out:
    blocks=[c[0:4],c[4:8],c[8:12]]
    print(blocks,"const",o)
