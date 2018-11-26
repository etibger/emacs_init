# Kill all bjobs
# 1) list every running job for current user the format is by default:
# JOBID    USER    STAT  QUEUE      FROM_HOST   EXEC_HOST   JOB_NAME   SUBMIT_TIME
# 84681615 tibger0 RUN   PD         bc-a10-1-16 bc-c3-1-15  *ng-weekly Dec  1 08:57
# 2) get the job id (first numerical value followved by a space)
# 3) kill the jobs
bjobs -noheader | sed 's/\([0-9]*\) .*/\1/' | xargs bkill

# Remove every file with specific name, modified before some date
# 1) list detailed in current directory
# 2) exclude some instance based on date
# 3) serach for the files to proces
# 4) get the name only
# 5) process the file (delet it)
ll | grep -v " Dec " | grep xsession | sed 's/.*\(\.xse.*\)/\1/' | xargs rm -v

# sed in all of the non binary file
# 1) find file types in cwd
# 2) grep for first match of every character, -I bynary-files=without-match
# 3) do the actual replacement
#   a) do it inplace
#   b) do it globally (multiple times per line if necessary 
find . -type f -exec grep -Iq . {} ";" -exec sed -i 's/ahb5_to_apb_sync/ahb5_to_apb_ll_sync/g' {} \;


# find files newer than foo, not ending wiht pyc
ll `find ./ -maxdepth 1 -type f -not -name "*.pyc" -newer /tmp/foo`

# parse csv with awk csv is separated with "," and print first and sixth column
awk -F , '{print $1 "|" $6}' hxb/uvm/all_merged_ccov.csv 

#meret
du -k --max-depth=1 --exclude .snapshot | sort -n
