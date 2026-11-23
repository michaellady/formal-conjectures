/-
# A sharp lower bound for the Thomson (Coulomb) energy, tight exactly at regular simplices

For `N ≥ 2` distinct unit vectors `x₁, …, x_N` in any real inner product space,

  `∑_{i ≠ j} 1 / ‖xᵢ - xⱼ‖  ≥  N (N - 1) / √(2N / (N - 1))`.

(The sum is over ordered pairs, i.e. twice the physical Coulomb energy.)
Equality holds when the points are centred (`∑ xᵢ = 0`) and pairwise equidistant, i.e. for the
regular simplex.  In `ℝ³` such configurations exist for `N = 2, 3, 4` (antipodal pair, equilateral
triangle on a great circle, regular tetrahedron), so this single inequality certifies the global
minimum of the Thomson problem for `N = 2, 3, 4`.

Proof sketch.
1. `∑_{i,j} ‖xᵢ - xⱼ‖² = 2N² - 2‖∑ xᵢ‖² ≤ 2N²` (expand the square; the points are unit vectors).
2. Tangent-line trick for the convex function `s ↦ s^(-1/2)`: for all `d, t > 0`
   `1/d = 3/(2t) - d²/(2t³) + (d - t)² (d + 2t) / (2 t³ d) ≥ 3/(2t) - d²/(2t³)`.
3. Sum step 2 over the `N(N-1)` ordered pairs and insert step 1 with `t² = 2N/(N-1)`.
-/
import Mathlib

open Finset

namespace Thomson

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] {N : ℕ}

/-- Coulomb energy summed over ordered pairs `i ≠ j` (twice the physical energy). -/
noncomputable def energy2 (x : Fin N → E) : ℝ :=
  ∑ i, ∑ j, if i = j then 0 else 1 / ‖x i - x j‖

/-- Step 1: the sum of squared chord lengths of points on the unit sphere. -/
lemma sum_sq_dist (x : Fin N → E) (h : ∀ i, ‖x i‖ = 1) :
    ∑ i, ∑ j, ‖x i - x j‖ ^ 2 = 2 * (N : ℝ) ^ 2 - 2 * ‖∑ i, x i‖ ^ 2 := by
  have e : ∀ i j, ‖x i - x j‖ ^ 2 = 2 - 2 * inner ℝ (x i) (x j) := by
    intro i j
    rw [norm_sub_sq_real, h i, h j]; ring
  simp_rw [e, sum_sub_distrib, ← mul_sum]
  have : ∑ i, ∑ j, inner ℝ (x i) (x j) = ‖∑ i, x i‖ ^ 2 := by
    rw [← real_inner_self_eq_norm_sq, sum_inner]
    exact sum_congr rfl fun i _ => by rw [inner_sum]
  rw [this]
  simp
  ring

/-- Step 2: tangent-line bound for `d ↦ 1/d` viewed as a function of `d²`. -/
lemma one_div_ge {d t : ℝ} (hd : 0 < d) (ht : 0 < t) :
    3 / (2 * t) - d ^ 2 / (2 * t ^ 3) ≤ 1 / d := by
  have key : 1 / d = 3 / (2 * t) - d ^ 2 / (2 * t ^ 3)
      + (d - t) ^ 2 * (d + 2 * t) / (2 * t ^ 3 * d) := by
    field_simp; ring
  have : 0 ≤ (d - t) ^ 2 * (d + 2 * t) / (2 * t ^ 3 * d) := by positivity
  linarith

/-- **Simplex bound for the Thomson energy.** -/
theorem energy2_ge (hN : 2 ≤ N) (x : Fin N → E) (hunit : ∀ i, ‖x i‖ = 1)
    (hinj : Function.Injective x) :
    (N : ℝ) * (N - 1) / Real.sqrt (2 * N / (N - 1)) ≤ energy2 x := by
  have hN' : (2 : ℝ) ≤ N := by exact_mod_cast hN
  set t : ℝ := Real.sqrt (2 * N / (N - 1)) with ht_def
  have hpos : (0 : ℝ) < 2 * N / (N - 1) := by apply div_pos <;> linarith
  have ht : 0 < t := Real.sqrt_pos.mpr hpos
  have ht2 : t ^ 2 = 2 * N / (N - 1) := Real.sq_sqrt hpos.le
  -- termwise bound, valid on and off the diagonal
  have term : ∀ i j, 3 / (2 * t) - (if i = j then 3 / (2 * t) else 0)
        - ‖x i - x j‖ ^ 2 / (2 * t ^ 3) ≤ (if i = j then 0 else 1 / ‖x i - x j‖) := by
    intro i j
    by_cases hij : i = j
    · simp [hij]
    · have hd : 0 < ‖x i - x j‖ := norm_pos_iff.mpr (sub_ne_zero.mpr fun h => hij (hinj h))
      simpa [hij] using one_div_ge hd ht
  have hsum : ∑ i : Fin N, ∑ j : Fin N, (3 / (2 * t) - (if i = j then 3 / (2 * t) else 0)
        - ‖x i - x j‖ ^ 2 / (2 * t ^ 3)) ≤ energy2 x :=
    sum_le_sum fun i _ => sum_le_sum fun j _ => term i j
  have heval : ∑ i : Fin N, ∑ j : Fin N, (3 / (2 * t) - (if i = j then 3 / (2 * t) else 0)
        - ‖x i - x j‖ ^ 2 / (2 * t ^ 3))
      = (N : ℝ) ^ 2 * (3 / (2 * t)) - N * (3 / (2 * t))
        - (2 * (N : ℝ) ^ 2 - 2 * ‖∑ i, x i‖ ^ 2) / (2 * t ^ 3) := by
    simp_rw [sum_sub_distrib, ← sum_div, sum_sq_dist x hunit]
    simp
    ring
  rw [heval] at hsum
  have ht3 : t ^ 3 = t * (2 * N / (N - 1)) := by rw [← ht2]; ring
  have hS : 0 ≤ ‖∑ i, x i‖ ^ 2 := by positivity
  have h1 : (2 * (N : ℝ) ^ 2 - 2 * ‖∑ i, x i‖ ^ 2) / (2 * t ^ 3) ≤ 2 * (N : ℝ) ^ 2 / (2 * t ^ 3) := by
    apply div_le_div_of_nonneg_right _ (by positivity); linarith
  have h2 : 2 * (N : ℝ) ^ 2 / (2 * t ^ 3) = N * (N - 1) / (2 * t) := by
    rw [ht3]
    have : (N : ℝ) - 1 ≠ 0 := by linarith
    have : (N : ℝ) ≠ 0 := by linarith
    field_simp
  have h3 : (N : ℝ) * (N - 1) / t
      = (N : ℝ) ^ 2 * (3 / (2 * t)) - N * (3 / (2 * t)) - N * (N - 1) / (2 * t) := by
    field_simp; ring
  linarith

/-- Equality case: a centred, pairwise equidistant configuration attains the bound. -/
theorem energy2_eq_of_centred_equidistant (hN : 2 ≤ N) (x : Fin N → E) (hunit : ∀ i, ‖x i‖ = 1)
    (hcentre : ∑ i, x i = 0) {d : ℝ} (hd : 0 < d) (hdist : ∀ i j, i ≠ j → ‖x i - x j‖ = d) :
    energy2 x = (N : ℝ) * (N - 1) / Real.sqrt (2 * N / (N - 1)) := by
  have hN' : (2 : ℝ) ≤ N := by exact_mod_cast hN
  have hsq := sum_sq_dist x hunit
  rw [hcentre, norm_zero] at hsq
  have e1 : ∑ i : Fin N, ∑ j : Fin N, ‖x i - x j‖ ^ 2
      = ∑ i : Fin N, ∑ j : Fin N, (d ^ 2 - if i = j then d ^ 2 else 0) := by
    refine sum_congr rfl fun i _ => sum_congr rfl fun j _ => ?_
    by_cases hij : i = j
    · simp [hij]
    · simp [hij, hdist i j hij]
  have e2 : ∑ i : Fin N, ∑ j : Fin N, (d ^ 2 - if i = j then d ^ 2 else 0)
      = (N : ℝ) ^ 2 * d ^ 2 - N * d ^ 2 := by
    simp_rw [sum_sub_distrib]; simp; ring
  have hd2 : d ^ 2 = 2 * N / (N - 1) := by
    have : (N : ℝ) * (N - 1) * d ^ 2 = 2 * (N : ℝ) ^ 2 := by
      rw [e1, e2] at hsq; linear_combination hsq
    have h1 : (N : ℝ) - 1 ≠ 0 := by linarith
    have h0 : (N : ℝ) ≠ 0 := by linarith
    field_simp
    nlinarith [this]
  have hsqrt : Real.sqrt (2 * N / (N - 1)) = d := by
    rw [← hd2]; exact Real.sqrt_sq hd.le
  rw [hsqrt]
  have e3 : energy2 x = ∑ i : Fin N, ∑ j : Fin N, (1 / d - if i = j then 1 / d else 0) := by
    refine sum_congr rfl fun i _ => sum_congr rfl fun j _ => ?_
    by_cases hij : i = j
    · simp [hij]
    · simp [hij, hdist i j hij]
  rw [e3]
  simp_rw [sum_sub_distrib]; simp; field_simp

/-! ## Sanity checks -/

/-- `N = 2`: two distinct points on the unit sphere have Coulomb energy at least `1/2`. -/
theorem two_points (a b : E) (ha : ‖a‖ = 1) (hb : ‖b‖ = 1) (hab : a ≠ b) :
    1 / 2 ≤ 1 / ‖a - b‖ := by
  have hinj : Function.Injective ![a, b] := by
    intro i j h
    fin_cases i <;> fin_cases j <;> simp_all
  have hunit : ∀ i, ‖(![a, b] : Fin 2 → E) i‖ = 1 := by intro i; fin_cases i <;> simpa
  have h := energy2_ge (le_refl 2) ![a, b] hunit hinj
  have e : Real.sqrt (2 * ((2 : ℕ) : ℝ) / (((2 : ℕ) : ℝ) - 1)) = 2 := by
    rw [show (2 * ((2 : ℕ) : ℝ) / (((2 : ℕ) : ℝ) - 1)) = 2 ^ 2 by norm_num]
    exact Real.sqrt_sq (by norm_num)
  rw [e] at h
  simp [energy2, Fin.sum_univ_two, norm_sub_rev b a] at h
  have : (1 : ℝ) / ‖a - b‖ = ‖a - b‖⁻¹ := one_div _
  linarith

/-- …and the antipodal pair attains it. -/
theorem antipodal (a : E) (ha : ‖a‖ = 1) : 1 / ‖a - (-a)‖ = 1 / 2 := by
  rw [sub_neg_eq_add, ← two_smul ℝ a, norm_smul, ha]; norm_num

end Thomson

#print axioms Thomson.energy2_ge
#print axioms Thomson.energy2_eq_of_centred_equidistant
#print axioms Thomson.two_points
#print axioms Thomson.antipodal
