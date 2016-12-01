alias a "alias"
a ll 'ls -la'
a .. 'cd ..'
a ... 'cd ../../'
a ssv 'find . -name \*.sv -type f | xargs grep -wnHr --color=auto -C 3 \!:1'
a ssh 'find . -name \*.svh -type f | xargs grep -wnHr --color=auto -C 3 \!:1'
a ssvh 'find . -name "*.sv" -o -name "*.svh" -type f | xargs grep -wnHr --color=auto -C 3 \!:1'
a sv 'find . -name \*.v -type f | xargs grep -wnHr --color=auto -C 3 \!:1'
a s 'find . -type f | xargs grep -wnHr --color=auto -C 3 \!:1'

a ml 'module load'

#GIT
a gtk "gitk --all &"
a gcl "git clean -df"
a gst "git st"
a gstu "git st -uno"
a gco "git co"
a gf "git fetch"
a gpl "git pull"
a gps "git push"
a gb "git branch"
a gbm "git co master"
