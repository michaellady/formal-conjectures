import sys
sys.path.insert(0,'.')
from sumset import *
import numpy as np
from scipy.optimize import linprog
d=int(sys.argv[1]); V=vecs(d)
def in_hull(z,P):
    k=len(P); A=np.vstack([np.array(P,float).T,np.ones(k)]); b=np.append(np.array(z,float),1)
    r=linprog(np.zeros(k),A_eq=A,b_eq=b,bounds=[(0,None)]*k,method='highs'); return r.status==0
bad=0; tot=0
for a in V:
    for b in V:
        if a>b: continue
        S=oplus(a,b); tot+=1; P=list(S)
        r=sum(s*P[0][s] for s in range(4))%4
        lo=[min(p[i] for p in P) for i in range(4)]; hi=[max(p[i] for p in P) for i in range(4)]
        for z in V:
            if z in S or any(z[i]<lo[i] or z[i]>hi[i] for i in range(4)) or sum(s*z[s] for s in range(4))%4!=r: continue
            if in_hull(z,P):
                bad+=1
                if bad<=8: print("hole: a",a,"b",b,"z",z,"S",sorted(S))
                break
print(f"d={d}: pairs {tot}, with holes {bad}",flush=True)
