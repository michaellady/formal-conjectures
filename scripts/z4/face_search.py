#!/usr/bin/env python3
"""Search faces of the Z/4 claw-tree polytope for minimal generators of degree > 4.

A face is given by a support S_i (subset of Z/4) for each of n columns and a target sum c:
variables = tuples in prod S_i with sum = c (mod 4).  Up to translating columns (which changes c),
S_i is one of A={0,1}, B={0,2}, C={0,1,2}, D=Z/4.  Any minimal generator of the full ideal lies in
the face spanned by its own support, and a face's Markov basis is the restriction of the full one,
so a degree > 4 element in ANY face is a counterexample to phi(Z/4) <= 4.
usage: face_search.py n vmax timeout_s"""
import sys, itertools, subprocess, collections, os, time, tempfile
n=int(sys.argv[1]); vmax=int(sys.argv[2]); tmo=int(sys.argv[3])
T={'A':(0,1),'B':(0,2),'C':(0,1,2),'D':(0,1,2,3)}
BIN="/usr/libexec/x86_64-linux-gnu/4ti2/bin/4ti2int64"
work=tempfile.mkdtemp(prefix=f"face{n}_",dir=".")
for types in itertools.combinations_with_replacement("ABCD",n):
    for c in range(4):
        sup=[T[t] for t in types]
        cols=[t for t in itertools.product(*sup) if sum(t)%4==c]
        tag="".join(types)+f"_c{c}"
        if len(cols)<2: continue
        if len(cols)>vmax: print(f"n={n} {tag} vars={len(cols)} SKIP(size)",flush=True); continue
        rows=[[1 if col[i]==v else 0 for col in cols] for i in range(n) for v in sup[i]]
        base=os.path.join(work,tag)
        open(base+".mat","w").write(f"{len(rows)} {len(cols)}\n"+"\n".join(" ".join(map(str,r)) for r in rows)+"\n")
        t0=time.time()
        try:
            subprocess.run([BIN,"markov","-q",base],check=True,stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL,timeout=tmo)
        except subprocess.TimeoutExpired:
            print(f"n={n} {tag} vars={len(cols)} TIMEOUT",flush=True); continue
        L=open(base+".mar").read().split("\n")
        deg=collections.Counter(sum(x for x in map(int,l.split()) if x>0) for l in L[1:] if l.strip())
        mx=max(deg) if deg else 0
        flag=" <<<<< DEGREE>4 COUNTEREXAMPLE" if mx>4 else ""
        print(f"n={n} {tag} vars={len(cols)} max_degree={mx} degrees={dict(sorted(deg.items()))} t={time.time()-t0:.0f}s{flag}",flush=True)
        if mx<=4:
            for ext in (".mat",".mar"): os.remove(base+ext)
