# Resumable search for a degree > 4 generator of the Z/4 claw-tree ideal

`fibre_check.py n d` checks every fibre of degree `d` on `n` leaves (up to symmetry) for
connectedness and appends one JSON line per finished chunk to `results_n{n}_d{d}.jsonl`.
`run_all.sh` runs the job list on 3 workers and commits and pushes the logs every 5 minutes.

**To resume after a restart:** clone this branch and run `nohup ./run_all.sh &` in this directory (results are staged in `~/z4-run` and copied here at each checkpoint).
Finished chunks are read from the logs and skipped. `STATUS.md` is regenerated at every checkpoint.

What a clean result means: no minimal generator of that exact degree on that number of leaves.
It does not bound higher degrees, so it is evidence for the bound, not a proof of it.
