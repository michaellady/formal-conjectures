#!/usr/bin/env python3
"""Degrees of a minimal Markov basis of the group-based-model toric ideal on the claw tree K_{1,n}.
Variables: tuples (g_1..g_n) in G^n with sum 0.  q_g -> prod_i a^{(i)}_{g_i}.
usage: ss.py n m1 [m2 ...]   (G = Z_m1 x Z_m2 x ...)"""
import sys, itertools, subprocess, collections, os, time
n=int(sys.argv[1]); mods=[int(x) for x in sys.argv[2:]]
G=list(itertools.product(*[range(m) for m in mods])); idx={g:i for i,g in enumerate(G)}
add=lambda a,b: tuple((x+y)%m for x,y,m in zip(a,b,mods))
zero=tuple(0 for _ in mods)
cols=[]
for t in itertools.product(G,repeat=n-1):
    s=zero
    for g in t: s=add(s,g)
    last=tuple((-x)%m for x,m in zip(s,mods)); cols.append(t+(last,))
rows=[[1 if c[i]==g else 0 for c in cols] for i in range(n) for g in G]
name=f"claw{n}_"+"x".join(map(str,mods))
open(name+".mat","w").write(f"{len(rows)} {len(cols)}\n"+"\n".join(" ".join(map(str,r)) for r in rows)+"\n")
t=time.time(); subprocess.run(["4ti2-markov","-q",name],check=True,stdout=subprocess.DEVNULL)
L=open(name+".mar").read().split("\n"); k=int(L[0].split()[0])
deg=collections.Counter(sum(x for x in map(int,l.split()) if x>0) for l in L[1:] if l.strip())
print(f"G=Z{'xZ'.join(map(str,mods))} |G|={len(G)} n={n} vars={len(cols)} markov_basis_size={k} degrees={dict(sorted(deg.items()))} max_degree={max(deg) if deg else 0} bound_ok={(max(deg) if deg else 0)<=len(G)} time={time.time()-t:.0f}s",flush=True)
