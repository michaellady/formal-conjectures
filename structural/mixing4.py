import sys, itertools
from collections import Counter
sys.path.insert(0,'.')
from sumset import oplus
n=5; d=int(sys.argv[1])
cher=list(itertools.combinations(range(5),2))
def cv(vals):
    c=[0]*4
    for v in vals: c[v%4]+=1
    return tuple(c)
def neg(v): return (v[0],v[3],v[2],v[1])
ns={}; src=open('/home/user/proofs-archive/runs/z4/fibre_check.py').read().split('log=f"results')[0]
sys.argv=['x',str(n),str(d)]; exec(src,ns); fibre=ns['fibre']; margins=ns['margins']
perm=Counter(); fullsup=Counter(); ex=[]
for m in margins():
    if any(max(Counter(c).values())==d for c in m): continue
    F=fibre(m)
    if len(F)<2: continue
    cols=[cv(col) for col in m]; Cm=[neg(c) for c in cols]
    prof=[{P:cv([r[P[0]]+r[P[1]] for r in t]) for P in cher} for t in F]
    for i in range(len(F)):
        for j in range(len(F)):
            if i==j: continue
            for mm in range(5):
                rest=[x for x in range(5) if x!=mm]
                cfg=[]
                for P in itertools.combinations(rest,2):
                    Q=tuple(x for x in rest if x not in P); cfg.append((P,Q)); 
                ok=any(Cm[mm] in oplus(prof[i][P],prof[j][Q]) for P,Q in cfg)
                key=(sum(1 for x in cols[mm] if x>0))
                perm[(key,ok)]+=1
                if not ok and key>=3 and len(ex)<6: ex.append((m,F[i],F[j],mm))
print("d",d,"(support size of middle column, works?) counts:",sorted(perm.items()))
for e in ex: print(" fail with middle support>=3:",e)
