/-
# Machine-checked soundness of the 4ti2 Markov bases for group-based models on the claw tree K_{1,3}

`q a b c g₁ g₂ g₃ = a g₁ * b g₂ * c g₃` is the Fourier-coordinate parametrisation of the general
group-based model for `G = ℤ/m` on the three-leaf claw tree (only triples with `g₁+g₂+g₃ = 0`
occur).  Each theorem below is one element of the minimal Markov basis computed by 4ti2
(`phylo/ss.py`), restated as a polynomial identity valid for *all* edge parameters in *any*
commutative ring, i.e. a phylogenetic invariant.  Lean checks soundness (each binomial vanishes on
the model); minimality/completeness of the basis is 4ti2's computation, not checked here.
This file is auto-generated.
-/
import Mathlib

namespace Phylo
variable {R : Type*} [CommRing R]

/-- Fourier coordinate of the claw-tree model. -/
def q (a b c : ℕ → R) (g₁ g₂ g₃ : ℕ) : R := a g₁ * b g₂ * c g₃

variable (a b c : ℕ → R)

/-! ## G = ℤ/3: the two cubics generating the ideal -/

theorem inv3_0 : q a b c 0 0 0 * q a b c 1 1 1 * q a b c 2 2 2 = q a b c 0 1 2 * q a b c 1 2 0 * q a b c 2 0 1 := by
  simp only [q]; ring

theorem inv3_1 : q a b c 0 0 0 * q a b c 1 1 1 * q a b c 2 2 2 = q a b c 0 2 1 * q a b c 1 0 2 * q a b c 2 1 0 := by
  simp only [q]; ring

/-! ## G = ℤ/4: 16 cubics and 6 quartics -/

theorem inv4_0 : q a b c 1 2 1 * q a b c 2 3 3 * q a b c 3 1 0 = q a b c 1 3 0 * q a b c 2 1 1 * q a b c 3 2 3 := by
  simp only [q]; ring

theorem inv4_1 : q a b c 1 1 2 * q a b c 2 2 0 * q a b c 3 0 1 = q a b c 1 2 1 * q a b c 2 0 2 * q a b c 3 1 0 := by
  simp only [q]; ring

theorem inv4_2 : q a b c 1 0 3 * q a b c 2 1 1 * q a b c 3 3 2 = q a b c 1 1 2 * q a b c 2 3 3 * q a b c 3 0 1 := by
  simp only [q]; ring

theorem inv4_3 : q a b c 1 0 3 * q a b c 1 2 1 * q a b c 3 1 0 * q a b c 3 3 2 = q a b c 1 1 2 * q a b c 1 3 0 * q a b c 3 0 1 * q a b c 3 2 3 := by
  simp only [q]; ring

theorem inv4_4 : q a b c 1 0 3 * q a b c 2 2 0 * q a b c 3 3 2 = q a b c 1 3 0 * q a b c 2 0 2 * q a b c 3 2 3 := by
  simp only [q]; ring

theorem inv4_5 : q a b c 0 2 2 * q a b c 1 3 0 * q a b c 2 1 1 = q a b c 0 3 1 * q a b c 1 1 2 * q a b c 2 2 0 := by
  simp only [q]; ring

theorem inv4_6 : q a b c 0 2 2 * q a b c 2 3 3 * q a b c 3 0 1 = q a b c 0 3 1 * q a b c 2 0 2 * q a b c 3 2 3 := by
  simp only [q]; ring

theorem inv4_7 : q a b c 0 1 3 * q a b c 1 2 1 * q a b c 2 0 2 = q a b c 0 2 2 * q a b c 1 0 3 * q a b c 2 1 1 := by
  simp only [q]; ring

theorem inv4_8 : q a b c 0 1 3 * q a b c 2 2 0 * q a b c 3 3 2 = q a b c 0 2 2 * q a b c 2 3 3 * q a b c 3 1 0 := by
  simp only [q]; ring

theorem inv4_9 : q a b c 0 1 3 * q a b c 1 3 0 * q a b c 3 0 1 = q a b c 0 3 1 * q a b c 1 0 3 * q a b c 3 1 0 := by
  simp only [q]; ring

theorem inv4_10 : q a b c 0 1 3 * q a b c 1 2 1 * q a b c 2 3 3 * q a b c 3 0 1 = q a b c 0 3 1 * q a b c 1 0 3 * q a b c 2 1 1 * q a b c 3 2 3 := by
  simp only [q]; ring

theorem inv4_11 : q a b c 0 1 3 * q a b c 1 3 0 * q a b c 2 1 1 * q a b c 3 3 2 = q a b c 0 3 1 * q a b c 1 1 2 * q a b c 2 3 3 * q a b c 3 1 0 := by
  simp only [q]; ring

theorem inv4_12 : q a b c 0 1 3 * q a b c 1 2 1 * q a b c 3 3 2 = q a b c 0 3 1 * q a b c 1 1 2 * q a b c 3 2 3 := by
  simp only [q]; ring

theorem inv4_13 : q a b c 0 0 0 * q a b c 2 1 1 * q a b c 3 2 3 = q a b c 0 1 3 * q a b c 2 2 0 * q a b c 3 0 1 := by
  simp only [q]; ring

theorem inv4_14 : q a b c 0 0 0 * q a b c 1 1 2 * q a b c 2 3 3 = q a b c 0 1 3 * q a b c 1 3 0 * q a b c 2 0 2 := by
  simp only [q]; ring

theorem inv4_15 : q a b c 0 0 0 * q a b c 0 2 2 * q a b c 2 1 1 * q a b c 2 3 3 = q a b c 0 1 3 * q a b c 0 3 1 * q a b c 2 0 2 * q a b c 2 2 0 := by
  simp only [q]; ring

theorem inv4_16 : q a b c 0 0 0 * q a b c 1 2 1 * q a b c 2 0 2 * q a b c 3 2 3 = q a b c 0 2 2 * q a b c 1 0 3 * q a b c 2 2 0 * q a b c 3 0 1 := by
  simp only [q]; ring

theorem inv4_17 : q a b c 0 0 0 * q a b c 1 1 2 * q a b c 3 2 3 = q a b c 0 2 2 * q a b c 1 0 3 * q a b c 3 1 0 := by
  simp only [q]; ring

theorem inv4_18 : q a b c 0 0 0 * q a b c 1 2 1 * q a b c 3 3 2 = q a b c 0 2 2 * q a b c 1 3 0 * q a b c 3 0 1 := by
  simp only [q]; ring

theorem inv4_19 : q a b c 0 0 0 * q a b c 1 1 2 * q a b c 2 2 0 * q a b c 3 3 2 = q a b c 0 2 2 * q a b c 1 3 0 * q a b c 2 0 2 * q a b c 3 1 0 := by
  simp only [q]; ring

theorem inv4_20 : q a b c 0 0 0 * q a b c 1 2 1 * q a b c 2 3 3 = q a b c 0 3 1 * q a b c 1 0 3 * q a b c 2 2 0 := by
  simp only [q]; ring

theorem inv4_21 : q a b c 0 0 0 * q a b c 2 1 1 * q a b c 3 3 2 = q a b c 0 3 1 * q a b c 2 0 2 * q a b c 3 1 0 := by
  simp only [q]; ring

end Phylo

#print axioms Phylo.inv3_0
#print axioms Phylo.inv4_21
