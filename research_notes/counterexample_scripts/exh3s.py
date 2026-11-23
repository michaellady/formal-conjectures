import sys, itertools, json
from circ import *
orders=[int(x) for x in sys.argv[1].split('x')]
SL=int(sys.argv[2]) if len(sys.argv)>2 else 0; NS=int(sys.argv[3]) if len(sys.argv)>3 else 1
n,add,neg,els=make_group(orders)
best=0; bestex=None; hist={}
subs=[[i for i in range(n) if (m>>i)&1] for m in range(1<<n)]
cnt=0
for m1 in range(1,1<<n,2):          # 0 in S1 (translation symmetry)
    if (m1//2)%NS!=SL: continue
    S1=subs[m1]
    for m2 in range(1,1<<n,2):      # 0 in S2
        S2=subs[m2]
        if m2<m1: continue
        r=[0]*n
        for a in S1:
            for b in S2: r[neg[add[a][b]]]+=1
        base=len(S1)+len(S2)
        for m3 in range(1,1<<n):
            S3=subs[m3]
            ne=sum(r[c] for c in S3)
            if ne<2 or ne>base+len(S3)-1: continue
            if any(r[c]==0 for c in S3): continue   # unused value: redundant
            d,ex,_=evaluate([S1,S2,S3],add,neg)
            cnt+=1
            if d:
                hist[d]=hist.get(d,0)+1
                if d>best: best=d; bestex=([S1,S2,S3],ex)
print(sys.argv[1],"order",n,"evaluated",cnt,"max nullity-1 degree",best)
print(" degree histogram (labelled support triples):",sorted(hist.items()))
if bestex:
    S,(E,u)=bestex
    print(" supports",[[els[i] for i in s] for s in S])
    print(" u+ :",[(tuple(els[i] for i in r),x) for r,x in zip(E,u) if x>0])
    print(" u- :",[(tuple(els[i] for i in r),-x) for r,x in zip(E,u) if x<0])
