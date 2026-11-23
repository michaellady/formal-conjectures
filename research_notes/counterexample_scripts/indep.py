# Standalone verifier (shares no code with circ.py). Usage: indep.py n "A-types" "B-types" ; types as a,b,c:mult;...
import sys, itertools
from collections import Counter
from fractions import Fraction
n=int(sys.argv[1])
def parse(s):
    T=Counter()
    for it in s.split(';'):
        r,m=it.split(':'); T[tuple(int(x) for x in r.split(','))]+=int(m)
    return T
A=parse(sys.argv[2]); B=parse(sys.argv[3])
assert all(sum(r)%n==0 and all(0<=x<n for x in r) for r in list(A)+list(B)), "row sum"
dA=sum(A.values()); dB=sum(B.values())
mar=lambda T:[Counter({v:sum(m for r,m in T.items() if r[j]==v) for v in set(r[j] for r in T)}) for j in range(3)]
mA,mB=mar(A),mar(B)
print("n =",n,"| degree A,B:",dA,dB,"| margins equal:",mA==mB,"| common row types:",len(set(A)&set(B)))
assert mA==mB and dA==dB and not(set(A)&set(B))
S=[sorted(mA[j]) for j in range(3)]
E=[r for r in itertools.product(range(n),repeat=3) if sum(r)%n==0 and all(r[j] in mA[j] for j in range(3))]
print("support sizes",[len(s) for s in S],"| flows inside supports:",len(E))
# exhaustive fibre enumeration by DFS on counts
rem=[dict(m) for m in mA]; sols=[]; nodes=0
def rec(i,cur):
    global nodes
    nodes+=1
    if i==len(E):
        if all(v==0 for m in rem for v in m.values()): sols.append(dict((E[k],c) for k,c in enumerate(cur) if c))
        return
    r=E[i]; hi=min(rem[j][r[j]] for j in range(3))
    for t in range(hi+1):
        for j in range(3): rem[j][r[j]]-=t
        cur.append(t); rec(i+1,cur); cur.pop()
        for j in range(3): rem[j][r[j]]+=t
rec(0,[])
print("fibre size:",len(sols),"| DFS nodes:",nodes,"| fibre == {A,B}:", sorted(map(lambda d:sorted(d.items()),sols))==sorted([sorted(A.items()),sorted(B.items())]))
# exact rational rank of incidence matrix
rows=[(j,v) for j in range(3) for v in S[j]]
M=[[Fraction(int(r[j]==v)) for r in E] for (j,v) in rows]
rk=0
for c in range(len(E)):
    p=next((i for i in range(rk,len(M)) if M[i][c]!=0),None)
    if p is None: continue
    M[rk],M[p]=M[p],M[rk]
    for i in range(len(M)):
        if i!=rk and M[i][c]!=0:
            f=M[i][c]/M[rk][c]; M[i]=[x-f*y for x,y in zip(M[i],M[rk])]
    rk+=1
print("rank over Q:",rk,"| nullity:",len(E)-rk)
print("VERDICT: phi(Z/%d,3) >= %d"%(n,dA) if len(sols)==2 else "NOT a 2-element fibre")
