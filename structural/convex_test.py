import sys, itertools
sys.path.insert(0,'.')
from sumset import *
import numpy as np
from scipy.spatial import ConvexHull
d=int(sys.argv[1]); V=vecs(d)
def lattice_pts_in_hull(S):
    # points z with sum d, sum s z_s = r mod 4, inside conv(S)  (use 3 coords z1,z2,z3)
    P=np.array([z[1:] for z in S],float)
    r=sum(s*z[s] for z in [next(iter(S))] for s in range(4))%4
    cand=[z for z in V if sum(s*z[s] for s in range(4))%4==r]
    if len(S)<=3 or np.linalg.matrix_rank(P-P[0])<3:
        return None
    h=ConvexHull(P); A=h.equations
    return set(z for z in cand if np.all(A[:,:3]@np.array(z[1:],float)+A[:,3]<=1e-9))
bad=0; tot=0; deg=0
for a in V:
    for b in V:
        if a>b: continue
        S=oplus(a,b); tot+=1
        L=lattice_pts_in_hull(S)
        if L is None: deg+=1; continue
        if L!=set(S):
            bad+=1
            if bad<=5: print("hole: a",a,"b",b,"missing",sorted(L-set(S))[:4],"|S|",len(S))
print(f"d={d}: pairs {tot}, low-dim {deg}, with holes {bad}")
