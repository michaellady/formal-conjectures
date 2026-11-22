/-
Copyright 2026 The Formal Conjectures Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-/

module

public import FormalConjecturesUtil

/-!
# The Sturmfels–Sullivant conjecture on phylogenetic invariants

For a finite abelian group `G`, the ideal of phylogenetic invariants of the general group-based
model on the claw tree `K_{1,n}` is a toric ideal. Sturmfels and Sullivant conjectured that it is
generated in degree at most `|G|`, for every `n`. By [SS05, Theorem 26] the bound for claw trees
gives the same bound for every tree. For `G = ℤ/2 × ℤ/2` this is the Kimura 3-parameter model of
DNA evolution.

We formalise the combinatorial restatement of [Mic16, Section 2]. A *flow* is an `n`-tuple of
elements of `G` with sum zero. Two multisets of flows are *compatible* if, for every index `i`,
they have the same multiset of `i`-th entries. The ideal of `X(K_{1,n}, G)` is generated in degree
`d` if and only if one can pass from any multiset of flows to any compatible multiset by a series
of steps, each exchanging a sub-multiset of at most `d` flows for a compatible multiset.

*References:*
* [SS05] Sturmfels, B. and Sullivant, S. (2005). "Toric ideals of phylogenetic invariants."
  *J. Comput. Biol.* 12, pp. 204--228. Conjecture 29 (Conjecture 27 in
  [arXiv:q-bio/0402015](https://arxiv.org/abs/q-bio/0402015)).
* [CP07] Chifman, J. and Petrović, S. (2007). "Toric ideals of phylogenetic invariants for the
  general group-based model on claw trees `K_{1,n}`."
  [arXiv:math/0702368](https://arxiv.org/abs/math/0702368)
* [Mic16] Michałek, M. (2016). "Finite phylogenetic complexity of `ℤ_p` and invariants for `ℤ_3`."
  [arXiv:1508.04177](https://arxiv.org/abs/1508.04177)
* [MV17a] Michałek, M. and Ventura, E. "Finite phylogenetic complexity and combinatorics of
  tables." [arXiv:1606.07263](https://arxiv.org/abs/1606.07263)
* [MV17b] Michałek, M. and Ventura, E. "Phylogenetic complexity of the Kimura 3-parameter model."
  [arXiv:1704.02584](https://arxiv.org/abs/1704.02584)
-/

@[expose] public section

namespace SturmfelsSullivant

variable (n : ℕ) (G : Type*) [AddCommGroup G]

/-- A group-based *flow* on `n` leaves: an `n`-tuple of group elements summing to zero
[Mic16, Definition 2.1]. Flows index the Fourier coordinates of the model on `K_{1,n}`. -/
def Flow : Type _ := {f : Fin n → G // ∑ i, f i = 0}

variable {n G}

/-- Two multisets of flows are *compatible* if they have the same multiset of entries at every
leaf. Equivalently, the corresponding monomials have the same image under the monomial
parametrisation, so their difference is a binomial in the ideal. -/
def Compatible (M₁ M₂ : Multiset (Flow n G)) : Prop :=
  ∀ i : Fin n, M₁.map (fun f => f.1 i) = M₂.map (fun f => f.1 i)

/-- One exchange step of degree at most `d`: replace a sub-multiset `A` of at most `d` flows by a
compatible multiset `B`. -/
def Step (d : ℕ) (M M' : Multiset (Flow n G)) : Prop :=
  ∃ A B C : Multiset (Flow n G), M = A + C ∧ M' = B + C ∧ A.card ≤ d ∧ B.card ≤ d ∧
    Compatible A B

variable (n G) in
/-- The ideal of the group-based model for `G` on the claw tree `K_{1,n}` is generated in degree
at most `d`, in the combinatorial form of [Mic16, Section 2]: any two compatible multisets of
flows are joined by exchange steps of degree at most `d`. -/
def GeneratedInDegree (d : ℕ) : Prop :=
  ∀ M₁ M₂ : Multiset (Flow n G), Compatible M₁ M₂ → Relation.ReflTransGen (Step d) M₁ M₂

/-- An exchange step stays inside the compatibility class. -/
@[category API, AMS 5 13]
lemma Step.compatible {d : ℕ} {M M' : Multiset (Flow n G)} (h : Step d M M') :
    Compatible M M' := by
  obtain ⟨A, B, C, rfl, rfl, -, -, hAB⟩ := h
  intro i
  rw [Multiset.map_add, Multiset.map_add, hAB i]

/-- Multisets joined by exchange steps are compatible, so `GeneratedInDegree` says that
compatibility and reachability coincide. -/
@[category API, AMS 5 13]
lemma compatible_of_reflTransGen {d : ℕ} {M M' : Multiset (Flow n G)}
    (h : Relation.ReflTransGen (Step d) M M') : Compatible M M' := by
  induction h with
  | refl => exact fun _ => rfl
  | tail _ hs ih => exact fun i => (ih i).trans (hs.compatible i)

/--
**The Sturmfels–Sullivant conjecture** [SS05, Conjecture 29].

For every finite abelian group `G` and every `n`, the ideal of phylogenetic invariants of the
group-based model for `G` on the claw tree `K_{1,n}` is generated in degree at most `|G|`.
-/
@[category research open, AMS 5 13 14 92]
theorem sturmfels_sullivant (G : Type) [AddCommGroup G] [Fintype G] (n : ℕ) :
    GeneratedInDegree n G (Fintype.card G) := by
  sorry

/--
**The smallest open case**: the cyclic group of order four.
-/
@[category research open, AMS 5 13 14 92]
theorem sturmfels_sullivant.variants.zmod_four (n : ℕ) : GeneratedInDegree n (ZMod 4) 4 := by
  sorry

/--
**The group `ℤ/2`** (Sturmfels–Sullivant [SS05], Chifman–Petrović [CP07]): the ideal is generated
by quadrics.
-/
@[category research solved, AMS 5 13 14 92]
theorem sturmfels_sullivant.variants.zmod_two (n : ℕ) : GeneratedInDegree n (ZMod 2) 2 := by
  sorry

/--
**The group `ℤ/3`** (Michałek [Mic16, Theorem 1.4]): the ideal is generated in degree three.
-/
@[category research solved, AMS 5 13 14 92]
theorem sturmfels_sullivant.variants.zmod_three (n : ℕ) : GeneratedInDegree n (ZMod 3) 3 := by
  sorry

/--
**The Kimura 3-parameter model** (Michałek–Ventura [MV17b]): for `G = ℤ/2 × ℤ/2` the ideal is
generated in degree four, as conjectured in [SS05] (Conjecture 28 of the arXiv version).
-/
@[category research solved, AMS 5 13 14 92]
theorem sturmfels_sullivant.variants.kimura (n : ℕ) :
    GeneratedInDegree n (ZMod 2 × ZMod 2) 4 := by
  sorry

/--
**Finite phylogenetic complexity** (Michałek–Ventura [MV17a]): for every finite abelian group
there is a degree bound independent of the number of leaves.
-/
@[category research solved, AMS 5 13 14 92]
theorem sturmfels_sullivant.variants.finite (G : Type) [AddCommGroup G] [Fintype G] :
    ∃ d : ℕ, ∀ n : ℕ, GeneratedInDegree n G d := by
  sorry

/--
**The trivial group**: all flows coincide, so compatible multisets are equal.
-/
@[category test, AMS 5 13]
theorem sturmfels_sullivant.variants.subsingleton [Subsingleton G] (hn : 0 < n) (d : ℕ) :
    GeneratedInDegree n G d := by
  intro M₁ M₂ hc
  have : Subsingleton (Flow n G) :=
    ⟨fun f g => Subtype.ext (funext fun i => Subsingleton.elim _ _)⟩
  have hcard : M₁.card = M₂.card := by simpa using congrArg Multiset.card (hc ⟨0, hn⟩)
  have : M₁ = M₂ := by
    rcases Multiset.empty_or_exists_mem M₁ with h0 | ⟨a, -⟩
    · subst h0
      exact (Multiset.card_eq_zero.mp (by simpa using hcard.symm)).symm
    · have e₁ : M₁ = Multiset.replicate M₁.card a :=
        Multiset.eq_replicate_card.mpr fun b _ => Subsingleton.elim b a
      have e₂ : M₂ = Multiset.replicate M₂.card a :=
        Multiset.eq_replicate_card.mpr fun b _ => Subsingleton.elim b a
      rw [e₁, e₂, hcard]
  rw [this]

/-- The flow `(a, b, c)` over `ℤ/3`. -/
def flow₃ (a b c : ZMod 3) (h : a + b + c = 0) : Flow 3 (ZMod 3) :=
  ⟨![a, b, c], by simpa [Fin.sum_univ_three] using h⟩

/--
**The cubic invariant for `ℤ/3` on three leaves**: `{000, 111, 222}` and `{012, 120, 201}` are
compatible, which is the binomial `q₀₀₀ q₁₁₁ q₂₂₂ - q₀₁₂ q₁₂₀ q₂₀₁`.
-/
@[category test, AMS 5 13]
theorem sturmfels_sullivant.variants.zmod_three_cubic :
    Compatible
      ({flow₃ 0 0 0 (by decide), flow₃ 1 1 1 (by decide), flow₃ 2 2 2 (by decide)} :
        Multiset (Flow 3 (ZMod 3)))
      {flow₃ 0 1 2 (by decide), flow₃ 1 2 0 (by decide), flow₃ 2 0 1 (by decide)} := by
  intro i
  fin_cases i <;> simp [flow₃] <;> decide

/--
**The bound `|G|` is attained for `ℤ/3`**: on three leaves the ideal is not generated in degree
two, because no exchange of at most two flows changes `{000, 111, 222}`.
-/
@[category textbook, AMS 5 13]
theorem sturmfels_sullivant.variants.zmod_three_not_two : ¬ GeneratedInDegree 3 (ZMod 3) 2 := by
  sorry

end SturmfelsSullivant
