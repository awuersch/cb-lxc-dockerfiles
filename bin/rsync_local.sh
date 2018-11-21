#! /bin/bash

set -euf -o pipefail

ETCDIR=$HOME/etc
LOGDIR=$HOME/log

TMPDIR=$(mktemp -d)
trap 'rm -rf $TMPDIR' INT QUIT EXIT

# generate backup dirs ("sort -u" removes duplicate mentions)
while read f
do
  # get path to backup file or backup dir
  echo "${f%/*}"
done < $ETCDIR/rsync_files.txt | sort -u > $TMPDIR/rsync_dirs.txt

# home:
# REMOTE=node-3
# USER=root
# ROOTDIR=/mnt/windows/bkup/rsync

REMOTE=rg1.test.tony.wuersch.name
USER=bkup
TARGET=$USER@$REMOTE
ROOTDIR=bkup/rsync

for n in 1 2 3 4
do
  # create paths
  # source=node-$n
  source=ds${n}.tony.wuersch.name
  prefix=$ROOTDIR/$source

  dirs="$(tr '\n' ' ' < $TMPDIR/rsync_dirs.txt)"
  test="[[ -d \\\$d ]]"
  cmd="mkdir -p ${prefix}\\\$d"
  expr="for d in $dirs; do $test && $cmd; done"

  echo ssh -n $TARGET bash -c \""$expr"\"
  ssh -n $TARGET bash -c \""$expr"\"

  # do backups
  while read f
  do
    test="[[ -f $f || -d $f ]]"
    cmd="rsync -avze ssh $f ${TARGET}:${prefix}${f%/*}"
    expr="$test && $cmd"

    echo ""
    echo ssh -n $source bash -c \""$expr"\"
    ssh -n $source bash -c \""$expr"\" || true
  done < $ETCDIR/rsync_files.txt
done > $LOGDIR/rsync.$(date +%s).out 2>&1
