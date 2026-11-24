#!/bin/bash
# Keep-alive watcher: run as a tracked background task.  Checks the search every minute, restarts it
# if it died, stops early on a counterexample or when every job is finished.  Exits after LIMIT s.
cd "$(dirname "$0")"
LIMIT=${LIMIT:-6900}; T0=$(date +%s); W=/root/z4-run
while true; do
  if grep -qs COUNTEREXAMPLE $W/run.log; then echo "COUNTEREXAMPLE FOUND"; grep COUNTEREXAMPLE $W/run.log; break; fi
  if [ -f $W/run.log ] && [ "$(grep -oE 'n=[0-9]+ d=[0-9]+ (finished|already complete)' $W/run.log | awk '{print $1,$2}' | sort -u | wc -l)" -ge 12 ] && ! pgrep -f fibre_check.py >/dev/null; then echo "ALL JOBS FINISHED"; break; fi
  if ! pgrep -f run_all.sh >/dev/null; then echo "$(date -u +%T) runner not running: restarting"; PUSH_EVERY=300 nohup ./run_all.sh >> /home/user/z4-run.driver.log 2>&1 & fi
  [ $(( $(date +%s) - T0 )) -ge $LIMIT ] && { echo "cycle limit reached"; break; }
  sleep 60
done
python3 - <<'P'
import json,glob
for f in sorted(glob.glob('/root/z4-run/results_n*_d*.jsonl')):
    r=[json.loads(l) for l in open(f) if l.strip()]
    ch=[x for x in r if isinstance(x.get('chunk'),int)]; end=[x for x in r if x.get('chunk')=='END']
    if ch: print(f"n={ch[0]['n']} d={ch[0]['d']} chunks={len(ch)}/{end[0]['chunks'] if end else '?'} disconnected={sum(len(x['disconnected']) for x in ch)}")
P
cd /home/user/proofs-archive && git log -1 --format='last checkpoint: %h %cd' --date=format:%T
