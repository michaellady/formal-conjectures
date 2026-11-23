# Search for "nullity-1" support configurations: column supports S_1..S_m in an abelian group G,
# E = all flows in S_1 x ... x S_m, incidence matrix M_E with 1-dim kernel spanned by primitive u.
# Then the fibre of u+ is exactly {u+,u-} (2 elements, disjoint supports) => indispensable binomial of degree |u+|.
import itertools, random, sys, math
P = (1<<61)-1
def make_group(orders):
    els = list(itertools.product(*[range(o) for o in orders]))
    idx = {e:i for i,e in enumerate(els)}
    n = len(els)
    add = [[idx[tuple((a+b)%o for a,b,o in zip(x,y,orders))] for y in els] for x in els]
    neg = [idx[tuple((-a)%o for a,o in zip(x,orders))] for x in els]
    return n, add, neg, els
def flows(S, add, neg):
    # S: list of lists of element indices; returns flows in product
    out=[]
    for pre in itertools.product(*S[:-1]):
        s=0  # index of identity is 0
        for a in pre: s=add[s][a]
        c=neg[s]
        if c in S[-1]: out.append(pre+(c,))
    return out
def ratrec(a, p=P):
    # rational reconstruction of a mod p
    bound = 1<<29
    r0,r1,s0,s1 = p,a%p,0,1
    while r1 > bound:
        q=r0//r1; r0,r1=r1,r0-q*r1; s0,s1=s1,s0-q*s1
    if s1==0 or abs(s1)>bound: return None
    if s1<0: r1,s1=-r1,-s1
    return (r1,s1)
def kernel1(S, E):
    """return primitive kernel vector if nullity==1 else (None, nullity)"""
    rowid={}
    for j,Sj in enumerate(S):
        for v in Sj: rowid[(j,v)]=len(rowid)
    R=len(rowid); C=len(E)
    M=[[0]*C for _ in range(R)]
    for c,r in enumerate(E):
        for j,v in enumerate(r): M[rowid[(j,v)]][c]=1
    A=[row[:] for row in M]
    piv=[]; lead=0
    for c in range(C):
        pr=None
        for i in range(lead,R):
            if A[i][c]: pr=i;break
        if pr is None: continue
        A[lead],A[pr]=A[pr],A[lead]
        inv=pow(A[lead][c],P-2,P)
        A[lead]=[x*inv%P for x in A[lead]]
        for i in range(R):
            if i!=lead and A[i][c]:
                f=A[i][c]; rl=A[lead]
                A[i]=[(x-f*y)%P for x,y in zip(A[i],rl)]
        piv.append(c); lead+=1
        if lead==R: break
    nul=C-len(piv)
    if nul!=1: return None,nul
    free=[c for c in range(C) if c not in piv][0]
    vec=[None]*C; vec[free]=(1,1)
    for i,c in enumerate(piv):
        rr=ratrec((-A[i][free])%P)
        if rr is None: return None,-1
        vec[c]=rr
    L=1
    for (_,dn) in vec: L=L*dn//math.gcd(L,dn)
    u=[nu*(L//dn) for nu,dn in vec]
    g=0
    for x in u: g=math.gcd(g,abs(x))
    u=[x//g for x in u]
    # exact check
    for row in M:
        if sum(a*b for a,b in zip(row,u))!=0: return None,-2
    return u,1
def degree(u): return sum(x for x in u if x>0)
def evaluate(S, add, neg):
    m=len(S); tot=sum(len(s) for s in S)
    E=flows(S,add,neg)
    if len(E)<2 or len(E)>tot-m+2: return 0,None,len(E)
    u,nul=kernel1(S,E)
    if u is None: return 0,None,len(E)
    return degree(u),(E,u),len(E)
