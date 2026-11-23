import sys, random, time, math
from circ import *
orders=[int(x) for x in sys.argv[1].split('x')]; m=int(sys.argv[2]); T=float(sys.argv[3]); seed=int(sys.argv[4]) if len(sys.argv)>4 else 1
random.seed(seed)
n,add,neg,els=make_group(orders)
def score(S):
    tot=sum(len(s) for s in S)
    E=flows(S,add,neg)
    tgt=tot-m+2
    if len(E)<2 or len(E)>tgt: return -abs(len(E)-tgt)-1,None
    u,nul=kernel1(S,E)
    if u is None: return -0.5-abs(len(E)-tgt),None
    return degree(u),(E,u)
best=0;bestex=None;hist={};t0=time.time();it=0
k0=max(2,round(math.sqrt(m*n))) if m==3 else 2
while time.time()-t0<T:
    S=[sorted(random.sample(range(n),min(n,max(1,k0+random.randint(-2,2))))) for _ in range(m)]
    sc,ex=score(S); stall=0
    while stall<60 and time.time()-t0<T:
        it+=1
        j=random.randrange(m); v=random.randrange(n)
        S2=[list(s) for s in S]
        if v in S2[j]:
            if len(S2[j])==1: continue
            S2[j].remove(v)
        else: S2[j].append(v); S2[j].sort()
        if random.random()<0.3:   # swap move
            j2=random.randrange(m); w=random.randrange(n)
            if w in S2[j2]:
                if len(S2[j2])>1: S2[j2].remove(w)
            else: S2[j2].append(w); S2[j2].sort()
        sc2,ex2=score(S2)
        if sc2>=sc:
            if sc2>sc: stall=0
            else: stall+=1
            S,sc,ex=S2,sc2,ex2
            if sc>0:
                hist[sc]=hist.get(sc,0)+1
                if sc>best:
                    best=sc;bestex=(S,ex)
        else: stall+=1
print(sys.argv[1],'order',n,'leaves',m,'iters',it,'best nullity-1 degree',best, '(> |G|)' if best>n else '')
print('  top degrees seen:',sorted(hist.items())[-6:])
if bestex:
    S,(E,u)=bestex
    print('  supports',[[els[i] for i in s] for s in S],'|E|',len(E))
    print('  u+ :',[(tuple(els[i] for i in r),x) for r,x in zip(E,u) if x>0])
    print('  u- :',[(tuple(els[i] for i in r),-x) for r,x in zip(E,u) if x<0])
