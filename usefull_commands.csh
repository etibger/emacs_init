# 1) list every running job for current user the format is by default:
# JOBID    USER    STAT  QUEUE      FROM_HOST   EXEC_HOST   JOB_NAME   SUBMIT_TIME
# 84681615 tibger0 RUN   PD         bc-a10-1-16 bc-c3-1-15  *ng-weekly Dec  1 08:57
# 2) get the job id (first numerical value followved by a space)
# 4) kill the jobs
bjobs -noheader | sed 's/\([0-9]*\) .*/\1/' | xargs bkill
