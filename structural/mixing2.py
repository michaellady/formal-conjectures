#!/usr/bin/env python3
"""Mixing statistics, n=5: for random pairs of tables in random fibres of degree d, count how many of the 30
ordered (P,Q,m) disjoint-cherry configurations give -C_m in mu_P(T)(+)mu_Q(T'); also check per middle leaf."""
import sys, itertools, random
from collections import Counter
sys.path.insert(0,'.')
from sumset import oplus
n=5; d=int(sys.argv[1]); samples=int(sys.argv[2]); random.seed(int(sys.argv[3]) if len(sys.argv)>3 else 1)
cher=list(itertools.combinations(range(5),2))
trip=[(P,Q,({0,1,2,3,4}-set(P)-set(Q)).pop()) for P in cher for Q in cher if not set(P)&set(Q)]
def cv(vals):
    c=[0]*4
    for v in vals: c[v%4]+=1
    return tuple(c)
def neg(v): return (v[0],v[3],v[2],v[1])
def rand_table():
    rows=[]
    for _ in range(d):
        r=[random.randrange(4) for _ in range(4)]; r.append((-sum(r))%4); rows.append(tuple(r))
    return rows
def shuffle_table(T,steps=200):
    """random walk by quadratic moves to get another table with the same margin"""
    T=list(T)
    for _ in range(steps):
        i,j=random.sample(range(d),2); S=[c for c in range(5) if random.random()<0.5]
        if (sum(T[i][c]-T[j][c] for c in S))%4==0:
            a=list(T[i]); b=list(T[j])
            for c in S: a[c],b[c]=b[c],a[c]
            T[i],T[j]=tuple(a),tuple(b)
    return T
cnt=Counter(); fails=0; minper=Counter()
for _ in range(samples):
    T=rand_table(); T2=shuffle_table(T)
    cols=[cv([r[c] for r in T]) for c in range(5)]
    if any(max(c)==d for c in cols): continue
    Cm=[neg(c) for c in cols]
    pT={P:cv([r[P[0]]+r[P[1]] for r in T]) for P in cher}; pT2={P:cv([r[P[0]]+r[P[1]] for r in T2]) for P in cher}
    k=sum(1 for P,Q,m in trip if Cm[m] in oplus(pT[P],pT2[Q]))
    cnt[k]+=1
    if k==0: fails+=1; print("  FAIL",T,T2,flush=True)
print(f"d={d}: samples {sum(cnt.values())}, fails {fails}, histogram of #working configs (of 30): {sorted(cnt.items())[:8]} ...",flush=True)
