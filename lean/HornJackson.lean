/-
# Horn–Jackson dissipation inequality for complex-balanced mass-action systems

Setting. Species `S`, reactions `R` (finite). Reaction `r` turns the complex `src r : S → ℕ`
into `tgt r : S → ℕ` with rate constant `k r > 0`. Mass-action kinetics gives the vector field
`rhs x s = ∑ r, k r * x^(src r) * (tgt r s - src r s)`.

`c` is *complex balanced* if for every complex `z` the flux into `z` equals the flux out of `z`.

Main results (all for an arbitrary finite network):
* `ComplexBalanced.rhs_eq_zero` : a complex-balanced point is an equilibrium.
* `dissipation` : for every positive state `x`,
    `∑ s, rhs x s * log (x s / c s) ≤ 0`.
  The left side is `⟨∇V(x), f(x)⟩` for the pseudo-Helmholtz free energy
  `V x = ∑ s, (x s * (log (x s) - log (c s) - 1) + c s)`, so this is exactly the statement that
  `V` is a Lyapunov function (Horn–Jackson 1972).  It is the starting point of every known
  partial proof of the Global Attractor Conjecture.
* `freeEnergy_nonneg` : `V ≥ 0` on positive states.

Proof sketch of `dissipation`. Put `u(z) = ∏ s, (x s / c s)^(z s) > 0` and
`κ r = k r * c^(src r) > 0`.  Then `x^(src r) = c^(src r) * u(src r)` and
`∑ s, (tgt r s - src r s) * log (x s / c s) = log u(tgt r) - log u(src r)`, so the left side equals
`∑ r, κ r * u(src r) * (log u(tgt r) - log u(src r))`.
The scalar inequality `a * (log b - log a) ≤ b - a` (i.e. `log t ≤ t - 1`) bounds this by
`∑ r, κ r * (u(tgt r) - u(src r))`, and complex balance says precisely that
`∑ r, κ r * g(tgt r) = ∑ r, κ r * g(src r)` for every function `g` on complexes.
-/
import Mathlib

open Finset

namespace CRN

variable {S R : Type*} [Fintype S] [Fintype R]

/-- A mass-action reaction network on species `S` with reactions indexed by `R`. -/
structure Network (S R : Type*) where
  src : R → S → ℕ
  tgt : R → S → ℕ
  k : R → ℝ
  k_pos : ∀ r, 0 < k r

/-- The monomial `x^y = ∏ s, x s ^ y s`. -/
def mono (x : S → ℝ) (y : S → ℕ) : ℝ := ∏ s, x s ^ y s

/-- Mass-action vector field. -/
def Network.rhs (N : Network S R) (x : S → ℝ) (s : S) : ℝ :=
  ∑ r, N.k r * mono x (N.src r) * ((N.tgt r s : ℝ) - (N.src r s : ℝ))

open Classical in
/-- `c` is complex balanced: at every complex, inflow equals outflow. -/
def Network.ComplexBalanced (N : Network S R) (c : S → ℝ) : Prop :=
  ∀ z : S → ℕ,
    ∑ r ∈ univ.filter (fun r => N.tgt r = z), N.k r * mono c (N.src r)
      = ∑ r ∈ univ.filter (fun r => N.src r = z), N.k r * mono c (N.src r)

lemma mono_pos {x : S → ℝ} (hx : ∀ s, 0 < x s) (y : S → ℕ) : 0 < mono x y :=
  prod_pos fun s _ => pow_pos (hx s) _

/-- Complex balance, tested against an arbitrary function of complexes. -/
lemma Network.ComplexBalanced.sum_tgt_eq_sum_src {N : Network S R} {c : S → ℝ}
    (h : N.ComplexBalanced c) (g : (S → ℕ) → ℝ) :
    ∑ r, N.k r * mono c (N.src r) * g (N.tgt r) = ∑ r, N.k r * mono c (N.src r) * g (N.src r) := by
  classical
  set T : Finset (S → ℕ) := univ.image N.tgt ∪ univ.image N.src
  have h1 : ∑ r, N.k r * mono c (N.src r) * g (N.tgt r)
      = ∑ z ∈ T, ∑ r ∈ univ.filter (fun r => N.tgt r = z), N.k r * mono c (N.src r) * g (N.tgt r) :=
    (sum_fiberwise_of_maps_to (fun r _ => by simp [T]) _).symm
  have h2 : ∑ r, N.k r * mono c (N.src r) * g (N.src r)
      = ∑ z ∈ T, ∑ r ∈ univ.filter (fun r => N.src r = z), N.k r * mono c (N.src r) * g (N.src r) :=
    (sum_fiberwise_of_maps_to (fun r _ => by simp [T]) _).symm
  rw [h1, h2]
  refine sum_congr rfl fun z _ => ?_
  have e1 : ∑ r ∈ univ.filter (fun r => N.tgt r = z), N.k r * mono c (N.src r) * g (N.tgt r)
      = (∑ r ∈ univ.filter (fun r => N.tgt r = z), N.k r * mono c (N.src r)) * g z := by
    rw [sum_mul]; exact sum_congr rfl fun r hr => by rw [(mem_filter.mp hr).2]
  have e2 : ∑ r ∈ univ.filter (fun r => N.src r = z), N.k r * mono c (N.src r) * g (N.src r)
      = (∑ r ∈ univ.filter (fun r => N.src r = z), N.k r * mono c (N.src r)) * g z := by
    rw [sum_mul]; exact sum_congr rfl fun r hr => by rw [(mem_filter.mp hr).2]
  rw [e1, e2, h z]

/-- A complex-balanced point is an equilibrium of the mass-action ODE. -/
theorem Network.ComplexBalanced.rhs_eq_zero {N : Network S R} {c : S → ℝ}
    (h : N.ComplexBalanced c) (s : S) : N.rhs c s = 0 := by
  have := h.sum_tgt_eq_sum_src (fun z => (z s : ℝ))
  unfold Network.rhs
  simp only [mul_sub, sum_sub_distrib]
  linarith

/-- Scalar core: `a * (log b - log a) ≤ b - a` for `a, b > 0`. -/
lemma mul_log_sub_log_le {a b : ℝ} (ha : 0 < a) (hb : 0 < b) :
    a * (Real.log b - Real.log a) ≤ b - a := by
  have h := Real.log_le_sub_one_of_pos (div_pos hb ha)
  rw [Real.log_div hb.ne' ha.ne'] at h
  have := mul_le_mul_of_nonneg_left h ha.le
  have e : a * (b / a - 1) = b - a := by field_simp
  linarith

lemma mono_mul_div {x c : S → ℝ} (hc : ∀ s, 0 < c s) (y : S → ℕ) :
    mono x y = mono c y * mono (fun s => x s / c s) y := by
  unfold mono
  rw [← prod_mul_distrib]
  refine prod_congr rfl fun s _ => ?_
  rw [← mul_pow, mul_div_cancel₀ _ (hc s).ne']

lemma log_mono {u : S → ℝ} (hu : ∀ s, 0 < u s) (y : S → ℕ) :
    Real.log (mono u y) = ∑ s, (y s : ℝ) * Real.log (u s) := by
  unfold mono
  rw [Real.log_prod (fun s _ => (pow_pos (hu s) _).ne')]
  exact sum_congr rfl fun s _ => by rw [Real.log_pow]

/-- **Horn–Jackson dissipation inequality.** If `c > 0` is complex balanced then for every
positive state `x`, `⟨f(x), log (x / c)⟩ ≤ 0`. -/
theorem dissipation (N : Network S R) {c : S → ℝ} (hc : ∀ s, 0 < c s)
    (hcb : N.ComplexBalanced c) {x : S → ℝ} (hx : ∀ s, 0 < x s) :
    ∑ s, N.rhs x s * Real.log (x s / c s) ≤ 0 := by
  set w : S → ℝ := fun s => x s / c s with hw
  have hwpos : ∀ s, 0 < w s := fun s => div_pos (hx s) (hc s)
  set u : (S → ℕ) → ℝ := fun z => mono w z with hu
  have hupos : ∀ z, 0 < u z := fun z => mono_pos hwpos z
  -- rewrite the left side reaction by reaction
  have key : ∑ s, N.rhs x s * Real.log (x s / c s)
      = ∑ r, N.k r * mono c (N.src r) *
          (u (N.src r) * (Real.log (u (N.tgt r)) - Real.log (u (N.src r)))) := by
    unfold Network.rhs
    simp_rw [sum_mul]
    rw [sum_comm]
    refine sum_congr rfl fun r _ => ?_
    rw [hu]
    rw [log_mono hwpos, log_mono hwpos, ← sum_sub_distrib, mono_mul_div hc (N.src r), mul_sum,
      mul_sum]
    refine sum_congr rfl fun s _ => ?_
    ring
  rw [key]
  have bound : ∀ r, N.k r * mono c (N.src r) *
        (u (N.src r) * (Real.log (u (N.tgt r)) - Real.log (u (N.src r))))
      ≤ N.k r * mono c (N.src r) * u (N.tgt r) - N.k r * mono c (N.src r) * u (N.src r) := by
    intro r
    have hκ : 0 < N.k r * mono c (N.src r) := mul_pos (N.k_pos r) (mono_pos hc _)
    have := mul_le_mul_of_nonneg_left (mul_log_sub_log_le (hupos (N.src r)) (hupos (N.tgt r))) hκ.le
    linarith [this]
  calc _ ≤ ∑ r, (N.k r * mono c (N.src r) * u (N.tgt r) - N.k r * mono c (N.src r) * u (N.src r)) :=
        sum_le_sum fun r _ => bound r
    _ = 0 := by rw [sum_sub_distrib, hcb.sum_tgt_eq_sum_src u]; ring

/-- Pseudo-Helmholtz free energy relative to `c`. -/
noncomputable def freeEnergy (c x : S → ℝ) : ℝ :=
  ∑ s, (x s * (Real.log (x s) - Real.log (c s) - 1) + c s)

theorem freeEnergy_nonneg {c x : S → ℝ} (hc : ∀ s, 0 < c s) (hx : ∀ s, 0 < x s) :
    0 ≤ freeEnergy c x := by
  refine sum_nonneg fun s _ => ?_
  have := mul_log_sub_log_le (hx s) (hc s)
  nlinarith [this]

/-! ## Sanity check: the reversible isomerisation `A ⇌ B`

Species `0 = A`, `1 = B`; reaction `0 : A → B` (rate `k₁`), reaction `1 : B → A` (rate `k₂`). -/

/-- `A ⇌ B`. -/
def iso (k₁ k₂ : ℝ) (h₁ : 0 < k₁) (h₂ : 0 < k₂) : Network (Fin 2) (Fin 2) where
  src := ![![1, 0], ![0, 1]]
  tgt := ![![0, 1], ![1, 0]]
  k := ![k₁, k₂]
  k_pos := by intro r; fin_cases r <;> simpa

/-- The definitions unfold to the textbook ODE `A' = -k₁ A + k₂ B`, `B' = k₁ A - k₂ B`. -/
theorem iso_rhs (k₁ k₂ : ℝ) (h₁ : 0 < k₁) (h₂ : 0 < k₂) (x : Fin 2 → ℝ) :
    (iso k₁ k₂ h₁ h₂).rhs x 0 = -k₁ * x 0 + k₂ * x 1 ∧
    (iso k₁ k₂ h₁ h₂).rhs x 1 = k₁ * x 0 - k₂ * x 1 := by
  constructor <;> simp [Network.rhs, iso, mono, Fin.sum_univ_two, Fin.prod_univ_two] <;> ring

/-- `(A, B) = (k₂, k₁)` is complex balanced for `A ⇌ B`. -/
theorem iso_complexBalanced (k₁ k₂ : ℝ) (h₁ : 0 < k₁) (h₂ : 0 < k₂) :
    (iso k₁ k₂ h₁ h₂).ComplexBalanced ![k₂, k₁] := by
  classical
  intro z
  have m0 : mono ![k₂, k₁] (![1, 0] : Fin 2 → ℕ) = k₂ := by simp [mono, Fin.prod_univ_two]
  have m1 : mono ![k₂, k₁] (![0, 1] : Fin 2 → ℕ) = k₁ := by simp [mono, Fin.prod_univ_two]
  have hne : (![1, 0] : Fin 2 → ℕ) ≠ ![0, 1] := by decide
  rw [sum_filter, sum_filter, Fin.sum_univ_two, Fin.sum_univ_two]
  show (if (![0, 1] : Fin 2 → ℕ) = z then k₁ * mono ![k₂, k₁] ![1, 0] else 0)
        + (if (![1, 0] : Fin 2 → ℕ) = z then k₂ * mono ![k₂, k₁] ![0, 1] else 0)
      = (if (![1, 0] : Fin 2 → ℕ) = z then k₁ * mono ![k₂, k₁] ![1, 0] else 0)
        + (if (![0, 1] : Fin 2 → ℕ) = z then k₂ * mono ![k₂, k₁] ![0, 1] else 0)
  rw [m0, m1]
  split_ifs with a b <;>
    first | ring | contradiction | exact absurd (b.trans a.symm) hne

/-- Concrete instance of the dissipation inequality: for `A ⇌ B` and every positive state,
`(k₂ B - k₁ A) * (log (A / k₂) - log (B / k₁)) ≤ 0`. -/
theorem iso_dissipation (k₁ k₂ : ℝ) (h₁ : 0 < k₁) (h₂ : 0 < k₂) (a b : ℝ) (ha : 0 < a)
    (hb : 0 < b) :
    (k₂ * b - k₁ * a) * (Real.log (a / k₂) - Real.log (b / k₁)) ≤ 0 := by
  have hc : ∀ s : Fin 2, 0 < (![k₂, k₁] : Fin 2 → ℝ) s := by intro s; fin_cases s <;> simpa
  have hx : ∀ s : Fin 2, 0 < (![a, b] : Fin 2 → ℝ) s := by intro s; fin_cases s <;> simpa
  have := dissipation (iso k₁ k₂ h₁ h₂) hc (iso_complexBalanced k₁ k₂ h₁ h₂) hx
  obtain ⟨e0, e1⟩ := iso_rhs k₁ k₂ h₁ h₂ ![a, b]
  rw [Fin.sum_univ_two, e0, e1] at this
  simp at this
  linarith [this]

end CRN

#print axioms CRN.dissipation
#print axioms CRN.Network.ComplexBalanced.rhs_eq_zero
#print axioms CRN.freeEnergy_nonneg
#print axioms CRN.iso_dissipation
