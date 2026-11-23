# Sturmfels–Sullivant degree bound: Lean proofs, scripts and notes

Working archive from one research session (November 2026). Nothing here has been peer reviewed.

## Machine-checked results (no `sorry`; axioms `propext`, `Classical.choice`, `Quot.sound`)

The Sturmfels–Sullivant conjecture (2005) said the ideal of the group-based phylogenetic model for a
finite abelian group `G` on the claw tree `K_{1,n}` is generated in degree at most `|G|`. It is false.

| File (`lean/`) | Main theorems | Builds with |
|---|---|---|
| `SturmfelsSullivantZ12.lean` | `not_generatedInDegree_zmod12` (fails for ℤ/12 on three leaves) | Lean 4.33.1, Mathlib v4.33.1 |
| `SturmfelsSullivantZ13.lean` | `not_generatedInDegree_zmod13_sharp` (ℤ/13, not even degree 16) | same |
| `SturmfelsSullivantZ17.lean` | `not_generatedInDegree_zmod17_of_three_le` (ℤ/17, every n ≥ 3); `GeneratedInDegree.of_succ` (a bound for n+1 leaves gives it for n); statements `ConstancyConjecture`, `ZMod4Conjecture` | same |
| `SturmfelsSullivantToricZ17.lean` | ideal-theoretic form over every field, via the equivalence with the combinatorial form | Lean 4.35.0, on facebookresearch/atlas-lean at `ac3632077` |

To check a Mathlib-only file: from any Lake project depending on Mathlib v4.33.1, run
`lake env lean lean/<file>`. Each file ends with `#print axioms`.

The ℤ/17 counterexample is due to Grisha Pochuev
(https://github.com/Grisha-Pochuev/phylogenetic-complexity-z17-counterexample, MIT licence;
`scripts/z17/tables_Z17.json` is copied from there). The ℤ/12 and ℤ/13 examples were found by
computer search in this session and are, to our knowledge, not in the literature.

## Superseded files

`lean/SturmfelsSullivant.lean` and `lean/SturmfelsSullivantToric.lean` were written before the
counterexample was known and define `SturmfelsSullivantConjecture`, which is a false statement.
They are kept for the equivalence proof and the ℤ/3 sanity checks only.

`lean/HornJackson.lean`, `lean/ThomsonSimplex.lean`, `lean/PhyloInvariants.lean` are unrelated
earlier exercises (known results).

## Open

Whether the bound holds for ℤ/4 for every number of leaves, and the constancy conjecture
(Michałek 2013, Conj. 9.3). See `reports/literature-review.md`. Searches in `scripts/z4/` found no
generator of degree above 4 on the faces they covered (partial coverage; see the logs). The full
five-leaf Markov basis computation had not finished when this archive was made.

## Other contents

- `scripts/z12/gen_counterexample.py`: generates the Lean proof from a two-table counterexample.
- `scripts/z12/check_fibre_general.py`, `scripts/z17/check_fibre.py`: independent exhaustive fibre checks.
- `scripts/phylo/ss.py`: Markov basis degrees via 4ti2.
- `pr/`: text and patches for a pull request to google-deepmind/formal-conjectures.
- `reports/session-report.md`: running log of the session, including corrections of earlier errors.
- `research_notes/`: source notes behind the literature review.
