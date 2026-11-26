import itertools, functools
M=4
def comps(total, caps):
    """all ways to write total as sum of len(caps) nonneg ints bounded by caps"""
    if not caps:
        if total==0: yield ()
        return
    for x in range(min(total,caps[0])+1):
        for rest in comps(total-x,caps[1:]): yield (x,)+rest
@functools.lru_cache(maxsize=None)
def oplus(a,b):
    """set of count vectors z of multisets {x_i+y_pi(i)} for multisets with count vectors a,b"""
    res=set()
    def rec(i,brem,z):
        if i==M:
            res.add(z); return
        for row in comps(a[i],brem):
            nz=list(z)
            for j in range(M): nz[(i+j)%M]+=row[j]
            rec(i+1,tuple(brem[j]-row[j] for j in range(M)),tuple(nz))
    rec(0,b,(0,)*M); return frozenset(res)
def vecs(d): return [c for c in comps(d,(d,)*M)]
