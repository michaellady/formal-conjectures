# Open problems in mathematical chemistry/biology: survey, computations, verified Lean

Date: 2026-11-22. Lean 4.33.1, Mathlib tag v4.33.1 (`0df444a3`).
Literature status below comes from web-search summaries (full-text fetches were blocked), so
treat every "open/proven" claim as needing a primary-source check. 2026 preprints are unrefereed.

## 1. What was verified in Lean (zero `sorry`, axioms = propext, Classical.choice, Quot.sound)

| File | Result | Status of the mathematics |
|---|---|---|
| `HornJackson.lean` | `CRN.dissipation`: for any finite mass-action network with a positive complex-balanced point `c`, `∑ₛ f(x)ₛ · log(xₛ/cₛ) ≤ 0` for all positive `x`. Also `ComplexBalanced.rhs_eq_zero` (complex balanced ⇒ equilibrium), `freeEnergy_nonneg`, and the `A ⇌ B` instance. | Classical (Horn–Jackson 1972). Not new. It is the Lyapunov inequality every Global Attractor Conjecture argument starts from. |
| `ThomsonSimplex.lean` | `Thomson.energy2_ge`: N ≥ 2 distinct unit vectors in any real inner product space have `∑_{i≠j} 1/‖xᵢ−xⱼ‖ ≥ N(N−1)/√(2N/(N−1))`; `energy2_eq_of_centred_equidistant`: centred equidistant configurations attain it; `two_points`, `antipodal`. | Classical. Certifies the Thomson optimum for N = 2, 3, 4 given the simplex configurations (only the N = 2 configuration is constructed in Lean). |
| `PhyloInvariants.lean` | 24 theorems: every element of the 4ti2 minimal Markov basis for ℤ/3 (2 cubics) and ℤ/4 (16 cubics, 6 quartics) on the claw K₁,₃ is a polynomial identity in the edge parameters over any commutative ring. | Soundness only. Completeness of the basis is 4ti2's output, not Lean-checked. |

`#print axioms` output:

```
'CRN.dissipation' depends on axioms: [propext, Classical.choice, Quot.sound]
'CRN.Network.ComplexBalanced.rhs_eq_zero' depends on axioms: [propext, Classical.choice, Quot.sound]
'CRN.freeEnergy_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound]
'CRN.iso_dissipation' depends on axioms: [propext, Classical.choice, Quot.sound]
'Thomson.energy2_ge' depends on axioms: [propext, Classical.choice, Quot.sound]
'Thomson.energy2_eq_of_centred_equidistant' depends on axioms: [propext, Classical.choice, Quot.sound]
'Thomson.two_points' depends on axioms: [propext, Classical.choice, Quot.sound]
'Thomson.antipodal' depends on axioms: [propext, Classical.choice, Quot.sound]
'Phylo.inv3_0' depends on axioms: [propext]
'Phylo.inv4_21' depends on axioms: [propext]
```

To re-check: from a Lake project that depends on Mathlib v4.33.1, run `lake env lean <file>`.

None of these resolves an open problem. They are the verified base layer and the sanity checks.

## 2. Computation: Sturmfels–Sullivant degree bound on small claw trees

Conjecture: the ideal of the group-based model for a finite abelian group G on any tree is
generated in degree ≤ |G|. It reduces to claw trees K₁,ₙ. Script: `phylo/ss.py` (builds the
toric design matrix on tuples of Gⁿ summing to zero; 4ti2 `markov` gives a minimal Markov basis).

| G | n (leaves) | variables | generators by degree | max degree | ≤ \|G\| |
|---|---|---|---|---|---|
| ℤ2 | 3 | 4 | none | 0 | yes |
| ℤ3 | 3 | 9 | 3:2 | 3 | yes |
| ℤ4 | 3 | 16 | 3:16, 4:6 | 4 | yes |
| ℤ2×ℤ2 | 3 | 16 | 3:16, 4:18 | 4 | yes |
| ℤ5 | 3 | 25 | 3:50, 4:50 | 4 | yes |
| ℤ6 | 3 | 36 | 3:116, 4:675, 5:216, 6:126 | 6 | yes |
| ℤ7 | 3 | 49 | 3:245, 4:1764, 5:1764, 6:294 | 6 | yes |
| ℤ2 | 4 | 8 | 2:3 | 2 | yes |
| ℤ3 | 4 | 27 | 2:54, 3:24 | 3 | yes |
| ℤ2×ℤ2 | 4 | 64 | 2:360, 3:256, 4:480 | 4 | yes |
| ℤ4 | 4 | 64 | 2:344, 3:256, 4:96 | 4 | yes |
| ℤ2 | 5 | 16 | 2:30 | 2 | yes |
| ℤ3 | 5 | 81 | 2:1134, 3:180 | 3 | yes |

- The ℤ2×ℤ2, n = 3 row (16 cubics, 18 quartics) matches the published Kimura 3-parameter count,
  which validates the encoding.
- No counterexample. ℤ5 and ℤ7 on K₁,₃ need only degree 4 and 6, below |G|.
- ℤ4 on K₁,₄ needs degree exactly 4. ℤ4 is the smallest group for which the conjecture is open
  (per the literature check), so the next data points are ℤ4 on K₁,₅ (256 variables) and ℤ5 on
  K₁,₄ (125 variables); see the end of this file for whether those runs finished.

## 3. Enumerated candidates, ranked by leverage × tractability

"Tractable" means a session-scale or few-week formalization/computation, not a resolution of the
headline conjecture.

### Track 1: reaction networks (drug-target kinetics, metabolic and signalling models)

1. **Deficiency-zero theorem in Mathlib form.** Weakly reversible + deficiency 0 ⇒ complex
   balanced for all rate constants. Combined with `dissipation`, gives "no oscillation, no
   multistability" certificates for a network from its graph alone. Missing prerequisites:
   Laplacian kernel of a weakly reversible digraph (matrix-tree), Birch's theorem. A third-party
   repo (`akutuva21/crnt-lean`) reportedly attempts this; its sorry-free status is unconfirmed.
2. **Chain rule + LaSalle for `freeEnergy`.** Turn `dissipation` into "ω-limit sets lie in
   equilibria ∪ boundary". Needs Mathlib ODE flows on the positive orthant; moderate.
3. **Persistence for a fixed small network family** via critical-siphon enumeration (SAT) plus a
   verified "no critical siphon ⇒ persistent" lemma (Angeli–De Leenheer–Sontag). The
   combinatorial half is finite and Lean-`decide`-able per network.
4. **Smallest open GAC case**: stoichiometric dimension 4, ≥ 2 linkage classes, boundary
   equilibria on faces of codimension ≥ 2. Research-level; Craciun's 2015 general proof is still
   an unrefereed preprint, and a Sept 2026 preprint (Wiuf) claims multi-linkage cases under siphon
   conditions.

### Track 2: algebraic phylogenetics (model selection, identifiability of evolutionary trees)

5. **ℤ4 on K₁,ₙ for all n** (smallest open group). Evidence above for n = 3, 4. A proof would
   follow Michałek's ℤ3 strategy; a certified computation for n = 5, 6 is the concrete next step.
6. **Lean-certified Markov bases.** Soundness is done here for ℤ3, ℤ4. Completeness needs a
   verified fibre-connectivity checker (finite, `decide`/reflection); that would make rows of the
   table above theorems.
7. **φ(G, 3) ≤ |G| on K₁,₃ for all G**, listed as open in a 2017 survey. Data: the max degree is
   strictly below |G| for ℤ5, ℤ7, equal for ℤ4, ℤ6. A conjecture on the exact value (e.g. in terms
   of the largest proper-subgroup structure) looks reachable from more data (ℤ8, ℤ9, ℤ2³).

### Track 3: ranked/time trees (Bayesian phylogenetics, MCMC proposal design)

8. **Cluster (split) property in the RNNI graph**: shared clusters preserved along shortest
   paths. I could not confirm a published proof; FindPath (Collienne–Gavryushkin 2021) makes it
   exhaustively checkable for n ≤ 7–8 and a natural Lean target.
9. **Rank-move weight 0 < ρ < 1**: distance complexity open; small-n exhaustive data is cheap.

### Track 4: energy minimisation (cluster chemistry, virus capsids, colloids)

10. **Thomson N = 7, 8**: now claimed in Lean by three 2026 efforts (unrefereed; one states its
    theorem statement is not human-certified). Highest-value work here is an independent audit of
    those statements, not a new proof.
11. **Thomson N = 9, 10, 11**: no proofs found. Interval branch-and-bound in the style of
    Schwartz's N = 5 is the route; heavy.
12. **Lennard-Jones N = 6, 7 exact certificates**: existing branch-and-bound results are
    "optimal within tolerance", weaker than a proof. An interval certificate with a Lean-checked
    final inequality is a well-scoped project.
13. **Simplex-bound generalisations** (done here for Coulomb): the same tangent-line argument
    covers any potential convex and decreasing in squared distance (Riesz s-energies, log energy),
    a one-file extension.

## 4. Recommended wedge

Items 5–6: ℤ4 Sturmfels–Sullivant with Lean-certified Markov bases. It is the smallest genuinely
open group, the computations are cheap, the encoding is validated against a published count, and
the formal gap (a fibre-connectivity checker) is small and reusable for every other group.
Second choice: item 1 + 2, which upgrades `HornJackson.lean` into a usable stability certificate.

## 5. Not done

- No open conjecture was proved.
- Track 3 received no computation or Lean work.
- The linked starting document could not be read from this session (access denied), so nothing
  here builds on it.
- The tetrahedron and equilateral-triangle configurations are not constructed in Lean; the
  equality lemma is stated for any centred equidistant configuration.

## 6. Frontier runs that did not finish

ℤ5 on K₁,₄ (125 variables) and ℤ4 on K₁,₅ (256 variables) each hit a 25-minute cap in 4ti2 on a
4-core, 15 GB machine with no result. They need a longer run or a symmetry-reduced computation.

## 7. Open problem formalised: the Sturmfels–Sullivant conjecture (`SturmfelsSullivant.lean`)

Statement checked against full text: arXiv:q-bio/0402015 (Conjecture 27 in the arXiv version, 29
in the journal) and the combinatorial restatement in Michałek, arXiv:1508.04177, Section 2.

```lean
def Flow (n) (G) [AddCommGroup G] := {f : Fin n → G // ∑ i, f i = 0}
def Compatible (M₁ M₂ : Multiset (Flow n G)) : Prop :=
  ∀ i : Fin n, M₁.map (fun f => f.1 i) = M₂.map (fun f => f.1 i)
def Step (d : ℕ) (M M' : Multiset (Flow n G)) : Prop :=
  ∃ A B C, M = A + C ∧ M' = B + C ∧ Multiset.card A ≤ d ∧ Compatible A B
def GeneratedInDegree (d : ℕ) : Prop :=
  ∀ M₁ M₂, Compatible M₁ M₂ → Relation.ReflTransGen (Step d) M₁ M₂
def SturmfelsSullivantConjecture : Prop :=
  ∀ (G : Type) [AddCommGroup G] [Fintype G] (n : ℕ), GeneratedInDegree n G (Fintype.card G)
def SturmfelsSullivantFor (G) ... : Prop := ∀ n, GeneratedInDegree n G (Fintype.card G)
```

Proved sanity checks (axioms: propext, Classical.choice, Quot.sound):

- `reachable_compatible`: exchange steps never leave a compatibility class.
- `GeneratedInDegree.mono`: monotone in the degree.
- `generatedInDegree_of_subsingleton`: holds for the trivial group.
- `not_generatedInDegree_two_zmod3`: ℤ/3 on three leaves is **not** generated in degree 2, so
  the definition is not vacuous and the bound |G| = 3 is attained there.

Caveats:

- This is the combinatorial form. Its equivalence with "the toric ideal is generated in degree
  ≤ d" is Michałek's stated dictionary and is not formalised.
- `n = 0` is included; it is trivially true there, so the statement is equivalent to the
  positive-`n` original.
- `SturmfelsSullivantFor (ZMod 4)` is the smallest open instance. The 4ti2 data in section 2
  (max degree 4 for n = 3, 4) is evidence for it, not a proof.

## 8. Rebuilt on atlas-lean's toric ideals (`SturmfelsSullivantToric.lean`)

Compiles against facebookresearch/atlas-lean at `ac3632077` (Lean 4.35.0, Mathlib v4.35.0):
from the atlas-lean checkout, `lake build MathlibExt.RingTheory.MarkovBasis` then
`lake env lean SturmfelsSullivantToric.lean`. No `sorry`; axioms propext, Classical.choice, Quot.sound.

- `phyloIdeal k := toricIdeal k flowStat`, the ideal of the group-based model on K₁,ₙ.
- `SturmfelsSullivantConjecture`: over ℂ, that ideal is generated by its binomials of degree ≤ |G|.
- `idealGeneratedInDegree_iff`: ideal form ⇔ multiset-exchange form, over every field (uses
  atlas-lean's Diaconis–Sturmfels theorem). So the statement is field-independent.
- `not_idealGeneratedInDegree_two_zmod3`, `idealGeneratedInDegree_of_subsingleton`,
  `cubic_mem_phyloIdeal`: sanity checks in ideal form.

Not proved: that "generated by binomials of degree ≤ d" equals "generated by all elements of
degree ≤ d" (standard for toric ideals). The exchange step here bounds both multisets by d, a
harmless strengthening of the earlier file's definition for n ≥ 1.

Prior-art search (2026-11-22): no Lean statement of the conjecture found in Mathlib master, 16
cloned Lean repositories, GitHub code search, the Reservoir index (955 packages), or the public
Lean Zulip archive (62,531 topic files, to 2026-10-25).

## 9. CORRECTION: the Sturmfels–Sullivant conjecture is false (2026-11-22)

Sections 3, 4, 7 and 8 describe the conjecture as open. That was wrong for the general statement:
G. Pochuev (8 Sept 2026) gave a counterexample for ℤ/17 on three leaves, acknowledged on
M. Michałek's conjectures page. It surfaced in a multi-model review of the PR draft (Codex found
it); the literature search in this report had missed it.

Machine-checked here (no `sorry`; axioms propext, Classical.choice, Quot.sound):

- `SturmfelsSullivantZ17.lean` (Lean 4.33.1, Mathlib only):
  `not_generatedInDegree_zmod17 : ¬ GeneratedInDegree 3 (ZMod 17) 17` and
  `not_sturmfels_sullivant`. Proof: every row of a compatible table is one of 22 admissible types;
  the column conditions give 23 linear equations in the 22 multiplicities, which force the
  multiplicity vector of one of the two tables; the tables share no row, so no exchange of at
  most 17 rows connects them.
- `SturmfelsSullivantToricZ17.lean` (Lean 4.35.0, on atlas-lean `ac3632077`):
  `not_idealGeneratedInDegree_zmod17` (over every field) and `not_sturmfelsSullivantConjecture`.
- `z17/check_fibre.py`: independent exhaustive enumeration of the fibre (2 elements).

`SturmfelsSullivantConjecture` in `SturmfelsSullivant.lean` and `SturmfelsSullivantToric.lean` is
therefore a false statement; those files are superseded by the two above.

Still open to my knowledge: the bound for ℤ/4 (not re-verified against a 2026 source).

## 10. The open problem after the counterexample (2026-11-22)

Literature check (primary sources read in full; "open" rests on absence of later results):
ℤ/4 is neither proved nor disproved; the constancy conjecture [Mic13, Conj. 9.3] = [MV17, Conj. 4.3]
("φ(G, ·) is constant") is open, with only eventual constancy known; no follow-up to the ℤ/17
counterexample found.

In `SturmfelsSullivantZ17.lean` (and the atlas-based file), all without `sorry`:

- `GeneratedInDegree.of_succ`: a bound for n+1 leaves gives it for n ≥ 1 leaves (the known half).
- `not_generatedInDegree_zmod17_of_three_le`: the ℤ/17 bound fails for every n ≥ 3.
- `ConstancyConjecture` (open statement), `ConstancyConjecture.of_three` (it propagates a
  three-leaf bound to all n ≥ 3), `ZMod4Conjecture` (open statement).

Chain to ℤ/4: 4ti2 gives degree 4 for ℤ/4 on three leaves (not Lean-checked); constancy would
then give `ZMod4Conjecture` for n ≥ 3. n = 1, 2 are easy cases not written out.
