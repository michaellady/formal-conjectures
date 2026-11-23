#!/usr/bin/env python3
"""Resumable search for minimal generators of degree d of the Z/4 claw-tree ideal on n leaves.

Fact used (Charalambous-Katsabekis-Thoma): the toric ideal has a minimal generator of multidegree b
iff the fibre F_b is disconnected in the graph joining two tables that share a row.  So for each
margin b of degree d (one multiset of d elements of Z/4 per column) we enumerate the fibre and count
components.  Any disconnected fibre with d > 4 is a counterexample to phi(Z/4) <= 4.

Margins are taken up to translating columns 1..n-1 (column n absorbs the opposite translation) and
permuting those columns.  Work is split into chunks; each finished chunk is one JSON line in the log,
so the run can be stopped and resumed at any time.

usage: fibre_check.py n d [chunk_size]     (appends to results_n{n}_d{d}.jsonl in this directory)"""
import sys, json, itertools, os, time
from collections import Counter
n=int(sys.argv[1]); d=int(sys.argv[2]); CH=int(sys.argv[3]) if len(sys.argv)>3 else 200
M=4
allms=[tuple(c) for c in itertools.combinations_with_replacement(range(M),d)]
def canon(ms): return min(tuple(sorted((x+g)%M for x in ms)) for g in range(M))
classes=sorted(set(canon(ms) for ms in allms))
def margins():
    for first in itertools.combinations_with_replacement(classes,n-1):
        s=sum(sum(c) for c in first)
        for last in allms:
            if (s+sum(last))%M==0: yield first+(last,)
def fibre(margin):
    """all multisets of d zero-sum rows with the given column multisets, as sorted tuples of rows"""
    rem=[Counter(c) for c in margin]; out=[]; cur=[]
    def rows_from(lo):
        # zero-sum rows >= lo (lexicographic) available in rem
        def rec(i,pref,s,tight):
            if i==n-1:
                v=(-s)%M
                if rem[i][v]>0 and (not tight or v>=lo[i]): yield pref+(v,)
                return
            for v in range(M):
                if rem[i][v]<=0: continue
                if tight and v<lo[i]: continue
                yield from rec(i+1,pref+(v,),s+v,tight and v==lo[i])
        yield from rec(0,(),0,lo is not None)
    def dfs(k,lo):
        if k==d: out.append(tuple(cur)); return
        for r in list(rows_from(lo)):
            for i in range(n): rem[i][r[i]]-=1
            cur.append(r); dfs(k+1,r); cur.pop()
            for i in range(n): rem[i][r[i]]+=1
    dfs(0,None); return out
def components(F):
    parent=list(range(len(F)))
    def find(x):
        while parent[x]!=x: parent[x]=parent[parent[x]]; x=parent[x]
        return x
    seen={}
    for idx,t in enumerate(F):
        for r in set(t):
            if r in seen: 
                a,b=find(idx),find(seen[r])
                if a!=b: parent[a]=b
            else: seen[r]=idx
    return len({find(i) for i in range(len(F))})
log=f"results_n{n}_d{d}.jsonl"; done=set()
if os.path.exists(log):
    for l in open(log):
        try: done.add(json.loads(l)["chunk"])
        except Exception: pass
chunk=[]; ci=0
def flush(ci,chunk):
    if ci in done: return
    t=time.time(); bad=[]; mx=0; tot=0
    for m in chunk:
        F=fibre(m); tot+=1; mx=max(mx,len(F))
        if len(F)>1:
            c=components(F)
            if c>1: bad.append({"margin":m,"fibre":len(F),"components":c})
    rec={"n":n,"d":d,"chunk":ci,"margins":tot,"max_fibre":mx,"disconnected":bad,"secs":round(time.time()-t,1)}
    with open(log,"a") as f: f.write(json.dumps(rec)+"\n"); f.flush(); os.fsync(f.fileno())
    if bad: print(f"n={n} d={d} chunk={ci}: {len(bad)} DISCONNECTED fibre(s)"+(" <<<<< COUNTEREXAMPLE" if d>4 else ""),flush=True)
for m in margins():
    chunk.append(m)
    if len(chunk)==CH: flush(ci,chunk); chunk=[]; ci+=1
if chunk: flush(ci,chunk); ci+=1
with open(log,"a") as f: f.write(json.dumps({"n":n,"d":d,"chunk":"END","chunks":ci})+"\n")
print(f"n={n} d={d} finished: {ci} chunks",flush=True)
