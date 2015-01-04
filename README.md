git-log-analysis
================

R Script to clean up and run basic analysis on git logs

## Introduction

This script can be used to clean up and run analysis on a git repo's history. You need to export the log in a specified format (see below) and then run this script using R. The data will then be accessible for analysis. I've included some basic examples `examples.R` of the type of stuff you can do with the data.

## Instructions

Once you have access to a repository (like, if you clone it to a server or whatever) just run this within the directory. I've only tested on a mac, so some changes may be needed depending on your environment.

```
git log --date=local --no-merges --shortstat\
        --pretty=format:"%h%x09%an%x09%ad%x09%sEOL" |\
        perl -pi -e 's/EOL\n/\t/g' > git.log
```

Then run `clean_data.R`. This will tidy up the data for any analysis desired.

