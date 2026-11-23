# The Z/17 counterexample to the Sturmfels–Sullivant degree bound, indispensable binomials, and normality

Conventions used below.
- "Repo" = `/home/user/repos/z17` (clone of https://github.com/Grisha-Pochuev/phylogenetic-complexity-z17-counterexample, single commit f58a75d, 2026-11-04). Files were read, never executed. Paper = `paper/phylogenetic_Z17_counterexample_EN.tex`; RU proof = `proof/phylogenetic_Z17_complete_proof_RU.md`.
- **[OWN COMPUTATION]** marks results I produced in this session with my own scripts (saved in `counterexample_scripts/` next to this file) and 4ti2 (`/usr/bin/4ti2-markov`). They are not from the literature and have not been reviewed by anyone else. Where I say "independently verified" I mean a standalone brute-force script (`indep.py`) that shares no code with the search code.
- phi(G,n) = largest degree of a minimal generator of the toric ideal of the group-based model of G on the claw tree with n leaves (tables of n columns, rows = flows summing to 0); phi(G) = sup_n phi(G,n) ([Michałek–Ventura arXiv:1606.07263](https://arxiv.org/abs/1606.07263), Section 1, lines 56–58 of the local text `/home/user/papers/1606.07263.txt`).

**Headline for the report writer.** (1) The Pochuev Z/17 example is correct: I re-derived every stated invariant with independent code. (2) Its mechanism is a face of the tripod polytope with d+2 vertices (one-dimensional kernel), whose unique circuit has degree 18; "determinant 17" is forced by the group order and is not an arithmetic coincidence. (3) **[OWN COMPUTATION]** The same mechanism already works for smaller groups: I found and independently verified two-element fibres giving **phi(Z/12,3) >= 13** and **phi(Z/13,3) >= 17** (also phi(Z/19,3) >= 20, and a second, different Z/17 example of degree 18). So 17 is not the smallest order violating phi(G) <= |G|. (4) For |G| <= 8 the exact three-leaf values are known and equal at most |G|, so the first violating order is between 9 and 12. (5) Nothing found here threatens phi(Z/4) <= 4; the mechanism needs large supports that Z/4 does not have on three leaves, and Z/4 is on the normal side of the Dinu–Vodička classification.

## 1. The counterexample: what is claimed, how each claim is proved, what the manuscript says about discovery and minimality

### Takeaway
Two explicit 18x3 tables A, B over Z/17 have the same column multisets, no row in common, and are the only two tables with those column multisets; hence the degree-18 binomial X^A − X^B is in every binomial generating set and phi(Z/17,3) >= 18 > 17. The manuscript gives no account of how the example was found and explicitly does not claim phi(Z/17) = 18 or anything about smaller groups.

### Cited Findings

**The data.**
- 22 row types r_1..r_22 with multiplicity vectors alpha (table A) and beta (table B); A uses 11 types with multiplicities (2,1,3,2,1,1,1,1,1,1,4), B uses the other 11 with multiplicities (3,2,1,2,1,1,2,2,1,2,1); both sum to 18. Every row sums to 17 or 34. — Repo paper, Section 2, Table 1; `data/tables_Z17.json`.
  - A = (1,3,13)x2, (1,11,5), (7,8,2)x3, (8,15,11)x2, (10,0,7), (10,6,1), (11,10,13), (11,16,7), (14,6,14), (14,15,5), (15,1,1)x4.
  - B = (1,15,1)x3, (7,3,7)x2, (7,16,11), (8,8,1)x2, (10,10,14), (10,11,13), (11,1,5)x2, (14,1,2)x2, (15,0,2), (15,6,13)x2, (15,8,11).
- Common column multisets: C1 = {1^3,7^3,8^2,10^2,11^2,14^2,15^4}, C2 = {0,1^4,3^2,6^2,8^3,10,11,15^3,16}, C3 = {1^5,2^3,5^2,7^2,11^2,13^3,14}; supports S1, S2, S3 of sizes 7, 9, 7. — Repo paper, Section 2.

**Claim 1 (22 admissible row types).** Any table compatible with A has entries in S1 x S2 x S3; for (a,b) in S1 x S2 the third entry is forced to be −a−b, and it lies in S3 for exactly 22 pairs (3,3,2,4,3,3,4 types for first entries 1,7,8,10,11,14,15). — Repo paper, Section 2; RU proof, section 2. The verification script rebuilds the list from all 17^3 triples rather than trusting the list (`verification/verify_phylogenetic_Z17.py`, function `verify`).

**Claim 2 (incidence matrix and kernel).** M is the 23x22 0/1 matrix with rows indexed by (column j, value v in S_j) and columns by row types; M x records the column multiplicities of the table with type counts x. Lemma 3: ker_Q M = Q(beta − alpha). Proof idea: the 7 + 9 equations for columns 1 and 2 are solved by hand with 7 free parameters (a,b,d,e,f,g,h) = (z1,z2,z6,z7,z9,z11,z17); six of the column-3 equations then give h = −g, f = a+d, a = 2d−2e, g = b+4d−e, 7d−2e+3b = 0, b = 9d−5e, hence 34d − 17e = 0, e = 2d, and z = d(beta − alpha); the seventh column-3 equation is automatically satisfied. All equalities are over Q, not mod 17. — Repo paper, Section 3, Lemma 3; RU proof, section 3.
- Rank 21, nullity 1; determinant certificate: deleting rows 16 and 23 and column 22 of M gives a 21x21 minor of determinant 17. — Repo paper, Section 5 ("Reproducible verification"); RU proof, section 6; stored outputs in `verification/results/`.

**Claim 3 (exactly two tables).** Any compatible count vector is x = alpha + t(beta − alpha), t rational; coordinate 6 gives x_6 = t so t is a non-negative integer, coordinate 2 gives x_2 = 1 − t >= 0, so t is 0 or 1. — Repo paper, proof of Theorem 1.

**Claim 4 (general obstruction, Lemma 2).** If fixed column multisets admit exactly two m-row tables A, B with no common row type, they cannot be connected by moves of size < m: a smaller move keeps at least one old row, so cannot reach B, and its result must be A or B, so it is trivial; this excludes chains of any length, not only a direct move. — Repo paper, Section 1, Lemma 2.
- Consequence: phi(Z/17,n) >= 18 for every n >= 3 by appending all-zero columns (the zero columns' multisets are preserved by every move). — Repo paper, Theorem 1; RU proof, section 9.

**Claim 5 ("direct ideal-theoretic certificate", Proposition 4).** Let I be the kernel of X_(a,b,c) -> U_a V_b W_c on the 289 flows, E the 22 types, pi: R -> R_E the map setting variables outside E to 0, and F = X^alpha − X^beta. Then pi(I) = I ∩ R_E = (F). Proof idea: (i) for a binomial of I, if one monomial uses only E then it has no column label outside the S_j, so by equal column multiplicities neither does the other, and since E contains *all* flows with labels in the S_j the other monomial also uses only E; so pi keeps both monomials or kills both, giving pi(I) = I ∩ R_E; (ii) ker_Z M = Z(beta − alpha) because (beta − alpha)_6 = 1, so every binomial of I ∩ R_E is a monomial multiple of (X^alpha)^m − (X^beta)^m, divisible by F. Hence every element of I of degree <= 17 maps to 0 under pi while pi(F) = F is non-zero, so I is not generated in degrees <= 17. This does not use the table-connectivity theorem. — Repo paper, Section 4, Proposition 4; RU proof, section 10.

**Claim 6 ("boundary-point obstruction", Corollary 5).** Let J_{<=17} be the ideal generated by all elements of I of degree <= 17. Then F is not in the radical of J_{<=17}. Proof: the point P with coordinate 1 on the 11 row types of A and 0 elsewhere has all variables outside E equal to 0, so by Proposition 4 every element of J_{<=17} vanishes at P, but F(P) = 1 − 0 = 1. So equations of degree <= 17 do not cut out the variety even set-theoretically. The manuscript stresses this is a boundary point (many zero coordinates) and makes no claim on the locus where all coordinates are non-zero. — Repo paper, Section 5, Corollary 5; RU proof, section 11.

**Verification material (read, not run).**
- `verify_phylogenetic_Z17.py`: standard library only; exact Fraction row reduction (rank 21, pivots = first 21 columns), the determinant-17 minor, and an independent enumeration of all non-negative count vectors (finds exactly alpha and beta, 372 group states). — Repo, `verification/verify_phylogenetic_Z17.py`.
- `audit_Z17_independent.py`: fixes the 18 first-column entries in sorted order and counts labelled fillings of columns 2, 3 by memoised dynamic programming: 96 = 24 (from A) + 72 (from B), 981 states, so no third table. — Repo, `verification/audit_Z17_independent.py` and `verification/results/audit_Z17_independent_result.json`.
- `audit_Z17_symbolic.py`: SymPy rank, nullspace, minor and a check of the hand parametrisation. — Repo, `verification/audit_Z17_symbolic.py`.
- The GitHub workflow is manual-only (`workflow_dispatch`). — Repo, `.github/workflows/verify.yml`.

**How it was found; minimality.**
- The manuscript and README do not describe the search method. They say only that "the manuscript and verification package were prepared with AI assistance" (README, "AI-assistance disclosure"; paper, "Verification status"). The stored re-run log is headed "Independent local re-run in an isolated ChatGPT execution environment", dated 9 September 2026. — Repo, `verification/results/local_rerun_2026-09-09.txt`.
- Michałek's conjectures page says: "For years I offered a prize for the general Conjecture 29: €3,000 for a proof and at least a good dinner for a counterexample. It turned out to be the dinner. Grisha Pochuev recently produced a counterexample for ℤ/17ℤ, found with ChatGPT Astra." The same entry is headed "Conjecture 5 — Proved" because it lists Conjectures 29 and 30 together and Conjecture 30 (G = Z2 x Z2, complexity 4) was proved by Michałek–Ventura (Adv. Math. 343 (2019)). — local file `/home/user/papers/michalek-conj.html`, entry "Conjecture 5".
- No minimality claim: "no equality phi(Z/17Z) = 18 is asserted; the lower bound is sufficient to disprove the proposed inequality" (paper, end of Section 5; RU proof, section 8). Nothing is said about whether 17 is the smallest group order or 18 the smallest degree, or about other groups.
- Status: "working manuscript for independent verification"; "External expert review, publication priority, and publication status are not asserted here." — Repo README. A preprint record exists (title "A Degree-18 Counterexample to the Group-Order Bound for Phylogenetic Complexity", dated 2026-09-08) at [Zenodo record 22677672](https://zenodo.org/records/22677672), indexed by OpenAlex with [doi:10.6084/m9.figshare.33471694](https://doi.org/10.6084/m9.figshare.33471694); its abstract adds that the note contains "an indispensable-binomial formulation".
- Numbering: the conjecture is "Conjecture 27" in the arXiv version of Sturmfels–Sullivant ("For any finite abelian group G and any positive integer n we have φ(G, n) ≤ |G|") and "Conjecture 29" in the journal version; the Z2 x Z2 conjecture is 28 (arXiv) / 30 (journal). — [Sturmfels–Sullivant arXiv:q-bio/0402015](https://arxiv.org/abs/q-bio/0402015), Section 5 (local text lines 911–920); [Michałek–Ventura arXiv:1606.07263](https://arxiv.org/abs/1606.07263), Conjectures 4.1 and 4.4.

**[OWN COMPUTATION] Independent re-derivation.** With my own scripts (`verify17.py`, `indep.py`), reading only `data/tables_Z17.json` as data: rows sum to 0 mod 17; margins equal; no common row type; supports of sizes 7, 9, 7 contain exactly 22 flows; M is 23x22 of rank 21; B − A spans the kernel; the stated minor is 17; brute-force depth-first enumeration of all non-negative count vectors (8.3 million nodes) finds exactly two tables. Additional facts not in the manuscript: the Smith normal form of M is diag(1,...,1,17,0) (twenty 1s), and the 22 minors obtained by deleting rows 16, 23 and one column k are exactly 17·(beta − alpha)_k up to sign: (34, −17, −51, 34, 51, 17, −34, −34, 17, −17, −17, 17, −34, −17, 17, 34, 17, −17, −17, −68, −34, 17).

### Inferences
- The proof is elementary and I found no gap: the only non-trivial inputs are the 22-type list, the one-dimensional rational kernel, and integrality from a coordinate equal to 1. All three reproduce under independent code.
- Proposition 4 is the standard fact that restricting a toric ideal to the vertices of a face of the polytope gives the toric ideal of the face, and that minimal generators of the face ideal are minimal generators of the whole ideal. Here the "face" is {x_{j,g} = 0 for g outside S_j}; because all coordinates are non-negative this is a face of the tripod polytope P_{Z17,3}, and E is exactly its vertex set. The manuscript proves this directly rather than citing it.
- The face has 22 vertices and affine dimension 20 (lattice rank 21), i.e. it is a polytope with d+2 vertices; its toric ideal is principal, generated by its unique circuit. This is the cleanest one-line description of the mechanism: **a (d+2)-vertex face of the tripod polytope whose circuit has degree 18**.
- "Found with ChatGPT Astra" is Michałek's description; the repository itself only says "AI assistance". The method (random search, constraint solving, etc.) is not documented anywhere I could find.

### Gaps
- No description of the search that produced the example; no statement of whether smaller orders were tried.
- I could not fetch the Zenodo/figshare PDF itself (only the OpenAlex metadata and abstract); the abstract mentions an "indispensable-binomial formulation" that is not a separate section of the repo's TeX source.
- Whether phi(Z/17,3) is exactly 18 is unknown (the manuscript says so; my search found a second degree-18 example but nothing larger for Z/17 in a short run).

## 2. General principle: two-element fibres, indispensable binomials, circuits, Graver bases

### Takeaway
A fibre consisting of exactly two monomials with disjoint supports is precisely the fibre of an indispensable binomial: it lies in every binomial generating set, so its degree is a lower bound for phi. The Z/17 example is the special case where the whole face has a rank-one kernel, so the binomial is also a circuit of the configuration.

### Cited Findings
- Definition: a binomial B in a toric ideal I_A is indispensable if every system of binomial generators of I_A contains B or −B. — [Charalambous–Katsabekis–Thoma, arXiv:math/0607249](https://arxiv.org/abs/math/0607249), Introduction (notion attributed there to Ohsugi–Hibi; indispensable monomials to Aoki–Takemura–Yoshida, [arXiv:math/0511290](https://arxiv.org/abs/math/0511290)).
- For an A-degree b, G(b) is the graph on the fibre deg_A^{-1}(b) with an edge {x^u, x^v} whenever x^u − x^v lies in the ideal I_{A,b} generated by binomials of strictly smaller A-degree; monomials with a common factor are adjacent; every connected component is complete; G(b) is disconnected if and only if b is a Betti degree (a degree of a minimal generator). — [arXiv:math/0607249](https://arxiv.org/abs/math/0607249), Definition 2.1 and Proposition 2.2.
- Corollary 2.10: "B = x^u − x^v in I_A with A-degree b is indispensable if and only if the graph G(b) consists of two connected components, {x^u} and {x^v}. Moreover b is minimal binomial A-degree." — [arXiv:math/0607249](https://arxiv.org/abs/math/0607249), Corollary 2.10.
- For arbitrary binomial ideals: "The binomial B in I is indispensable if and only if the graph Γ_{F_B} consists of two isolated vertices"; indispensable binomials can be computed from any binomial generating set. — [Charalambous–Thoma–Vlădoiu, arXiv:1501.05142](https://arxiv.org/abs/1501.05142), Theorem 2.6 and Theorem 3.3.
- The universal Gröbner basis is contained in the Graver basis (the set of primitive binomials). — [arXiv:1501.05142](https://arxiv.org/abs/1501.05142), Section 4, Proposition 4.2.
- In the phylogenetic setting, generation of the ideal in degree <= d is equivalent to connecting any two compatible tables by moves exchanging at most d rows. — [Michałek–Ventura arXiv:1606.07263](https://arxiv.org/abs/1606.07263), Section 2; used by the repo paper, Section 1.

### Inferences
- Lemma 2 of the repo paper is exactly the "if" direction of Corollary 2.10 above, specialised to tables: fibre = {A, B} with gcd(X^A, X^B) = 1 means G(b) is two isolated vertices. More generally, any fibre containing a table A that shares no row with any other table of the fibre (an isolated vertex of G(b), fibre size >= 2) forces a minimal generator of degree = number of rows; the fibre need not have exactly two elements.
- What a two-element fibre requires of the design matrix. Let S_j be the column supports of A, E the set of all flows in S_1 x ... x S_n, and M_E the (column j, value) by E incidence matrix. The fibre is {x in N^E : M_E x = M_E alpha}. It equals {alpha, beta} with disjoint supports exactly when the only lattice points of the polytope {x >= 0, M_E x = M_E alpha} are alpha and beta. A sufficient condition, and the one realised for Z/17, is: ker M_E has rank 1 with primitive integer generator u; then automatically the fibre of u^+ is {u^+, u^−} (t must be an integer in [0,1]). In that case u is a circuit of the full configuration (any kernel vector supported inside supp(u) is supported in E, hence a multiple of u). A two-element fibre does not in general force rank-one kernel: **[OWN COMPUTATION]** for Z/7 on three leaves there are degree-5 generators with two-element fibres (882 of them in a 4ti2 Markov basis), although an exhaustive search shows rank-one-kernel faces of Z/7 only reach degree 4.
- Standard textbook hierarchy (Sturmfels, *Gröbner Bases and Convex Polytopes*, ch. 4; I did not re-read the book in this session, so treat the exact citation as unverified): circuits ⊂ universal Gröbner basis ⊂ Graver basis, and every indispensable binomial lies in every reduced Gröbner basis, hence in the universal Gröbner basis and the Graver basis. So the Z/17 binomial is simultaneously a circuit, an indispensable binomial, and a Graver element; phi is bounded below by the largest degree of an indispensable binomial and above by the Graver degree.
- For a rank-one-kernel face with r = rank, Cramer's rule gives u_k = ± (maximal minor with column k deleted) / gcd. The degree of the circuit is therefore (sum of positive minors) / gcd. This is the quantity that has to exceed |G|.

### Gaps
- I did not locate a published statement of the face-restriction lemma specifically for group-based models; the repo proves it directly (Proposition 4).
- The exact numbering of the circuit/Graver results in Sturmfels' book was not checked against the source.

## 3. Why 17? Arithmetic of the mechanism, and whether it occurs for smaller groups

### Takeaway
There is no special arithmetic role for 17. The determinant 17 is forced: every maximal minor of the face matrix is divisible by |G| because the vertices of the tripod polytope span a lattice of index |G|; the degree 18 is simply (sum of positive minors)/17. **[OWN COMPUTATION]** The same construction gives degree > |G| already for Z/12 (degree 13) and Z/13 (degree 17), so the Sturmfels–Sullivant bound fails for groups smaller than Z/17.

### Cited Findings
- The lattice spanned by the vertices of the tripod polytope is L_{G,3} = {x in Z^{3|G|} : the three block sums are equal and the G-weighted sum of all coordinates is 0 in G}. — [Dinu–Vodička arXiv:2309.05301](https://arxiv.org/abs/2309.05301), Section 2.3 (after Theorem 2.1); also [Dinu–Vodička arXiv:2003.04751](https://arxiv.org/abs/2003.04751), Section 1 (after Theorem 1.1).
- The repo presents "determinant 17" only as a rank certificate and says the proof does not depend on it. — Repo paper, Section 5.
- For non-abelian groups Sturmfels and Sullivant already observed that the complexity can exceed the group order: "Using the software 4ti2, we found that φ(S3, 2) ≥ 8". — [arXiv:q-bio/0402015](https://arxiv.org/abs/q-bio/0402015), Section 5, after Conjecture 27.
- phi(G) is finite for every finite abelian G (so for a fixed group, degrees of indispensable binomials are bounded as the number of leaves grows). — [Michałek–Ventura arXiv:1606.07263](https://arxiv.org/abs/1606.07263), Theorem 3.12.

### Inferences
**Proved (elementary, by me, and checked numerically on the example).**
- Divisibility by |G|. After deleting one row from blocks 2 and 3 (they are determined by equal block sums), the columns of M_E live in a rank-(s1+s2+s3−2) lattice, and they satisfy the extra congruence "weighted sum = 0 in G". For G = Z/p and supports with at least two elements the congruence cuts out a sublattice of index p, so every maximal minor is divisible by p. In the Z/17 example all 22 column-deleted minors are 17·u_k and the Smith form is diag(1^20, 17, 0) (my computation, Section 1). So "the minor equals 17" says only that the 22 vertices generate the full restricted lattice (index 1 in L_{G,3} ∩ span), which is the generic situation. The same remark explains the line "34d − 17e = 0" in the hand elimination.
- Degree is not tied to |G|+1. Degree = sum of positive u_k; nothing forces 18 = 17 + 1. Other degrees occur for other faces (see the table below).

**[OWN COMPUTATION] New examples for smaller and other groups (each independently verified by brute-force fibre enumeration with `indep.py`: zero row sums, equal margins, no common row, the list of all flows inside the supports, fibre of size exactly 2, exact rational rank).**
- **Z/12, degree 13** (supports of sizes 5, 7, 7; 18 flows inside; rank 17, nullity 1):
  - A = (0,11,1), (4,2,6)x2, (4,4,4)x2, (6,5,1), (6,11,7), (7,6,11)x2, (7,9,8)x2, (10,3,11), (10,9,5)
  - B = (0,5,7), (4,3,5), (4,9,11)x3, (6,2,4)x2, (7,4,1)x2, (7,11,6)x2, (10,6,8)x2
  - Conclusion: phi(Z/12,3) >= 13 > 12.
- **Z/13, degree 17** (supports of sizes 6, 6, 8; 19 flows inside; rank 18, nullity 1):
  - A = (1,7,5), (1,12,0), (2,3,8)x2, (2,5,6), (4,9,0)x2, (5,7,1)x2, (6,9,11), (6,10,10)x4, (7,5,1), (7,12,7)x2
  - B = (1,5,7)x2, (2,10,1)x3, (4,3,6), (4,12,10), (5,3,5), (5,10,11), (6,7,0)x3, (6,12,8)x2, (7,9,10)x3
  - Conclusion: phi(Z/13,3) >= 17 > 13.
- **Z/17, degree 18, a second example different from Pochuev's** (supports 8, 7, 8; 22 flows; nullity 1): A = (1,0,16), (5,12,0), (9,0,8), (10,1,6)x4, (11,5,1)x3, (11,7,16), (13,7,14)x2, (14,10,10)x2, (15,14,5)x3; B = (1,10,6), (5,7,5), (9,7,1), (10,7,0), (10,10,14), (10,14,10)x2, (11,0,6)x2, (11,1,5)x2, (13,5,16)x2, (14,12,8), (14,14,6), (15,1,1)x2, (15,5,14).
- **Z/19, degree 20** (supports 8, 9, 8; 24 flows; nullity 1): A = (0,10,9), (1,13,5)x2, (1,18,0), (4,6,9), (4,15,0)x2, (5,11,3), (13,7,18), (13,11,14), (13,15,10)x2, (15,6,17)x3, (16,17,5)x2, (17,2,0), (17,18,3)x2; B = (0,2,17), (1,15,3)x3, (4,10,5), (4,17,17)x2, (5,15,18), (13,6,0)x4, (15,18,5)x3, (16,13,9)x2, (17,7,14), (17,11,10)x2.
- These were found by an 8-minute single-core random hill-climb over support triples per group (`rnd.py`), so such faces are not rare once |G| is around 12 or more.

**[OWN COMPUTATION] Largest degree of a rank-one-kernel face ("nullity-1 degree"), three leaves.** "Exhaustive" = all support triples up to translation and swapping the first two columns; "search" = best found by the random hill-climb (a lower bound only).

| G | nullity-1 degree | method | compare |G| |
|---|---|---|---|
| Z2, Z3 | none exists | exhaustive | – |
| Z4 | 4 | exhaustive | = |
| Z2 x Z2 | 4 | exhaustive | = |
| Z5 | 3 | exhaustive | < |
| Z6 | 6 | exhaustive | = |
| Z7 | 4 | exhaustive | < |
| Z8 | 8 | exhaustive | = |
| Z2 x Z4 | 8 | exhaustive | = |
| Z2^3 | 6 | exhaustive | < |
| Z9 | 8 (10.1 million support triples evaluated; degrees 3–8 occur) | exhaustive | < |
| Z3 x Z3 | >= 8 (two runs, 4 million iterations) | search | |
| Z10 | >= 10 (index-2 family below; search alone found 8, twice) | construction | = |
| Z11 | >= 10 (three runs, 9 million iterations, degree 10 reached in each) | search | |
| Z12 | >= 13 | search, verified | **>** |
| Z13 | >= 17 | search, verified | **>** |
| Z14 | >= 14 (index-2 family; search alone found 12) | construction | = |
| Z15 | >= 14 | search | |
| Z16 | >= 16 (index-2 family; search alone found 15) | construction | = |
| Z17 | >= 18 | Pochuev; rediscovered by search | **>** |
| Z19 | >= 20 | search, verified | **>** |

- The "index-2 family" (observed in the exhaustive outputs for Z4, Z6, Z8, Z2 x Z4, and elementary to check): take S1 = {0, g} with g of order |G|/2 and S2 = S3 = G. The 2|G| flows form two cycles; the kernel is one-dimensional and the circuit is squarefree of degree exactly |G| (for Z4: (0,0,0),(0,2,2),(2,1,1),(2,3,3) versus (0,1,3),(0,3,1),(2,0,2),(2,2,0)). So for every G with an element of order |G|/2 there is an indispensable binomial of degree exactly |G| on three leaves: the conjectured bound, where it holds, is attained by this mechanism.

**Speculative (clearly not proved).**
- Why large groups: a rank-one-kernel face needs |E| = s1+s2+s3−1 flows inside supports of sizes s_j, while a random support triple contains about s1·s2·s3/|G| flows, so the s_j are of order sqrt(3|G|); the circuit entries are maximal minors of a 0/1 matrix of that size divided by |G|. Minors of 0/1 matrices grow quickly with size, so I expect the maximal circuit degree to outgrow |G| for all sufficiently large G (cyclic or not), and phi(G,3)/|G| to be unbounded. The data above (13 at order 12, 17 at order 13, 20 at order 19 from short searches) are consistent with this but prove nothing asymptotic.
- Non-cyclic groups: the construction never uses cyclicity (only the flow condition), and Z2 x Z4 already attains |G| by the index-2 family. I did not find a non-cyclic example exceeding |G| because I only ran orders 8 and 9 for non-cyclic groups; I expect them to exist at larger orders. Elementary 2-groups look less favourable (Z2^3 reaches only 6 by this mechanism although phi(Z2^3,3) = 8).

### Gaps
- The smallest group order with phi(G,3) > |G| is not determined: it is at most 12 and at least 9 (Section 4). Orders 9, 10, 11 are undecided by my computations: for Z9 the rank-one-kernel mechanism is exhaustively capped at degree 8, but other fibre types are not excluded; for Z3xZ3, Z10, Z11 the random search is only a lower bound (best 8, 10, 10).
- No proof that degree > |G| occurs for all large G; no upper bound on phi(G,3) in terms of |G| better than general Graver/determinant bounds was located.
- My new examples have not been checked by anyone else. They are easy to check (18–24 flows, a 2-element fibre) with `indep.py` or by hand.

## 4. Known exact three-leaf values and whether they are attained by two-element fibres

### Takeaway
For |G| <= 8 the exact values are phi(G,3) = 0, 3, 4, 4, 4, 6, 6, 8, 8, 8 for Z2, Z3, Z4, Z2xZ2, Z5, Z6, Z7, Z8, Z4xZ2, Z2^3, never above |G|. They are attained by two-element fibres for Z4, Z2xZ2, Z6 (and by rank-one-kernel faces for Z8, Z2xZ4), but for the odd groups Z3, Z5, Z7 the top-degree generators come from three-element fibres. The first group with phi(G,3) > |G| therefore has order 9, 10, 11 or 12.

### Cited Findings
- Sturmfels–Sullivant table (computed with 4ti2). Their index n counts the free indices g_1..g_n of q_{g1...gn} with tableaux of n+1 columns, so their "n = 2" is the three-leaf claw tree. Numbers of minimal generators by degree and phi: Z2 (n=2): none, phi 0; Z2 (n=3..6): quadrics only, phi 2; Z3 (n=2): 2 cubics, phi 3; Z3 (n=3): 54 quadrics, 24 cubics, phi 3; Z4 (n=2): 16 cubics, 6 quartics, phi 4; Z4 (n=3): 344, 256, 96 in degrees 2, 3, 4, phi 4; Z2xZ2 (n=2): 16 cubics, 18 quartics, phi 4; Z2xZ2 (n=3): 360, 261, 480, phi 4; Z5 (n=2): 50 cubics, 50 quartics, phi 4; Z6 (n=2): 116, 675, 216, 126 in degrees 3–6, phi 6; Z7 (n=2): 245, 1764, 1764, 294 in degrees 3–6, phi 6. — [arXiv:q-bio/0402015](https://arxiv.org/abs/q-bio/0402015), Section 5, table before Theorem 26 (local text lines 861–875).
- Additional values: "φ(6, Z3) = 3, φ(4, Z5) = 4, φ(3, Z8) = 8, φ(3, Z2 × Z2 × Z2) = 8, φ(3, Z4 × Z2) = 8" (first argument = number of leaves of K_{n,1}). — [Donten-Bury–Michałek arXiv:1011.3236](https://arxiv.org/abs/1011.3236), Computation 3.3.
- phi(Z2) = 2. — [arXiv:q-bio/0402015](https://arxiv.org/abs/q-bio/0402015), Theorem 26; [arXiv:1011.3236](https://arxiv.org/abs/1011.3236), Proposition 3.2.
- The three-leaf special case of the bound was stated separately: "Conjecture 4.2. For any finite abelian group G, φ(G, 3) ≤ |G|", together with Conjecture 4.3, φ(G, n+1) = max(2, φ(G, n)). — [Michałek–Ventura arXiv:1606.07263](https://arxiv.org/abs/1606.07263), Section 4.

### Inferences
**[OWN COMPUTATION] Reproduction and fibre analysis with 4ti2-markov** (`mk.py`; one minimal Markov basis per model; "fibre size" = number of tables with the same column multisets as the positive part of the generator, by exhaustive enumeration):

| model | generators by degree (matches the Sturmfels–Sullivant table) | fibre sizes of generators |
|---|---|---|
| Z3, 3 leaves | 3: 2 | degree 3: fibre size 3 |
| Z4, 3 leaves | 3: 16, 4: 6 | all fibres of size 2 |
| Z2xZ2, 3 leaves | 3: 16, 4: 18 | all fibres of size 2 |
| Z5, 3 leaves | 3: 50, 4: 50 | degree 3: size 2; degree 4: size 3 |
| Z6, 3 leaves | 3: 116, 4: 675, 5: 216, 6: 126 | degree 3: 108 of size 2 and 8 of size 3; degrees 4, 5, 6: all size 2 |
| Z7, 3 leaves | 3: 245, 4: 1764, 5: 1764, 6: 294 | degrees 3, 4: size 2; degree 5: 882 of size 2 and 882 of size 3; degree 6: all size 3 |
| Z4, 4 leaves | 2: 344, 3: 256, 4: 96 | degree 2: sizes 2, 3, 4; degrees 3, 4: all size 2 |

- So phi(G,3) is attained by indispensable binomials (two-element fibres) for Z4, Z2xZ2 and Z6, and also for Z4 on four leaves. For Z3, Z5, Z7 the maximal-degree generators live in three-element fibres with pairwise disjoint tables (a Betti degree whose graph G(b) has three singleton components), so they are forced in degree but no individual binomial is indispensable. For Z7 the largest degree of an indispensable binomial is 5 = phi − 1.
- For order 8 I did not recompute the Markov bases; the exhaustive rank-one-kernel search gives degree 8 = phi for Z8 and Z2xZ4 (index-2 family) and only 6 for Z2^3, so for Z2^3 the degree-8 generators are of another type.
- Pattern: for even order the bound |G| is met with equality by a squarefree circuit coming from an index-2 structure; for odd order <= 7 the rank-one-kernel mechanism is strictly weaker than phi (3 vs 4 for Z5, 4 vs 6 for Z7) and phi < |G| for Z5 and Z7. The mechanism overtakes |G| somewhere between order 9 and order 12–13.
- What this suggests about the first violating group: since every abelian group of order <= 8 has phi(G,3) <= |G| (cited exact values) and Z/12 violates the three-leaf bound (my verified example), **the smallest order of a counterexample to Conjecture 4.2 is 9, 10, 11 or 12**. Z/12 is even, so the failure is not confined to odd or prime orders; Z/13 is the smallest prime order for which I have a violation.

### Gaps
- phi(G,3) is not known exactly for any group of order >= 9 as far as I could find; Donten-Bury–Michałek report that for Z9 they could compute only Hilbert functions, not normality ([arXiv:1011.3236](https://arxiv.org/abs/1011.3236), Section 4.2). A full 4ti2 Markov basis for Z9 (81 variables) was not attempted here (Z7 took 7 minutes; Z8/Z9 would be much longer).
- Orders 9, 10, 11: my searches found only degrees <= |G| (Z9: exactly 8 by exhaustive enumeration of rank-one-kernel faces, so this mechanism provably cannot break the bound for Z9; Z3xZ3: 8 by search; Z10: 10 by the index-2 family; Z11: 10 by search, repeatedly). Because two-element fibres need not have rank-one kernel and top-degree generators can come from three-element fibres, these searches cannot certify phi <= |G| for these groups.

## 5. Normality: the Dinu–Vodička classification and its relation to degrees of generation

### Takeaway
Dinu–Vodička: the tripod polytope P_{G,3} (and the polytope of any trivalent tree) is normal if and only if G is one of Z2, Z3, Z2xZ2, Z4, Z5, Z7. Normality is logically independent of the bound phi(G,3) <= |G| (non-normal Z6, Z8 satisfy the bound), but every group now known to violate the bound (Z12, Z13, Z17, Z19) is non-normal, and for a rank-one-kernel face normality forces one side of the circuit to be squarefree, which all violating examples fail.

### Cited Findings
- Theorem 5.1: "Let G be an abelian group. Then the polytope P_{G,3} associated to a tripod and the group G is normal if and only if G ∈ {Z2, Z3, Z2 × Z2, Z4, Z5, Z7}." Corollary 5.2 extends this to any trivalent tree; Corollary 5.3 restates it as projective normality of X_{G,3} and X_{G,T}, T trivalent. — [Dinu–Vodička arXiv:2309.05301](https://arxiv.org/abs/2309.05301) (J. Comb. Algebra 2024, doi 10.4171/jca/102), Section 5. A trivalent tree there means every vertex has degree <= 3.
- Ingredients of the proof: even order >= 6 is non-normal ([Dinu–Vodička arXiv:2003.04751](https://arxiv.org/abs/2003.04751), Proposition 1.3, with an explicit non-decomposable point in 4P built from g of order 2 and h with 2h not in {0, g}); odd order > 43 non-normal by a counting argument on a 12-vertex cubic graph (Theorem 3.4); odd orders 13–43 by explicit "good functions" (Theorem 3.5; Z17 is treated explicitly with h = (3,2,2,6,0,3)); Z11 by a larger graph (Theorem 3.6, with explicit point in Remark 3.7); Z5, Z7 normal and Z9, Z3xZ3 non-normal by Macaulay2 + Polymake (Computations 4.1, 4.2); Z4 normal "by computations shown in [Michałek, Geometry of phylogenetic group-based models, J. Algebra 2011]"; Z2xZ2 by Vodička; Z3 by [arXiv:2003.04751, Theorem 2.3]; Z2 by Buczyńska–Wiśniewski. — [arXiv:2309.05301](https://arxiv.org/abs/2309.05301), Sections 3–5.
- Normality is tested in the lattice spanned by the vertices, not in Z^{3(|G|−1)}. — [arXiv:2309.05301](https://arxiv.org/abs/2309.05301), Section 4; [arXiv:1011.3236](https://arxiv.org/abs/1011.3236), Section 4.1.
- Reductions: by Sullivant's toric fibre product, normality for a group and all trivalent trees reduces to the tripod, and for all trees to claw trees; non-normality for the tripod gives non-normality for every tree that is not a path, because the polytope of any tree has a face isomorphic to the tripod polytope. — [arXiv:2309.05301](https://arxiv.org/abs/2309.05301), Introduction and Theorem 2.2; [arXiv:2003.04751](https://arxiv.org/abs/2003.04751), Remark 1.4.
- First non-normal examples: "The polytope associated with the tripod and one of the groups G = Z6, Z8, Z2 × Z2 × Z2, Z4 × Z2 is not normal" (Normaliz); if H is a subgroup of G and the model of H on T is non-normal then so is that of G (Proposition 4.2); for Z6 the tripod polytope is not even very ample (Computation 4.3). For Z2, Z3, Z4, Z2xZ2 and trivalent trees normality was known from earlier computations. — [Donten-Bury–Michałek arXiv:1011.3236](https://arxiv.org/abs/1011.3236), Section 4.1.
- Kimura 3-parameter model: "all algebraic varieties associated to this model are projectively normal" (any tree), confirming a conjecture of Michałek. — [Vodička arXiv:1902.11057](https://arxiv.org/abs/1902.11057) (SIAM J. Discrete Math. 35 (2021)), abstract and Introduction.
- Link between normality and degrees: "Normality of toric varieties provides automatic bounds on degrees of phylogenetic invariants [Stu96]. In a special case of a tree with six leaves this was used in a recent proof [MV17b] of the Sturmfels–Sullivant conjecture [SS05, Conjecture 30]." — [Vodička arXiv:1902.11057](https://arxiv.org/abs/1902.11057), Introduction.
- Claw trees with n >= 4 leaves: Z2, Z2xZ2 and Z3 are known to be normal for every tree; "it remains to understand only the normality when the groups are Z4, Z5 and Z7 for any tree. We also used the computer to check the normality for 4-claw tree and the above groups, and it turns out that the polytopes are normal." Conjecture 5.5: X_{G,T} is projectively normal for every tree T if and only if G ∈ {Z2, Z3, Z2 × Z2, Z4, Z5, Z7}. — [arXiv:2309.05301](https://arxiv.org/abs/2309.05301), Remark 5.4 and Conjecture 5.5. Earlier form: Conjecture 3.13 of [arXiv:1011.3236](https://arxiv.org/abs/1011.3236) (normal for the tripod implies normal for every tree).

### Inferences
- Normality does not imply phi <= |G| and is not implied by it. Non-normal but within the bound: Z6 (phi(Z6,3) = 6), Z8, Z4xZ2, Z2^3 (phi = 8). The degree bound that normality gives through Sturmfels' theorem is of the order of the dimension of the variety (about 3|G| for the tripod), not |G|; I did not re-read [Stu96] to quote the exact constant.
- All violating groups are non-normal by the classification: Z12 (even order >= 6), Z13, Z17, Z19 (odd order >= 11, Theorem 3.5).
- A direct link for the rank-one-kernel mechanism (my argument, elementary): faces of normal polytopes are normal, and the coordinate ring of a (d+2)-vertex face is the hypersurface k[x_E]/(x^{u+} − x^{u−}). Such a hypersurface is normal if and only if u+ or u− is squarefree (if both have an exponent >= 2, say on x_i and x_j, the hypersurface is singular along the codimension-one locus x_i = x_j = 0; if one side is squarefree the singular locus has codimension >= 2 and a hypersurface is Cohen–Macaulay). Hence: **if P_{G,n} is normal, every rank-one-kernel face has a circuit with a squarefree side.** In the examples: Pochuev's Z17 tables have multiplicities up to 4 on the A side and 3 on the B side; my Z12 (2 and 3), Z13 (4 and 3), Z19 (3 and 4) examples are also non-squarefree on both sides, so each of these faces is itself a certificate of non-normality of the tripod polytope; the degree-|G| circuits of the index-2 family and all rank-one-kernel circuits found for Z4, Z5, Z7 are squarefree on both sides.
- So for the normal groups the only rank-one-kernel circuits available are "half-squarefree" ones, whose degree equals the number of distinct flows on the squarefree side. This is a real restriction (it removes the multiplicities that produce degree 18 from 11 row types in the Z17 example) but it is not by itself a proof of degree <= |G|.
- The non-normality witnesses of Dinu–Vodička (lattice points of 2k·P not in k·(P ∩ L), built from cubic graphs) are a different kind of object from the counterexample (a face whose only relation has high degree); I found no theorem converting one into the other.

### Gaps
- No published result deciding normality of the Z4, Z5, Z7 models on claw trees with 5 or more leaves was found (the 4-claw is a computer check reported without details in [arXiv:2309.05301](https://arxiv.org/abs/2309.05301)); Conjecture 5.5 appears to be open. OpenAlex lists only two citing works for the classification paper, neither on this question.
- I did not read Michałek's "Geometry of phylogenetic group-based models" (J. Algebra 2011) for the Z4 tripod normality computation, nor Sturmfels' book for the exact normality degree bound.
- I did not verify the Dinu–Vodička Z17 non-normality witness numerically.

## 6. Implications for Z/4: is phi(Z/4) <= 4 more or less plausible?

### Takeaway
Nothing in the counterexample bears directly against phi(Z/4) = 4. The general conjecture is now false (already at order 12–13 by my computations), so phi(Z/4) <= 4 can no longer be supported by appeal to the general bound, but the specific mechanism needs supports and multiplicities that Z/4 cannot supply on three leaves, and the available exact data (three and four leaves) and searches (up to six leaves) all give exactly 4.

### Cited Findings
- phi(Z4,3) = 4 (16 cubics, 6 quartics) and phi(Z4,4) = 4 (344 quadrics, 256 cubics, 96 quartics). — [arXiv:q-bio/0402015](https://arxiv.org/abs/q-bio/0402015), Section 5 table (rows "Z4, n = 2" and "Z4, n = 3").
- Z4 is one of the six groups with normal tripod/trivalent-tree polytopes, the 4-claw polytope for Z4 was found normal by computer, and normality for all trees is conjectured. — [arXiv:2309.05301](https://arxiv.org/abs/2309.05301), Theorem 5.1, Remark 5.4, Conjecture 5.5.
- phi(G) is finite for every finite abelian G, and phi(G, n) is conjectured to be constant from n = 3 on (Conjecture 4.3: φ(G, n+1) = max(2, φ(G, n))). — [arXiv:1606.07263](https://arxiv.org/abs/1606.07263), Theorem 3.12 and Conjecture 4.3.
- The Z17 counterexample is a three-leaf example extended to n >= 3 leaves by zero columns; it does not contradict constancy of phi(G, ·), only the bound by |G|. — Repo paper, Theorem 1.
- The companion conjecture for the other group of order 4 is a theorem: phi(Z2 x Z2) = 4. — `/home/user/papers/michalek-conj.html`, entry "Conjecture 5" (Michałek–Ventura, Adv. Math. 343 (2019), [arXiv:1704.02584](https://arxiv.org/abs/1704.02584)).

### Inferences
- **[OWN COMPUTATION]** Z4, three leaves, exhaustive over all support triples: rank-one-kernel faces have circuit degree 3 or 4 only; the degree-4 ones are the index-2 family with S1 = {0,2}. Z4, four leaves: 4ti2 reproduces 344/256/96 and all 96 quartic generators (and all 256 cubics) have two-element fibres, i.e. are indispensable; so phi(Z4,4) = 4 is attained by exactly the kind of obstruction used for Z17, and none of higher degree exists there. Z4 with 4, 5, 6 leaves and Z2xZ2 with 5 leaves, random hill-climb over supports (2.5–5.6 million evaluations each): maximal rank-one-kernel circuit degree found is 4 in every case. The search is heuristic for 5 and 6 leaves and covers only the rank-one-kernel sub-mechanism.
- Why the mechanism is starved for Z4 on three leaves: supports have at most 4 elements, so a face has at most 16 flows and the matrices are at most 12x16; exhaustive enumeration shows nothing beyond the index-2 circuit. With more leaves the matrices grow (4n rows), so in principle large minors could appear; finiteness of phi(Z4) (Michałek–Ventura) says the degrees of indispensable binomials stay bounded, and my searches up to six leaves see nothing above 4.
- Normality cuts the mechanism down further for Z4 wherever the claw polytope is normal (proved for the tripod, computer-checked for the 4-claw, conjectured in general): by the inference in Section 5 any rank-one-kernel circuit must then have a squarefree side, so the high-multiplicity circuits behind all known violations cannot occur.
- Net assessment (judgement, not a theorem): the counterexample lowers the prior for "phi(G) <= |G| for all G" to zero but leaves the Z4 case essentially where it was. Evidence for phi(Z4) = 4: exact values at 3 and 4 leaves, the proved Z2xZ2 analogue, normality at 3 and 4 leaves, no high-degree circuit up to 6 leaves. Evidence against: none specific to Z4. The lesson that does transfer is methodological: small-case computations (all groups of order <= 8 obey the bound) were not a reliable guide for larger groups, so the analogous extrapolation in the number of leaves (constancy of phi(Z4, n) beyond n = 4) should not be taken for granted without proof.

### Gaps
- phi(Z4, n) for n >= 5 is not established by anything I read or computed; a 4ti2 run for Z4 on five leaves (256 variables) was not attempted.
- My Z4 searches test only rank-one-kernel faces; generators coming from larger fibres (as for Z3, Z5, Z7 on three leaves) or from two-element fibres with higher-rank kernel are not covered for n >= 5.
- Normality of the Z4 claw polytopes for n >= 5 is open (Section 5), so the squarefree-side restriction is unconditional only for n = 3 (and computer-checked for n = 4).
