# build 4ti2 input for claw tree K_{1,m}, group given as orders e.g. 2x2 ; then (mode 'post') analyse Markov basis
import sys, itertools, subprocess
from circ import make_group, flows
orders=[int(x) for x in sys.argv[1].split('x')]; m=int(sys.argv[2]); name=sys.argv[3]
n,add,neg,els=make_group(orders)
S=[list(range(n))]*m
E=flows(S,add,neg)
rows=[(j,v) for j in range(m) for v in range(n)]
if sys.argv[4]=='pre':
    with open(name+'.mat','w') as f:
        f.write(f"{len(rows)} {len(E)}\n")
        for (j,v) in rows: f.write(' '.join('1' if r[j]==v else '0' for r in E)+'\n')
    sys.exit()
# post: read name.mar
L=open(name+'.mar').read().split('\n')
k,c=map(int,L[0].split()); gens=[list(map(int,l.split())) for l in L[1:] if l.strip()]
assert len(gens)==k
from collections import Counter
deg=Counter(sum(x for x in g if x>0) for g in gens)
print(sys.argv[1],'leaves',m,'#gens',k,'by degree',sorted(deg.items()))
def fibre_size(up, cap=50):
    # count tables (multisets of flows) with the same margins as up, up to cap
    marg=[Counter() for _ in range(m)]
    for r,x in zip(E,up):
        if x:
            for j in range(m): marg[j][r[j]]+=x
    Sx=[sorted(marg[j]) for j in range(m)]
    Ex=flows(Sx,add,neg)
    cnt=0
    def rec(i):
        nonlocal cnt
        if cnt>=cap: return
        if i==len(Ex):
            if all(v==0 for mj in marg for v in mj.values()): cnt+=1
            return
        r=Ex[i]; hi=min(marg[j][r[j]] for j in range(m))
        for t in range(hi,-1,-1):
            for j in range(m): marg[j][r[j]]-=t
            rec(i+1)
            for j in range(m): marg[j][r[j]]+=t
    rec(0); return cnt
top=max(deg)
for D in sorted(deg):
    fs=Counter()
    for g in gens:
        if sum(x for x in g if x>0)==D:
            fs[fibre_size([max(x,0) for x in g])]+=1
    print('  degree',D,': fibre-size histogram of generators (size:count, capped at 50):',sorted(fs.items()))
