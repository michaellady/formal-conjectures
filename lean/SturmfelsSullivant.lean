/-
# The Sturmfels–Sullivant conjecture on group-based phylogenetic models (OPEN), stated in Lean

Sources.
* B. Sturmfels, S. Sullivant, *Toric ideals of phylogenetic invariants* (J. Comput. Biol. 2005),
  arXiv:q-bio/0402015, Conjecture 27 of the arXiv version (Conjecture 29 in the journal):
  "For any finite abelian group `G` and any positive integer `n` we have `φ(G, n) ≤ |G|`",
  where `φ(G, n)` is the degree in which the ideal of the group-based model on the claw tree
  `K_{1,n}` is generated.  By their Theorem 26 (toric fibre products) the bound for claw trees
  gives the bound for every tree.
* M. Michałek, *Finite phylogenetic complexity of ℤ_p and invariants for ℤ₃*, arXiv:1508.04177,
  Section 2, gives the combinatorial restatement formalised here:

  A *flow* is `f : [n] → G` with `∑ f i = 0`.  Two multisets of flows are *compatible* if for every
  coordinate `i` they have the same multiset of `i`-th entries.  "The ideal of `X(K_{1,n}, G)` is
  generated in degree `d` if and only if we are able to pass from any multiset to any compatible
  multiset in a series of steps, each time exchanging a submultiset with at most `d` flows by a
  compatible multiset of flows."

What is formalised: the combinatorial statement (`SturmfelsSullivantConjecture`).  The equivalence
with the ideal-theoretic statement is Michałek's (standard toric dictionary) and is *not*
formalised here.

Status (literature): proved for `ℤ/2` (Sturmfels–Sullivant; Chifman–Petrović), `ℤ/3` (Michałek),
`ℤ/2 × ℤ/2` (Michałek–Ventura); open for every other group, the smallest being `ℤ/4`.

Why it matters outside mathematics: the generators are the *phylogenetic invariants* of the
Jukes–Cantor/Kimura-type DNA substitution models; a degree bound `|G|` (= 4 for DNA) makes the
complete list of invariants for every tree finite and explicitly computable, which is what
invariant-based tree reconstruction and model-identifiability arguments need.

Sanity checks proved below (no `sorry`):
* `Step.compatible`, `reachable_compatible` : exchange steps never leave a compatibility class,
  so `GeneratedInDegree` really is "compatibility = reachability".
* `GeneratedInDegree.mono` : monotone in the degree.
* `generatedInDegree_of_subsingleton` : the conjecture holds for the trivial group.
* `not_generatedInDegree_two_zmod3` : for `G = ℤ/3`, `n = 3`, degree 2 does **not** suffice
  (the cubic `q₀₀₀ q₁₁₁ q₂₂₂ - q₀₁₂ q₁₂₀ q₂₀₁` is a minimal generator), so the definition is not
  vacuously true and the bound `|G| = 3` is sharp there.
-/
import Mathlib

namespace Phylo

variable (n : ℕ) (G : Type*) [AddCommGroup G]

/-- A group-based flow on `n` leaves: an `n`-tuple of group elements summing to zero. -/
def Flow : Type _ := {f : Fin n → G // ∑ i, f i = 0}

variable {n G}

/-- Two multisets of flows are compatible if they have the same multiset of entries at every
leaf (equivalently: the corresponding monomials have the same image under the parametrisation). -/
def Compatible (M₁ M₂ : Multiset (Flow n G)) : Prop :=
  ∀ i : Fin n, M₁.map (fun f => f.1 i) = M₂.map (fun f => f.1 i)

/-- One exchange step of degree at most `d`: replace a sub-multiset `A` with at most `d` flows by
a compatible multiset `B`. -/
def Step (d : ℕ) (M M' : Multiset (Flow n G)) : Prop :=
  ∃ A B C : Multiset (Flow n G), M = A + C ∧ M' = B + C ∧ Multiset.card A ≤ d ∧ Compatible A B

variable (n G) in
/-- The ideal of the group-based model on the claw tree `K_{1,n}` is generated in degree `≤ d`
(combinatorial form, Michałek 2016, Section 2). -/
def GeneratedInDegree (d : ℕ) : Prop :=
  ∀ M₁ M₂ : Multiset (Flow n G), Compatible M₁ M₂ → Relation.ReflTransGen (Step d) M₁ M₂

/-- **Sturmfels–Sullivant conjecture** (open): for every finite abelian group `G` and every `n`,
the ideal of the group-based model on the claw tree `K_{1,n}` is generated in degree `≤ |G|`. -/
def SturmfelsSullivantConjecture : Prop :=
  ∀ (G : Type) [AddCommGroup G] [Fintype G] (n : ℕ), GeneratedInDegree n G (Fintype.card G)

/-- The conjecture for one group. `SturmfelsSullivantFor (ZMod 4)` is the smallest open case. -/
def SturmfelsSullivantFor (G : Type) [AddCommGroup G] [Fintype G] : Prop :=
  ∀ n : ℕ, GeneratedInDegree n G (Fintype.card G)

/-! ## Sanity checks -/

lemma Compatible.refl (M : Multiset (Flow n G)) : Compatible M M := fun _ => rfl

lemma Compatible.trans {M₁ M₂ M₃ : Multiset (Flow n G)} (h₁ : Compatible M₁ M₂)
    (h₂ : Compatible M₂ M₃) : Compatible M₁ M₃ := fun i => (h₁ i).trans (h₂ i)

/-- An exchange step stays inside the compatibility class. -/
lemma Step.compatible {d : ℕ} {M M' : Multiset (Flow n G)} (h : Step d M M') :
    Compatible M M' := by
  obtain ⟨A, B, C, rfl, rfl, -, hAB⟩ := h
  intro i
  rw [Multiset.map_add, Multiset.map_add, hAB i]

/-- Reachability by exchange steps implies compatibility (the easy half of "iff"). -/
lemma reachable_compatible {d : ℕ} {M M' : Multiset (Flow n G)}
    (h : Relation.ReflTransGen (Step d) M M') : Compatible M M' := by
  induction h with
  | refl => exact Compatible.refl _
  | tail _ hs ih => exact ih.trans hs.compatible

lemma Step.mono {d e : ℕ} (hde : d ≤ e) {M M' : Multiset (Flow n G)} (h : Step d M M') :
    Step e M M' := by
  obtain ⟨A, B, C, h1, h2, h3, h4⟩ := h
  exact ⟨A, B, C, h1, h2, h3.trans hde, h4⟩

lemma GeneratedInDegree.mono {d e : ℕ} (hde : d ≤ e) (h : GeneratedInDegree n G d) :
    GeneratedInDegree n G e :=
  fun M₁ M₂ hc => by
    have hr := h M₁ M₂ hc
    clear hc
    induction hr with
    | refl => exact Relation.ReflTransGen.refl
    | tail _ hs ih => exact Relation.ReflTransGen.tail ih (Step.mono hde hs)

/-- Compatible multisets have the same number of flows (for `n ≥ 1`). -/
lemma Compatible.card_eq {M₁ M₂ : Multiset (Flow n G)} (h : Compatible M₁ M₂) (i : Fin n) :
    Multiset.card M₁ = Multiset.card M₂ := by
  have := congrArg Multiset.card (h i)
  simpa using this

/-- The conjecture holds for the trivial group (all flows coincide), for `n ≥ 1`. -/
theorem generatedInDegree_of_subsingleton [Subsingleton G] (hn : 0 < n) (d : ℕ) :
    GeneratedInDegree n G d := by
  intro M₁ M₂ hc
  have : Subsingleton (Flow n G) := ⟨fun f g => Subtype.ext (funext fun i => Subsingleton.elim _ _)⟩
  have hcard := hc.card_eq ⟨0, hn⟩
  have : M₁ = M₂ := by
    rcases Multiset.empty_or_exists_mem M₁ with h0 | ⟨a, -⟩
    · subst h0
      exact (Multiset.card_eq_zero.mp (by simpa using hcard.symm)).symm
    · have e₁ : M₁ = Multiset.replicate (Multiset.card M₁) a :=
        Multiset.eq_replicate_card.mpr fun b _ => Subsingleton.elim b a
      have e₂ : M₂ = Multiset.replicate (Multiset.card M₂) a :=
        Multiset.eq_replicate_card.mpr fun b _ => Subsingleton.elim b a
      rw [e₁, e₂, hcard]
  rw [this]

/-! ### `ℤ/3` on three leaves needs a cubic -/

/-- The constant flow `(g, g, g)` over `ℤ/3`. -/
def constFlow (g : ZMod 3) : Flow 3 (ZMod 3) :=
  ⟨fun _ => g, by simp [Fin.sum_univ_three]; revert g; decide⟩

/-- The flow `(a, b, c)` over `ℤ/3` (requires `a + b + c = 0`). -/
def mkFlow (a b c : ZMod 3) (h : a + b + c = 0) : Flow 3 (ZMod 3) :=
  ⟨![a, b, c], by simpa [Fin.sum_univ_three] using h⟩

/-- `{000, 111, 222}`. -/
def M₁ : Multiset (Flow 3 (ZMod 3)) := {constFlow 0, constFlow 1, constFlow 2}

/-- `{012, 120, 201}`. -/
def M₂ : Multiset (Flow 3 (ZMod 3)) :=
  {mkFlow 0 1 2 (by decide), mkFlow 1 2 0 (by decide), mkFlow 2 0 1 (by decide)}

/-- The two multisets are compatible: this is the cubic invariant
`q₀₀₀ q₁₁₁ q₂₂₂ = q₀₁₂ q₁₂₀ q₂₀₁`. -/
lemma M₁_M₂_compatible : Compatible M₁ M₂ := by
  intro i
  fin_cases i <;> simp [M₁, M₂, constFlow, mkFlow] <;> decide

private lemma zmod3_const : ∀ x y z : ZMod 3, x + y + z = 0 → (x = y ∨ y = z ∨ x = z) →
    x = y ∧ y = z := by decide

/-- A flow over `ℤ/3` on three leaves whose entries take at most two values is constant. -/
private lemma flow_const_of_two_values (f : Flow 3 (ZMod 3)) (S : Finset (ZMod 3))
    (hS : S.card ≤ 2) (hf : ∀ i, f.1 i ∈ S) : f = constFlow (f.1 0) := by
  have hsum : f.1 0 + f.1 1 + f.1 2 = 0 := by
    have := f.2; rwa [Fin.sum_univ_three] at this
  obtain ⟨i, -, j, -, hij, heq⟩ := Finset.exists_ne_map_eq_of_card_lt_of_maps_to
    (s := (Finset.univ : Finset (Fin 3))) (t := S) (f := f.1) (by simpa using Nat.lt_succ_of_le hS)
    (fun i _ => hf i)
  have h3 : f.1 0 = f.1 1 ∨ f.1 1 = f.1 2 ∨ f.1 0 = f.1 2 := by
    fin_cases i <;> fin_cases j <;> simp_all <;> tauto
  obtain ⟨h01, h12⟩ := zmod3_const _ _ _ hsum h3
  apply Subtype.ext
  funext k
  fin_cases k
  · rfl
  · exact h01.symm
  · exact (h01.trans h12).symm

/-- From `{000, 111, 222}` no exchange of at most two flows leads anywhere else. -/
private lemma step_two_M₁ {M' : Multiset (Flow 3 (ZMod 3))} (h : Step 2 M₁ M') : M' = M₁ := by
  obtain ⟨A, B, C, hM, rfl, hcard, hAB⟩ := h
  have hA : ∀ a ∈ A, a = constFlow (a.1 0) := by
    intro a ha
    have : a ∈ M₁ := by rw [hM]; exact Multiset.mem_add.mpr (Or.inl ha)
    simp only [M₁, Multiset.insert_eq_cons, Multiset.mem_cons, Multiset.mem_singleton] at this
    rcases this with rfl | rfl | rfl <;> rfl
  classical
  set S : Finset (ZMod 3) := (A.map (fun a => a.1 0)).toFinset with hSdef
  have hScard : S.card ≤ 2 :=
    (Multiset.toFinset_card_le _).trans (by simpa using hcard)
  have hB : ∀ b ∈ B, b = constFlow (b.1 0) := by
    intro b hb
    refine flow_const_of_two_values b S hScard fun i => ?_
    have : b.1 i ∈ B.map (fun f => f.1 i) := Multiset.mem_map_of_mem _ hb
    rw [← hAB i] at this
    obtain ⟨a, ha, hai⟩ := Multiset.mem_map.mp this
    rw [hSdef, Multiset.mem_toFinset]
    refine Multiset.mem_map.mpr ⟨a, ha, ?_⟩
    rw [← hai, hA a ha]; rfl
  have eA : A = (A.map (fun a => a.1 0)).map constFlow := by
    rw [Multiset.map_map]
    conv_lhs => rw [← Multiset.map_id A]
    exact Multiset.map_congr rfl fun a ha => hA a ha
  have eB : B = (B.map (fun a => a.1 0)).map constFlow := by
    rw [Multiset.map_map]
    conv_lhs => rw [← Multiset.map_id B]
    exact Multiset.map_congr rfl fun b hb => hB b hb
  rw [hM, eA, eB, hAB 0]

/-- **`ℤ/3` on the claw `K_{1,3}` is not generated in degree 2**: the definitions are not
vacuous, and together with Michałek's theorem the bound `|G| = 3` is attained. -/
theorem not_generatedInDegree_two_zmod3 : ¬ GeneratedInDegree 3 (ZMod 3) 2 := by
  intro h
  have hreach := h M₁ M₂ M₁_M₂_compatible
  have hstay : ∀ M, Relation.ReflTransGen (Step 2) M₁ M → M = M₁ := by
    intro M hM
    induction hM with
    | refl => rfl
    | tail _ hs ih => rw [ih] at hs; exact step_two_M₁ hs
  have heq : M₂ = M₁ := hstay _ hreach
  have hmem : mkFlow 0 1 2 (by decide) ∈ M₁ := by rw [← heq]; simp [M₂]
  simp only [M₁, Multiset.insert_eq_cons, Multiset.mem_cons, Multiset.mem_singleton] at hmem
  have key : ∀ g : ZMod 3, mkFlow 0 1 2 (by decide) ≠ constFlow g := by
    intro g hg
    have h0 := congrArg (fun f : Flow 3 (ZMod 3) => f.1 0) hg
    have h1 := congrArg (fun f : Flow 3 (ZMod 3) => f.1 1) hg
    simp [mkFlow, constFlow] at h0 h1
    rw [← h0] at h1
    exact absurd h1 (by decide)
  rcases hmem with h | h | h <;> exact key _ h

end Phylo

#print axioms Phylo.SturmfelsSullivantConjecture
#print axioms Phylo.not_generatedInDegree_two_zmod3
#print axioms Phylo.generatedInDegree_of_subsingleton
#print axioms Phylo.reachable_compatible
