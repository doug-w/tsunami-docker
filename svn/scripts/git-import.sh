#!/bin/bash -x

cd /git
git svn fetch
git svn rebase
git push origin master
git push gitlab master
