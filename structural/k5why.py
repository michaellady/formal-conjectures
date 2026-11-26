import sys, itertools
sys.path.insert(0,'.')
exec(open('k5single.py').read().split('bad=0')[0])
from collections import Counter
def ctype(c):
    # describe a count vector up to translation/negation: support pattern
    sup=tuple(sorted(s for s in range(4) if c[s]>0))
    return sup
fail=Counter(); good=Counter()
for first in itertools.combinations_with_replacement(classes,4):
    s=sum(wsum(c) for c in first)
    for last in V:
        if (s+wsum(last))%4: continue
        C=first+(last,)
        if any(max(c)==d for c in C): continue
        for P in trip:
            r=conn(C,*P)
            if r is None: continue
            c=C[P[1]]; sup=[s for s in range(4) if c[s]>0]
            par = 'onecoset' if len({x%2 for x in sup})==1 else 'mixed'
            key=(par,len(sup))
            (good if r else fail)[key]+=1
print("d",d,"fail by middle type",dict(fail)); print("good by middle type",dict(good))
