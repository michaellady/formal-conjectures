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
generated in degree at most `|G|` for every `n` [SS05, Conjecture 29]. For `G = ℤ/2 × ℤ/2` this is
the Kimura 3-parameter model of DNA evolution [SS05, Conjecture 30], proved in [MV19].

**The general conjecture is false.** G. Pochuev [Poc26] gave a counterexample for `G = ℤ/17` and
`n = 3`: two compatible tables of 18 flows with no common row whose compatibility class consists of
exactly those two tables. The counterexample is acknowledged in [Mic]. The smallest group for which
the bound is not known is `ℤ/4`.

## Formalisation

We formalise the combinatorial restatement of [Mic16, Section 2]. A *flow* is an `n`-tuple of
elements of `G` with sum zero. Two multisets of flows are *compatible* if, for every index `i`,
they have the same multiset of `i`-th entries. By [Mic16, Section 2], "the ideal of the variety
`X(K_{1,n}, G)` is generated in degree `d` if and only if [...] we are able to pass from any
multiset to any compatible multiset in a series of steps, each time exchanging a submultiset (of
one multiset) with at most `d` flows by a compatible multiset of flows". This equivalence is the
standard dictionary between Markov bases and generators of toric ideals; it is **not** proved in
this file, and the statements below are about the combinatorial side only.

For `n ≥ 1` compatible multisets have the same cardinality. For `n = 0` compatibility is vacuous,
so the statements below assume `0 < n`.

*References:*
* [SS05] Sturmfels, B. and Sullivant, S. (2005). "Toric ideals of phylogenetic invariants."
  *J. Comput. Biol.* 12, no. 2, pp. 204--228. Conjectures 29 and 30 (Conjectures 27 and 28 in
  [arXiv:q-bio/0402015](https://arxiv.org/abs/q-bio/0402015)).
* [CP07] Chifman, J. and Petrović, S. (2007). "Toric ideals of phylogenetic invariants for the
  general group-based model on claw trees `K_{1,n}`."
  [arXiv:math/0702368](https://arxiv.org/abs/math/0702368)
* [Mic16] Michałek, M. (2016). "Finite phylogenetic complexity of `ℤ_p` and invariants for `ℤ_3`."
  [arXiv:1508.04177](https://arxiv.org/abs/1508.04177)
* [MV17] Michałek, M. and Ventura, E. "Finite phylogenetic complexity and combinatorics of
  tables." [arXiv:1606.07263](https://arxiv.org/abs/1606.07263)
* [MV19] Michałek, M. and Ventura, E. (2019). "Phylogenetic complexity of the Kimura 3-parameter
  model." *Adv. Math.* 343, pp. 640--680. [arXiv:1704.02584](https://arxiv.org/abs/1704.02584)
* [Poc26] Pochuev, G. (2026). "A degree-18 counterexample to the group-order bound for
  phylogenetic complexity." Manuscript and data:
  [github.com/Grisha-Pochuev/phylogenetic-complexity-z17-counterexample](https://github.com/Grisha-Pochuev/phylogenetic-complexity-z17-counterexample)
* [Mic] Michałek, M. "Conjectures."
  [math.uni-konstanz.de/~michalek/conjectures.html](https://www.math.uni-konstanz.de/~michalek/conjectures.html)
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
compatible multiset `B`. For `n ≥ 1` compatibility forces `B.card = A.card`, so the bound on `B`
is redundant; it is kept so that the relation is symmetric for every `n`. -/
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
**The Sturmfels–Sullivant conjecture is false** [SS05, Conjecture 29], [Poc26].

It is not true that for every finite abelian group `G` and every `n ≥ 1` the ideal of
phylogenetic invariants of the group-based model for `G` on the claw tree `K_{1,n}` is generated
in degree at most `|G|`.
-/
@[category research solved, AMS 5 13 14 92]
theorem sturmfels_sullivant :
    ¬ ∀ (G : Type) [AddCommGroup G] [Fintype G] (n : ℕ), 0 < n →
      GeneratedInDegree n G (Fintype.card G) := by
  sorry

/--
**Pochuev's counterexample** [Poc26]: for `G = ℤ/17` on three leaves the ideal is not generated
in degree `17`. There are two compatible multisets of 18 flows with no flow in common whose
compatibility class contains only those two multisets.
-/
@[category research solved, AMS 5 13 14 92]
theorem sturmfels_sullivant.variants.zmod_seventeen : ¬ GeneratedInDegree 3 (ZMod 17) 17 := by
  sorry

/--
**The smallest group for which the bound is not known**: the cyclic group of order four.
-/
@[category research open, AMS 5 13 14 92]
theorem sturmfels_sullivant.variants.zmod_four (n : ℕ) (hn : 0 < n) :
    GeneratedInDegree n (ZMod 4) 4 := by
  sorry

/--
**The group `ℤ/2`** (Sturmfels–Sullivant [SS05], Chifman–Petrović [CP07]): the ideal is generated
by quadrics.
-/
@[category research solved, AMS 5 13 14 92]
theorem sturmfels_sullivant.variants.zmod_two (n : ℕ) (hn : 0 < n) :
    GeneratedInDegree n (ZMod 2) 2 := by
  sorry

/--
**The group `ℤ/3`** (Michałek [Mic16, Theorem 1.4]): the ideal is generated in degree three.
-/
@[category research solved, AMS 5 13 14 92]
theorem sturmfels_sullivant.variants.zmod_three (n : ℕ) (hn : 0 < n) :
    GeneratedInDegree n (ZMod 3) 3 := by
  sorry

/--
**The Kimura 3-parameter model** (Michałek–Ventura [MV19]): for `G = ℤ/2 × ℤ/2` the ideal is
generated in degree four. This was [SS05, Conjecture 30].
-/
@[category research solved, AMS 5 13 14 92]
theorem sturmfels_sullivant.variants.kimura (n : ℕ) (hn : 0 < n) :
    GeneratedInDegree n (ZMod 2 × ZMod 2) 4 := by
  sorry

/--
**Finite phylogenetic complexity** (Michałek–Ventura [MV17], abstract: "the phylogenetic
complexity [...] of any finite abelian group is finite"): for every finite abelian group there is
a degree bound independent of the number of leaves.
-/
@[category research solved, AMS 5 13 14 92]
theorem sturmfels_sullivant.variants.finite (G : Type) [AddCommGroup G] [Fintype G] :
    ∃ d : ℕ, ∀ n : ℕ, 0 < n → GeneratedInDegree n G d := by
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

/-- `{000, 111, 222}`. -/
def diag₃ : Multiset (Flow 3 (ZMod 3)) :=
  {flow₃ 0 0 0 (by decide), flow₃ 1 1 1 (by decide), flow₃ 2 2 2 (by decide)}

/-- `{012, 120, 201}`. -/
def cyc₃ : Multiset (Flow 3 (ZMod 3)) :=
  {flow₃ 0 1 2 (by decide), flow₃ 1 2 0 (by decide), flow₃ 2 0 1 (by decide)}

/--
**The cubic invariant for `ℤ/3` on three leaves**: `{000, 111, 222}` and `{012, 120, 201}` are
compatible, which is the binomial `q₀₀₀ q₁₁₁ q₂₂₂ - q₀₁₂ q₁₂₀ q₂₀₁`.
-/
@[category test, AMS 5 13]
theorem sturmfels_sullivant.variants.zmod_three_cubic : Compatible diag₃ cyc₃ := by
  intro i
  fin_cases i <;> simp [diag₃, cyc₃, flow₃] <;> decide

/-- A flow over `ℤ/3` on three leaves with two equal entries is constant. -/
@[category API, AMS 5 13]
lemma flow₃_const_of_two_eq (f : Flow 3 (ZMod 3))
    (h : f.1 0 = f.1 1 ∨ f.1 1 = f.1 2 ∨ f.1 0 = f.1 2) :
    f = flow₃ (f.1 0) (f.1 0) (f.1 0) (by generalize f.1 0 = x; revert x; decide) := by
  have hsum : f.1 0 + f.1 1 + f.1 2 = 0 := by simpa [Fin.sum_univ_three] using f.2
  have key : ∀ x y z : ZMod 3, x + y + z = 0 → (x = y ∨ y = z ∨ x = z) → x = y ∧ y = z := by
    decide
  obtain ⟨h01, h12⟩ := key _ _ _ hsum h
  apply Subtype.ext
  funext k
  fin_cases k
  · rfl
  · exact h01.symm
  · exact (h01.trans h12).symm

/-- From `{000, 111, 222}` no exchange of at most two flows leads anywhere else. -/
@[category API, AMS 5 13]
lemma step_two_diag₃ {M' : Multiset (Flow 3 (ZMod 3))} (h : Step 2 diag₃ M') : M' = diag₃ := by
  obtain ⟨A, B, C, hM, rfl, hcard, -, hAB⟩ := h
  have hA : ∀ a ∈ A, a = flow₃ (a.1 0) (a.1 0) (a.1 0)
      (by generalize a.1 0 = x; revert x; decide) := by
    intro a ha
    have : a ∈ diag₃ := by rw [hM]; exact Multiset.mem_add.mpr (Or.inl ha)
    simp only [diag₃, Multiset.insert_eq_cons, Multiset.mem_cons, Multiset.mem_singleton] at this
    rcases this with rfl | rfl | rfl <;> rfl
  classical
  have hB : ∀ b ∈ B, b = flow₃ (b.1 0) (b.1 0) (b.1 0)
      (by generalize b.1 0 = x; revert x; decide) := by
    intro b hb
    -- the three entries of `b` are first entries of flows of `A`, and `A` has at most two flows
    have hS : ((A.map (fun a => a.1 0)).toFinset).card ≤ 2 :=
      (Multiset.toFinset_card_le _).trans (by simpa using hcard)
    have hmem : ∀ i, b.1 i ∈ (A.map (fun a => a.1 0)).toFinset := by
      intro i
      have : b.1 i ∈ B.map (fun f => f.1 i) := Multiset.mem_map_of_mem _ hb
      rw [← hAB i] at this
      obtain ⟨a, ha, hai⟩ := Multiset.mem_map.mp this
      rw [Multiset.mem_toFinset]
      refine Multiset.mem_map.mpr ⟨a, ha, ?_⟩
      rw [← hai, hA a ha]; fin_cases i <;> rfl
    obtain ⟨i, -, j, -, hij, heq⟩ := Finset.exists_ne_map_eq_of_card_lt_of_maps_to
      (s := (Finset.univ : Finset (Fin 3))) (f := b.1) (by simpa using Nat.lt_succ_of_le hS)
      (fun i _ => hmem i)
    have aux : ∀ (g : Fin 3 → ZMod 3) (i j : Fin 3), i ≠ j → g i = g j →
        g 0 = g 1 ∨ g 1 = g 2 ∨ g 0 = g 2 := by
      intro g i j hij h
      fin_cases i <;> fin_cases j <;> first
        | exact absurd rfl hij
        | exact Or.inl h
        | exact Or.inr (Or.inl h)
        | exact Or.inr (Or.inr h)
        | exact Or.inl h.symm
        | exact Or.inr (Or.inl h.symm)
        | exact Or.inr (Or.inr h.symm)
    exact flow₃_const_of_two_eq b (aux b.1 i j hij heq)
  have eA : A = (A.map (fun a => a.1 0)).map
      (fun x => flow₃ x x x (by revert x; decide)) := by
    rw [Multiset.map_map]
    conv_lhs => rw [← Multiset.map_id A]
    exact Multiset.map_congr rfl fun a ha => hA a ha
  have eB : B = (B.map (fun a => a.1 0)).map
      (fun x => flow₃ x x x (by revert x; decide)) := by
    rw [Multiset.map_map]
    conv_lhs => rw [← Multiset.map_id B]
    exact Multiset.map_congr rfl fun b hb => hB b hb
  rw [hM, eA, eB, hAB 0]

/--
**The bound `|G|` is attained for `ℤ/3`**: on three leaves the ideal is not generated in degree
two. No exchange of at most two flows changes `{000, 111, 222}` (`step_two_diag₃`), so no chain of
such exchanges reaches the compatible multiset `{012, 120, 201}`.
-/
@[category test, AMS 5 13]
theorem sturmfels_sullivant.variants.zmod_three_not_two : ¬ GeneratedInDegree 3 (ZMod 3) 2 := by
  intro h
  have hreach := h diag₃ cyc₃ sturmfels_sullivant.variants.zmod_three_cubic
  have hstay : ∀ M, Relation.ReflTransGen (Step 2) diag₃ M → M = diag₃ := by
    intro M hM
    induction hM with
    | refl => rfl
    | tail _ hs ih => rw [ih] at hs; exact step_two_diag₃ hs
  have hmem : flow₃ 0 1 2 (by decide) ∈ diag₃ := by
    rw [← hstay _ hreach]; simp [cyc₃]
  simp only [diag₃, Multiset.insert_eq_cons, Multiset.mem_cons, Multiset.mem_singleton] at hmem
  have key : ∀ x : ZMod 3, flow₃ 0 1 2 (by decide) ≠ flow₃ x x x (by revert x; decide) := by
    intro x hx
    have h0 := congrArg (fun f : Flow 3 (ZMod 3) => f.1 0) hx
    have h1 := congrArg (fun f : Flow 3 (ZMod 3) => f.1 1) hx
    simp [flow₃] at h0 h1
    rw [← h0] at h1
    exact absurd h1 (by decide)
  rcases hmem with h | h | h <;> exact key _ h

end SturmfelsSullivant
