# Finiteness results and the constancy conjecture for φ(G, n) on claw trees K_{1,n}

Sources read in full (text extracted with pdftotext; local copies in /home/user/papers and /home/user/papers/dl):

- [Mic13] Michałek, "Constructive degree bounds for group-based models", [arXiv:1207.0930v3](https://arxiv.org/abs/1207.0930)
- [MV17] Michałek–Ventura, "Finite phylogenetic complexity and combinatorics of tables", [arXiv:1606.07263v2](https://arxiv.org/abs/1606.07263); published version [ANT 11:1 (2017)](https://msp.org/ant/2017/11-1/ant-v11-n1-p06-s.pdf) checked for the key passages (identical wording)
- [CFSM] Casanellas–Fernández-Sánchez–Michałek, [arXiv:1402.6945v1](https://arxiv.org/abs/1402.6945) (arXiv title "Local description of phylogenetic group-based models"; published as "Low degree equations for phylogenetic group-based models")
- [DE] Draisma–Eggermont, "Finiteness results for Abelian tree models", [arXiv:1207.1282v2](https://arxiv.org/abs/1207.1282) (introduction and main theorems read; Sections 3–6 only scanned)
- [DBM] Donten-Bury–Michałek, "Phylogenetic invariants for group-based models", [arXiv:1011.3236](https://arxiv.org/abs/1011.3236) (Section 3 read: origin of Conjecture 9.2)
- [Mic15] Michałek, "Finite phylogenetic complexity of Z_p and invariants for Z_3", [arXiv:1508.04177v2](https://arxiv.org/abs/1508.04177) (Sections 1–3 read)
- [MV19] Michałek–Ventura, "Phylogenetic complexity of the Kimura 3-parameter model", [arXiv:1704.02584](https://arxiv.org/abs/1704.02584) (Sections 1, 3.1 and Theorem 3.4 read)
- [SS05] Sturmfels–Sullivant, "Toric ideals of phylogenetic invariants", [arXiv:q-bio/0402015](https://arxiv.org/abs/q-bio/0402015) (Section 5 table and conjectures read)

Indexing warning. [SS05]'s table of φ(G, n) is indexed so that the row "(G, n)" is the claw tree with n+1 leaves (the row "Z2, n=2" has no generators, which is K_{1,3}, the whole P^3; Theorem 26 says φ(Z2, n) = 2 for n ≥ 3 in that indexing). [Mic13], [MV17], [DBM] use n = number of leaves. Everything below uses n = number of leaves.

## 1. Verbatim statements of [Mic13] Conjectures 9.1–9.4 and the logical relations between them

### Takeaway
Conjecture 9.3 is literally "The function φ(G, ·) is constant"; [Mic13] presents it as a consequence of Conjecture 9.2 (claw-tree variety = scheme-theoretic intersection of varieties of trees with smaller valency), with the argument given only in [DBM]. [MV17] restates 9.3 as φ(G, n+1) = max(2, φ(G, n)), the max being needed only for G = Z2, n = 3.

### Cited Findings
- Conjecture 9.1, verbatim: "For any group G and any tree T the ideal I(X(G, T)) and the subideal generated in degree |G| define the same projective scheme." — [Mic13, Section 9](https://arxiv.org/abs/1207.0930)
- Conjecture 9.2, verbatim: "([DBM] Conjecture 3.6). The variety X(K1,n, G) is a scheme theoretic intersection of all X(T, G), where T is a prolongation of G with all vertices of degree at most n − 1." ("prolongation of G" is a typo in the source for "prolongation of K_{1,n}".) — [Mic13, Section 9](https://arxiv.org/abs/1207.0930)
- Immediately after 9.2: "This conjecture would imply the following. Conjecture 9.3. The function φ(G, ·) is constant." No proof of the implication is given in [Mic13]. — [Mic13, Section 9](https://arxiv.org/abs/1207.0930)
- Conjecture 9.4, verbatim: "There exists a polynomial Q such that φ(G, K1,3) ≤ Q(|G|)." Preceded by: "In view of the previous conjecture and Conjecture 2 it is natural to bound φ(G, K1,3). It is an open problem if φ(G, K1,3) ≤ |G|. On the other hand, by a general theorem of Sturmfels [Stu96, Theorem 4.7] we have an exponential bound on φ(G, K1,3)." — [Mic13, Section 9](https://arxiv.org/abs/1207.0930)
- Other neighbours: Conjecture 9.5 (projective normality of X_P(T, Z2×Z2)); Questions 9.6 and 9.7 (ideal-theoretic bounded degree for secant varieties of Segre varieties; generation by flattenings). — [Mic13, Section 9](https://arxiv.org/abs/1207.0930)
- In [Mic13], X(T, G) := Spec C[P] is the affine cone and X_P(T, G) := Proj C[P] (Definition 3.16); Section 4 states that two ideals "define the same affine scheme if and only if they are equal". Conjecture 9.2 is stated with X(·), Conjecture 9.1 with "projective scheme". — [Mic13, Def. 3.16 and Section 4](https://arxiv.org/abs/1207.0930)
- Original form of 9.2, verbatim: "Conjecture 3.6. The variety X(Kn,1) is equal to the (scheme theoretic) intersection of all the varieties X(Ti), where Ti is a prolongation of Kn,1 that has only two inner vertices, both of them of valency at least three." — [DBM, Section 3.2](https://arxiv.org/abs/1011.3236)
- The argument for 9.2 ⇒ 9.3, as given in [DBM]: "All Ti have strictly smaller maximal valency than Kn,1, so if the conjecture holds then we can inductively use Theorem 23 of Sturmfels and Sullivant [...] In such a case the ideal of X(Kn,1) is just the sum of ideals of trees with smaller valency. More precisely, if 3.6 holds then the degree in which the ideals of claw trees are generated cannot grow when the number of leaves gets bigger. This means that φ(G) = φ(G, 3) which can be computed in many cases. In particular, Conjecture 3.6 implies all cases of Conjecture 3.1 in which we can compute φ(G, 3)". — [DBM, Section 3.2](https://arxiv.org/abs/1011.3236)
- [DBM] Proposition 3.9, verbatim: "Conjecture 3.6 holds for n large enough if and only if the function φ is bounded." Its proof shows that a binomial of degree ≤ m on K_{n,1} lies in the ideal of some two-inner-vertex prolongation as soon as "n > |H|^m + 1" (pigeonhole on the difference matrix); remark: "if Conjecture 3.1 of Sturmfels and Sullivant holds for the 3-Kimura model, then Conjecture 3.6 also holds for this model for n > 257", improved in Proposition 3.14 to n > 8. — [DBM, Prop. 3.9, 3.14](https://arxiv.org/abs/1011.3236)
- [DBM] Proposition 3.11: "Conjecture 3.6 holds for the binary Jukes-Cantor model" (G = Z2). — [DBM](https://arxiv.org/abs/1011.3236)
- Restatement in [MV17], verbatim: "Notice that our main theorem – Theorem 3.12 – can be restated as follows: the function φ(G, ·) is eventually constant. The ensuing result would be a desired strengthening of ours. Conjecture 4.3 ([Mic13, Conjecture 9.3]). We have φ(G, n + 1) = max(2, φ(G, n)). We are grateful to Seth Sullivant for noticing that this is equivalent to φ(G, ·) being constant, apart from the case when G = Z2 and n = 3, when the associated variety is the whole projective space. Conjecture 4.3 also implies the following. Conjecture 4.4 ([SS05, Conjecture 30]). The phylogenetic complexity of G = Z2 × Z2 is 4." — [MV17, Section 4](https://arxiv.org/abs/1606.07263)
- [MV17] also states "Conjecture 4.2. For any finite abelian group G, φ(G, 3) ≤ |G|." and "Taking into account the inductive approach presented in this article, it seems crucial to first understand the simplest tree K1,3." — [MV17, Section 4](https://arxiv.org/abs/1606.07263)
- Reduction to claw trees: "Proposition 4.6. [...] φ(G, T) ≤ max(φ(G, T1), φ(G, T2))" for T obtained by joining T1, T2 at distinguished leaves. — [Mic13, Prop. 4.6](https://arxiv.org/abs/1207.0930)
- Status of the degree bound: a local copy of Michałek's conjectures page records, for [SS05] Conjecture 29: "Grisha Pochuev recently produced a counterexample for ℤ/17ℤ, found with ChatGPT Astra." The page says nothing about Conjecture 9.3/4.3. — local file /home/user/papers/michalek-conj.html (origin URL not recorded in the file; two web searches found no independent source for the counterexample)

### Inferences
- 9.2 ⇒ 9.3, spelled out (my reconstruction of the [DBM] sketch): since 9.2 is an equality of affine schemes, it says I(K_{1,n}) = Σ_i I(T_i). Each T_i is a join of two claw trees with fewer than n leaves, so by [SS05, Thm 23]/[Mic13, Prop 4.6] I(T_i) is generated in degree ≤ max(2, max_{m<n} φ(G, m)) (the 2 comes from the quadratic edge invariants). Hence φ(G, n) ≤ max(2, max_{m<n} φ(G, m)) for n ≥ 4. Together with monotonicity φ(G, n−1) ≤ φ(G, n) (see Section 3), this gives φ(G, n) = max(2, φ(G, 3)) for all n ≥ 4. If "scheme-theoretic" were read projectively (saturated ideals only), the implication to the ideal-theoretic invariant φ would not follow; the affine reading is the one [DBM] uses ("the ideal ... is just the sum of ideals").
- The max(2, ·) in Conjecture 4.3 matters only for (Z2, n = 3), where φ = 0: for |G| ≥ 3 the tripod ideal is nonzero and contains no linear forms, so φ(G, 3) ≥ 2.
- 9.3 together with a bound on φ(G, 3) gives [SS05] Conjecture 29 for that G; conversely the Z/17 counterexample at n = 3 (as described in the task brief) refutes Conjectures 4.1/4.2 of [MV17] but is logically independent of 9.3. It also does not obviously refute 9.1 (scheme-theoretic degree |G|), which is strictly weaker than ideal-theoretic generation.
- [DBM] Prop. 3.9 combined with [MV17] Thm 3.12 (φ(G) < ∞) yields: Conjecture 9.2 (in [DBM]'s form) holds for every finite abelian G for all n > |G|^{φ(G)} + 1. Neither paper states this combination explicitly. Equivalently, the proof of Prop. 3.9 shows that a minimal generator of degree d of I(K_{1,n}) that is not induced from smaller valency can exist only for n ≤ |G|^d + 1.
- 9.1 neither implies nor is implied by 9.2/9.3 in the papers; 9.1 is the scheme-theoretic weakening of [SS05] Conj. 29.

### Gaps
- No written proof of 9.2 ⇒ 9.3 exists in [Mic13]; the only argument is the sketch in [DBM] Section 3.2.
- I could not locate a primary source (preprint) for the Z/17 counterexample, so I cannot say whether it affects Conjecture 9.1 or what it says for n > 3.
- Conjecture 9.2 is open for every G other than Z2 for small n, as far as these papers show.

## 2. The proof of eventual constancy in [MV17] (Theorem 3.12) and whether N is explicit

### Takeaway
The proof shows φ(G, n) ≤ φ(G, n−1) for n > N by using quadratic moves to make two adjacent columns of T0 and T1 agree, then adding those two columns to drop to n−1 leaves. N is not stated ("Fix N ≫ |G|"), but every step is combinatorially effective and the recursion in Lemma 3.9 can be unwound: taken at face value it gives N = |G|·K(|G|(F(G)+1), |G|, 3) with K(B,|G|,3) = 2·3^L·|G|^{L(L−1)/2}, L = B + |G| − 2, which for G = Z/4 is N ≈ 2·3^122·4^7382 ≈ 10^4503.

### Cited Findings
- Theorem 3.12 and its proof, verbatim opening: "Fix N ≫ |G|. Once N is fixed, the phylogenetic complexity φ(G, N) is finite by the Hilbert Basis Theorem. Assume n > N. We will show that φ(G, n) ≤ φ(G, n − 1). This implies that they are equal." — [MV17, Thm 3.12](https://arxiv.org/abs/1606.07263)
- Inductive step: by Lemma 3.11 one may assume two columns c_j, c_{j+1} of T0 equal the corresponding columns of T1; "summing coordinatewise the columns cj and cj+1 [...] we obtain a new pair of tables T̂0 and T̂1 with n − 1 columns", a binomial in I(X(G, K_{1,n−1})), generated in degree ≤ φ(G, n−1); "Each of such steps lifts to an exchange among at most φ(G, n − 1) rows in tables T0 and T1"; the lifted tables "only differ possibly on the columns cj and cj+1", fixed by quadratic moves. — [MV17, proof of Thm 3.12](https://arxiv.org/abs/1606.07263)
- Role of adding two group elements, verbatim: "one of the properties of equivariant models – a flattening – is mimicked for group–based models (on the algebra level though, but not on the level of varieties). This is the addition of two group elements that turns a flow of length n+1 to a flow of length n. The latter was a crucial property that allowed us to obtain the result: generation using the 'simple' equations (in our case, quadratic moves) and induced equations for smaller n." — [MV17, Section 4](https://arxiv.org/abs/1606.07263)
- F(G): "Let F(G) be a function of the cardinality of the group G. We assume F(G) > |G|^2 + 3|G|." Frequent elements: F_T = {h ∈ G | number of copies of h in T > F(G)·d} for a d×n table; non-frequent elements are "dots". The constraint is used as "F(G) − 3|G| > |G|^2" in Lemma 3.9. — [MV17, Section 3.2, Def. 3.2, Lemma 3.9](https://arxiv.org/abs/1606.07263)
- Lemma 3.3: for flows f, f′ and an index set I with |I| ≥ |G| there is a nonempty I′ ⊂ I on which a quadratic move can be performed. — [MV17, Lemma 3.3](https://arxiv.org/abs/1606.07263)
- Lemma 3.4: "we may assume that each row in T has at most |G|(F(G) + 1) dots." This is the bound B = |G|(F(G)+1) in Lemma 3.10. — [MV17, Lemma 3.4, 3.10](https://arxiv.org/abs/1606.07263)
- Lemma 3.5 (the only "n = n(z)" lemma) is explicit: "Setting n > z/ǫ". Remark 3.6: restrict to columns where a reference element g is a most frequent element, "a subtable with at least n/|G| columns". — [MV17, Lemma 3.5, Remark 3.6](https://arxiv.org/abs/1606.07263)
- Property S(s, r, t, k, T, Q) (Def. 3.7): Q a subtable with k columns, ≤ s dots per row, dots from a set of r group elements; holds if s = 1 and k ≥ 2, or if after moves the first t⌊k/t⌋ columns split into t blocks of k̃ = ⌊k/t⌋ columns, all but one of which (after splitting rows into |G| parts) satisfy S(s−1, r, |G|t, k̃, ·) or S(s, r−1, |G|t, k̃, ·). — [MV17, Def. 3.7](https://arxiv.org/abs/1606.07263)
- Lemma 3.9: "For every s, r, t ∈ N, for every k sufficiently large, [...] the property S(s, r, t, k, T, Q) holds." The proof sets "k > t·k̃" where k̃ is a threshold for S(s, r, |G|t, ·) (case s+1 ≥ |G| and case r = 1), respectively for both S(s, r, |G|t, ·) and S(s+1, r−1, |G|t, ·) (case r > 1). Then "we set K(s, r, t) such that for all k ≥ K(s, r, t) the property S(s, r, t, k, ·, ·) holds." — [MV17, Lemma 3.9](https://arxiv.org/abs/1606.07263)
- Lemma 3.10, verbatim hypothesis: "Let T0 and T1 be two compatible tables with at least |G|K(|G|(F(G)+1), |G|, 3) columns." Conclusion: after quadratic moves there is j such that no row of either table has a dot in both columns j and j+1. The algorithm uses t = 3|G|^i at step i so that the ≤ |G|^i parts of T0′ and the ≤ |G|^i parts of T1′ cannot exclude all blocks. — [MV17, Lemma 3.10](https://arxiv.org/abs/1606.07263)
- Lemma 3.11 ("for n sufficiently large") deduces exact agreement of two columns from Lemma 3.10 using only F(G)-frequency arguments (F(G) − |G| − 2 copies, Lemma 3.5 with ǫ = 1/|G|). — [MV17, Lemma 3.11](https://arxiv.org/abs/1606.07263)
- The authors' own view on effectivity: "We hope that some of the ideas of the paper can be made effective. In particular, in future work we plan to prove [SS05, Conjecture 30]." — [MV17, end of Section 1](https://arxiv.org/abs/1606.07263)

### Inferences
- Extraction of N (my derivation; the paper gives no number). Write g = |G|. From the proof of Lemma 3.9, thresholds satisfying the stated requirements are: K(1, r, t) = 2; K(s+1, r, t) = t·K(s, r, gt) if s+1 ≥ g or r = 1; K(s+1, r, t) = t·max(K(s, r, gt), K(s+1, r−1, gt)) if s+1 < g and r > 1. (k ≥ t·k̃ already gives ⌊k/t⌋ ≥ k̃; the paper's strict "k > t·k̃" changes nothing material.) Each recursion step multiplies by the current t and replaces t by gt, so along a chain of L steps K = 2·t^L·g^{L(L−1)/2}. The longest chain from (s, r) = (B, g) lowers s from B to g−1 (B−g+1 steps), then lowers r to 1 and s to 1 (2g−3 steps): L = B + g − 2. Hence K(B, g, 3) = 2·3^{B+g−2}·g^{(B+g−2)(B+g−3)/2}, and Lemma 3.10 ⇒ Lemma 3.11 ⇒ the inductive step of Theorem 3.12 hold for tables with at least g·K(B, g, 3) columns. So one may take N = g·K(g(F+1), g, 3) − 1, and φ(G, n) is constant for n ≥ N.
- Value for G = Z/4: smallest admissible F(G) = 4² + 3·4 + 1 = 29; B = 4·30 = 120; L = 122; K(120, 4, 3) = 2·3^122·4^7381; N ≈ 4·K = 2·3^122·4^7382 ≈ 8×10^4502 (log10 ≈ 4502.9, computed numerically). Using r = |G|−1 = 3 (the reference element g is frequent once n is large, so it is not a dot) only lowers this to about 10^4430. For comparison the same formula gives about 10^903 for |G| = 3, 10^15884 for |G| = 5, 10^109503 for |G| = 7.
- So "Fix N ≫ |G|" is not a non-effective step: no compactness or Noetherianity argument is hidden in it. The only appeal to non-constructive finiteness in Theorem 3.12 is "φ(G, N) is finite by the Hilbert Basis Theorem", and that too can be made explicit (but uselessly large) by Sturmfels' degree bound for toric ideals, as [Mic13] Remark 7.4 notes in the analogous scheme-theoretic situation.
- What the proof does not give: any bound on φ(G, n) for n ≤ N beyond the general toric bound, and no information on whether φ changes between n = 3 and n = N. It proves non-increase only beyond N.
- Caveat on the extraction: I took Lemmas 3.4–3.11 at face value and did not re-verify the proof. Some steps are loosely specified in the text (dots are defined relative to a table T but used for the column-restricted subtable T′; the side condition in Def. 3.7(ii) that moves do not disturb dots in the same stripe outside Q is asserted rather than checked move by move). A rigorous effective version might need a different, probably larger, constant.

### Gaps
- No explicit N appears anywhere in [MV17] (arXiv v2 or the published ANT version); the 10^4503 figure is my own unwinding and has not been checked against any published source.
- I found no later paper giving an effective or improved version of Theorem 3.12 for general G (one web search; [MV19] treats only Z2×Z2 by a separate bespoke argument).

## 3. Is φ(G, n) ≤ φ(G, n+1) proved anywhere? Is φ(G, n+1) ≤ max(2, φ(G, n)) proved for any G or range of n?

### Takeaway
Monotonicity φ(G, n) ≤ φ(G, n+1) is used implicitly ("This implies that they are equal") but I found no stated proof in any of the papers read; it does have a two-line proof by padding tables with a zero column. The reverse inequality φ(G, n+1) ≤ max(2, φ(G, n)) is proved for all n only for G = Z2, Z3, Z2×Z2 (where full constancy is known), for n ≫ 0 for Z_p ([Mic15]) and for every G ([MV17], with the non-explicit N of Section 2).

### Cited Findings
- [MV17] proves only "φ(G, n) ≤ φ(G, n − 1)" for n > N and then asserts "This implies that they are equal." No argument for φ(G, n) ≥ φ(G, n−1) is given. — [MV17, proof of Thm 3.12](https://arxiv.org/abs/1606.07263)
- [Mic15] similarly: "We will prove an equivalent statement: for n large enough, the ideal corresponding to the claw tree with n+1 leaves is generated in the same degree as for n leaves, that is ψ(n+1, Zp) = ψ(n, Zp)"; the proof shows only that one "can pass from M1 to M2 exchanging at most ψ(n, Zp) flows at each step". — [Mic15, Section 3](https://arxiv.org/abs/1508.04177)
- G = Z2: "Theorem 26. The toric ideal I_{Z2,n} is generated in degree two. In symbols, φ(Z2, n) = 2 for n ≥ 3" ([SS05] indexing, i.e. at least 4 leaves; the table row for 3 leaves shows no generators). — [SS05, Thm 26 and table](https://arxiv.org/abs/q-bio/0402015)
- G = Z3: "Theorem 1.4. The phylogenetic complexity of the group Z3 equals 3." Base cases up to n = 6 from computation ([DBM] Computation 3.3: "φ(6, Z3) = 3"), general argument for n ≥ 7. — [Mic15, Thm 1.4, Section 4](https://arxiv.org/abs/1508.04177); [DBM, Computation 3.3](https://arxiv.org/abs/1011.3236)
- G = Z2×Z2: "Theorem 3.1. The phylogenetic complexity of the Kimura 3-parameter model φ(Z2 × Z2) equals four." Proof by induction on n with base n = 3; n ≤ 5 by computer (n = 5: 22240 generators, 4ti2 on a 1024 GB server), n = 6 by a regularity bound plus computation, n ≥ 7 by hand. Theorem 3.4: tables with n ≥ 7 columns without "bad pairs" in columns n−1, n are "generated in degree at most φ(G, K1,n−1)". — [MV19, Thm 3.1, Prop. 3.2, Thm 3.4](https://arxiv.org/abs/1704.02584)
- Z_p, p prime: "Theorem 1.3. For any prime number p the phylogenetic complexity of Zp is finite", via ψ(n+1, Zp) ≤ ψ(n, Zp) for n large, with "large" coming from [Mic13, Lemma 6.5] applied with s = 4p, a = 2, ǫ < 1/2. — [Mic15, Thm 1.3, Lemma 3.4, 3.5](https://arxiv.org/abs/1508.04177)

### Inferences
- Proof of monotonicity (mine; not found stated in the sources). Let (T0, T1) be compatible d×n tables. Append a column of zeros to both: the rows remain flows and the tables remain compatible, so they are connected by moves each replacing at most φ(G, n+1) rows by a compatible set of rows. A compatible replacement preserves every column multiset, so the last column stays identically 0 throughout; deleting it gives a chain of moves of the same sizes between T0 and T1 in n columns. Hence φ(G, n) ≤ φ(G, n+1). (Geometrically, P_{G,n} is the face of P_{G,n+1} where the last coordinate is 0.) This justifies the "they are equal" in [MV17] and [Mic15].
- Consequently φ(G, ·) is non-decreasing, φ(G) = lim φ(G, n), and φ(G) ≥ φ(G, 3). Conjecture 9.3 is therefore equivalent to the single family of inequalities φ(G, n+1) ≤ max(2, φ(G, n)) for all n ≥ 3, and also to φ(G) = max(2, φ(G, 3)).
- Conjecture 4.3 is a theorem for G = Z2, Z3 and Z2×Z2: in each case φ(G, n) = |G| for all n ≥ 3 (n ≥ 4 for Z2), using the cited upper bounds, the tripod values in the [SS05] table (3 and 4) and monotonicity.
- For no other group is the inequality known in an explicit range of n. For Z/4 specifically nothing beyond the computed values φ(Z4, 3) = φ(Z4, 4) = 4 ([SS05] table rows "Z4, 2" and "Z4, 3") is established.

### Gaps
- No source read states or proves monotonicity explicitly; it may be regarded as folklore. I did not search [SS05] Sections 1–4 or the toric-fiber-product literature exhaustively for it.
- I did not read the full case analysis of [MV19] or of [Mic15] Section 4.

## 4. What [CFSM] (arXiv:1402.6945) proves and whether it helps for constancy or Z/4

### Takeaway
[CFSM] proves that on the open torus orbit U (all coordinates nonzero) the variety is a complete intersection of codim X explicit binomials of degree ≤ max(3, a_i) ≤ |G| for G = Z_{a_1}×…×Z_{a_k}, and that on U the claw-tree variety is the scheme-theoretic intersection of two varieties of smaller-valency trees. This is a statement about the lattice of relations (Laurent binomials), not about ideal generators, so it gives no bound on φ and no constancy; it verifies a necessary local consequence of Conjecture 9.2.

### Cited Findings
- Abstract: "For any finite abelian group G, we provide an explicit construction of codim X phylogenetic invariants (polynomial equations) of degree at most |G| that define the variety X on a Zariski open set U." U is "the locus of points with all coordinates different from zero". — [CFSM, abstract and Section 1](https://arxiv.org/abs/1402.6945)
- Theorem 6.1, verbatim: "For any abelian group G = Za1 × · · · × Zak and any tree T the associated variety X in the Zariski open set U is a complete intersection of explicitly constructed phylogenetic invariants of degree at most max(3, ai)." Theorem 3.15 is the tripod case. — [CFSM, Thm 3.15, 6.1](https://arxiv.org/abs/1402.6945)
- Mechanism: on U the variety is cut out by Laurent binomials L(M) − 1, and "A set of Laurent binomials L(Mi) − 1 [...] defines the variety X in the Zariski open set U if and only if Mi generate adm(G)" (the Z-module of admissible matrices). — [CFSM, Remark 2.12, Cor. 3.6](https://arxiv.org/abs/1402.6945)
- Theorem 5.1, verbatim: "The variety X associated to the claw tree T with l leaves is a complete intersection in the Zariski open set U. Moreover, if l ≥ 4, then X is the scheme theoretic intersection in U of two varieties associated to two trees of smaller valency". This settles "Conjecture 1.2. [Mic12, Conjecture 7.9] On the orbit U the variety associated to a claw tree is an intersection of varieties associated to trees with nodes of strictly smaller valency." The proof adds g − 1 explicit quadrics (edge invariants of a second tree T″) to the equations of a tree T′ with a valency-3 and a valency-(l−1) node. — [CFSM, Conj. 1.2, Thm 5.1](https://arxiv.org/abs/1402.6945)
- Z/4 tripod: Example 3.11 lists the 6 = (g−1)(g−2) admissible matrices X(1,2), X(1,3), X(2,2), X(2,3), X(3,2), X(3,3); "The matrices X(1, 2) and X(1, 3) have degree 3"; all have degree ≤ 4 by Proposition 3.9. — [CFSM, Prop. 3.9, Example 3.11](https://arxiv.org/abs/1402.6945)
- The authors note the limitation for Z2×Z2: "we have constructed a set of phylogenetic invariants of degree 3 that do not generate the whole ideal, but define the variety on an open set." — [CFSM, Remark 3.16](https://arxiv.org/abs/1402.6945)
- Summary by [MV17]'s table: row "On a Zariski open subset": "Degree ≤ |G| [CFSM15b, CFSM15a]". — [MV17, Section 1](https://arxiv.org/abs/1606.07263)

### Inferences
- For Z/4 and any tree (in particular every K_{1,n}), X ∩ U is defined by explicit binomials of degree ≤ 4. This is consistent with φ(Z4) = 4 but does not bound φ(Z4, n): generating the lattice of relations is far weaker than generating the toric ideal (the ideal is the saturation of the lattice ideal generators with respect to the product of all variables).
- Theorem 5.1 is exactly Conjecture 9.2 restricted to U (and with only two trees). It is a necessary condition for 9.2, so no obstruction to 9.2/9.3 can be found on the torus; any failure of 9.2 would have to live on the coordinate hyperplanes.
- It gives nothing for the n-dependence of φ.

### Gaps
- I did not read the companion paper cited as [CFSM15a] (arXiv:1512.07174, "Complete intersection for equivariant models").

## 5. What the set-theoretic and scheme-theoretic finiteness results give

### Takeaway
[DE] gives a tree-independent degree bound set-theoretically, non-constructively and with no explicit number. [Mic13] gives a tree-independent bound for the projective scheme, constructively: the scheme-theoretic degree for all K_{1,m}, m ≥ N, is at most φ(G, N) for an N "explicitly computable" from Lemma 6.5 (not computed), with degree exactly 4 for Z2×Z2. Only [MV17] is ideal-theoretic.

### Cited Findings
- [DE] Theorem 1.1: "For any action of an Abelian group G on a finite alphabet B, there exists a uniform bound D = D(B, G) such that for any finite tree T the Zariski closure of the equivariant tree model for (T, B, G) is defined by polynomial equations of degree at most D." — [DE, Thm 1.1](https://arxiv.org/abs/1207.1282)
- [DE] on its own limits: "Our result is weaker in that we do not prove the existence of a degree bound for polynomials generating the ideal—our result is set-theoretic rather than ideal-theoretic—and that we do not find an explicit bound." and "We hasten to say that our proofs are non-constructive. In particular, they do not yield an explicit bound D(B, G) and they do not give an explicit algorithm". Method: Noetherianity up to symmetry of an infinite-dimensional flattening variety (Theorem 5.6). — [DE, Section 1](https://arxiv.org/abs/1207.1282)
- [Mic13] Main Theorem 2: "For any G-model there exists a constant d such that the associated projective scheme X_P can be defined by an ideal generated in degree at most d for any tree T." Main Theorem 1: for Z2×Z2 the projective scheme is defined in degree ≤ 4. — [Mic13, Section 1](https://arxiv.org/abs/1207.0930)
- [Mic13]'s comparison with [DE]: "(2) Our results are scheme theoretic, while the results in [DE] are set theoretic; (3) Our results are constructive, while methods of [DE] are existential." and "Still, our bounds on the degree in which the schemes are defined are weak." — [Mic13, Section 1](https://arxiv.org/abs/1207.0930)
- [Mic13] Lemma 7.3, verbatim: "For any finite, abelian group G there exists N, such that if the ideal I(K1,N, G) is generated in degree d, then the scheme X(K1,m, G) can be defined by an ideal generated in degree d for any m ≥ N." N is taken "from Lemma 6.5 for g = |G| − 1, s = |G|, ǫ < 1/2 and a = 2". The proof merges two coordinates x, x+1 at which every flow in the relation has at most one non-neutral entry (after multiplying by a power of the neutral flow, Lemma 7.2, which reduces supports to Davenport-constant size). — [Mic13, Lemma 6.5, 7.2, 7.3](https://arxiv.org/abs/1207.0930)
- [Mic13] Remark 7.4: "The constant N can be explicitly computed by explicit calculation of k appearing in the proof Lemma 6.5. Moreover, due to standard theorems, a toric variety in bounded dimension and bounded exponents of defining monomials has got an explicitly bounded degree of generation - [Stu96, Theorem 4.7, Corollary 4.15]." — [Mic13, Remark 7.4](https://arxiv.org/abs/1207.0930)
- Lemma 6.5's proof is a double induction on s and g with "N′ >> 0" and "N = k(N′ + 1) for large k" at each step; no numbers are given. — [Mic13, Lemma 6.5](https://arxiv.org/abs/1207.0930)
- State-of-the-art table in [MV17]: generators of the ideal: "Finite by Theorem 3.12"; projective scheme: "Degree 3 [DB16]" for Z3, "Degree 4 [Mic13]" for Z2×Z2, "Finite [Mic13]" for general G; set-theoretically: "Finite [DE15]"; on a Zariski open subset: "Degree ≤ |G|". — [MV17, Section 1](https://arxiv.org/abs/1606.07263)

### Inferences
- Hierarchy for general G: set-theoretic (existence only, [DE]) < projective-scheme-theoretic (constructive but astronomically large, [Mic13]) < ideal-theoretic (existence; effective only after unwinding, [MV17]). None gives a usable number for Z/4.
- The scheme-theoretic merge step in [Mic13] Lemma 7.3 is the direct ancestor of the two-column addition in [MV17] Theorem 3.12 and [Mic15] Lemma 3.5; saturation by the neutral flow is what makes it easy there (supports become bounded), and removing that saturation is the whole difficulty of [MV17].
- Lemma 7.3 is a scheme-theoretic stabilisation statement, not a scheme-theoretic analogue of constancy from n = 3.

### Gaps
- No explicit scheme-theoretic degree bound for Z/4 (e.g. Conjecture 9.1 for Z/4) was found; [Mic13] says "We believe that the methods of Section 8 could be adopted to prove cases of this conjecture, especially for groups of small cardinality" but I found no paper doing this for Z/4.
- I did not unwind Lemma 6.5 into a number.

## 6. If constancy held: consequences for Z/4, Z/5, Z/7

### Takeaway
Constancy (Conjecture 9.3/4.3) would give φ(G) = φ(G, 3), hence φ(Z4) = 4, φ(Z5) = 4, φ(Z7) = 6, all within |G|; the Z/17 failure at n = 3 does not interfere.

### Cited Findings
- Computed tripod values (4ti2), in [SS05]'s table (rows "(G, 2)" = 3 leaves): Z4: 16 cubics, 6 quartics, φ = 4; Z5: 50 cubics, 50 quartics, φ = 4; Z6: φ = 6; Z7: 245 cubics, 1764 quartics, 1764 quintics, 294 sextics, φ = 6; Z2×Z2: φ = 4. — [SS05, Section 5 table](https://arxiv.org/abs/q-bio/0402015)
- Four-leaf values: Z4 row "(Z4, 3)": 344 quadrics, 256 cubics, 96 quartics, φ = 4; and "φ(4, Z5) = 4" ([DBM] uses the leaf count; the same list has "φ(6, Z3) = 3", which [Mic15] uses as the 6-leaf base case). Also "φ(3, Z8) = 8", "φ(3, Z2 × Z2 × Z2) = 8", "φ(3, Z4 × Z2) = 8". — [SS05 table](https://arxiv.org/abs/q-bio/0402015); [DBM, Computation 3.3](https://arxiv.org/abs/1011.3236)
- "if 3.6 holds then [...] φ(G) = φ(G, 3) which can be computed in many cases." — [DBM, Section 3.2](https://arxiv.org/abs/1011.3236)

### Inferences
- Under constancy: φ(Z4) = φ(Z4, 3) = 4 = |G|; φ(Z5) = 4 < 5; φ(Z7) = 6 < 7. So [SS05] Conjecture 29 would hold for these three groups, and for Z5 and Z7 strictly.
- Unconditionally (monotonicity, Section 3): φ(Z4) ≥ 4, φ(Z5) ≥ 4, φ(Z7) ≥ 6.
- The available data are consistent with constancy: φ(Z4, 3) = φ(Z4, 4) = 4 and φ(Z5, 3) = φ(Z5, 4) = 4.
- Since the Z/17 counterexample is at n = 3, constancy would give φ(Z17) = φ(Z17, 3) > 17; constancy and the degree bound are independent statements.

### Gaps
- No computed value of φ(Z4, n) for n ≥ 5 or φ(Z5, n), φ(Z7, n) for larger n was found in these sources.
- The three-leaf values quoted in the brief (φ(Z4,3) = 4, φ(Z5,3) = 4, φ(Z7,3) = 6) match the [SS05] table; I did not recompute them.

## 7. Candid assessment: can an effective eventual-constancy proof reduce φ(Z/4) ≤ 4 to a feasible finite computation?

### Takeaway
No. The [MV17] argument is effective in principle but its threshold for Z/4 is of order 10^4503 leaves, and it only controls n beyond the threshold; a feasible reduction would need a new, Z/4-specific proof in the style of [MV19] bringing the threshold down to n ≈ 6–7, where even the base cases are at the edge of computability.

### Cited Findings
- The inductive step of [MV17] holds only for tables with at least |G|·K(|G|(F(G)+1), |G|, 3) columns (Lemma 3.10), and the base "φ(G, N) is finite by the Hilbert Basis Theorem". — [MV17, Lemma 3.10, Thm 3.12](https://arxiv.org/abs/1606.07263)
- For Z2×Z2 (same number of variables, 4^{n−1}, as Z/4) the proof of φ = 4 needed computation for n ≤ 5 (n = 5 on "a server equipped with [...] a memory of 1024Gb RAM"), a regularity argument for n = 6 because "we expect the computation to be not feasible: it would run for several years [...] and a memory of 1Tb RAM would not be sufficient", and a long hand case analysis for n ≥ 7. — [MV19, Section 3.1](https://arxiv.org/abs/1704.02584)
- [MV19] describes its own proof as giving "in principle [...] an inductive procedure to obtain all generators in case of K1,n+1, assuming the generators for K1,n to be known." — [MV19, Section 1](https://arxiv.org/abs/1704.02584)
- A degree-d binomial on K_{n,1} is induced from a tree of smaller valency once n > |G|^d + 1. — [DBM, proof of Prop. 3.9](https://arxiv.org/abs/1011.3236)

### Inferences
- With N ≈ 10^4503 (Section 2), "compute φ(Z4, n) for n ≤ N" means toric ideals in 4^{n−1} variables; nothing beyond n = 5 or 6 is realistic. Tightening the constants in [MV17] (smaller F, r = |G|−1, sharper pigeonholes) changes the exponent tower only marginally because the growth comes from the nested subdivision t → |G|t over about B + |G| steps with B ≈ |G|^3.
- The [DBM] pigeonhole gives a much smaller threshold, n > 4^d + 1, but only degree by degree: it shows a new minimal generator of degree d must first appear at some n ≤ 4^d + 1 (n ≤ 1025 for d = 5). It cannot bound d, so it does not reduce φ(Z4) ≤ 4 to a finite check either; one would need to exclude new generators in every degree d ≥ 5.
- What would be needed is a direct proof that φ(Z4, n) ≤ max(4, φ(Z4, n−1)) for all n ≥ n0 with small n0, i.e. a Z/4 analogue of [MV19] Theorem 3.4 plus an argument that "bad pairs" in two columns can always be eliminated with moves of degree ≤ 4. For Z2×Z2 this took roughly 40 pages using the special structure (every element is an involution); Z/4 has an element of order 4, so the case analysis is not transferable verbatim. Base cases n = 3, 4 are known (φ = 4), n = 5 (256 variables) is plausibly computable as for Z2×Z2, n = 6 (1024 variables) is not by brute force.
- Conjecture 9.2 for Z/4 at n = 4, 5 (is I(K_{1,n}) the sum of the ideals of its two-inner-vertex prolongations?) is a finite, checkable statement for small n and would be informative evidence, but again not a proof for all n.

### Gaps
- No source discusses an effective bound for Z/4 specifically; the assessment above is my inference from the structure of the proofs.
- Whether a Z/4 analogue of the [MV19] argument has been attempted since 2019 is unknown to me (one web search found nothing).
