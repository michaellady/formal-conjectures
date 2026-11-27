import sys, itertools
from collections import Counter
sys.path.insert(0,'.')
from sumset import oplus
n=5; d=int(sys.argv[1])
cher=list(itertools.combinations(range(5),2))
trip=[(P,Q,({0,1,2,3,4}-set(P)-set(Q)).pop()) for P in cher for Q in cher if not set(P)&set(Q)]
def cv(vals):
    c=[0]*4
    for v in vals: c[v%4]+=1
    return tuple(c)
def neg(v): return (v[0],v[3],v[2],v[1])
ns={}; src=open('/home/user/proofs-archive/runs/z4/fibre_check.py').read().split('log=f"results')[0]
sys.argv=['x',str(n),str(d)]; exec(src,ns); fibre=ns['fibre']; margins=ns['margins']
hist=Counter(); ex=[]
for m in margins():
    if any(max(Counter(c).values())==d for c in m): continue
    F=fibre(m)
    if len(F)<2: continue
    Cm=[neg(cv(col)) for col in m]
    prof=[{P:cv([r[P[0]]+r[P[1]] for r in t]) for P in cher} for t in F]
    for i in range(len(F)):
        for j in range(len(F)):
            if i==j: continue
            w=[(P,Q,mm) for P,Q,mm in trip if Cm[mm] in oplus(prof[i][P],prof[j][Q])]
            hist[len(w)]+=1
            if len(w)<=2 and len(ex)<12: ex.append((m,F[i],F[j],w))
print("d",d,"hist",sorted(hist.items())[:10])
for e in ex: print(e)
