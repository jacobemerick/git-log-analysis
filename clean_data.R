#loads up a bunch of git log data into R and tidies things up
#assumes that a file 'git.log' exists that has been setup from a bash script
#see more information in README.md

#load tab-delimited data into R
log <- read.delim(
    file = 'git.log',
    sep = "\t",
    col.names = c('commit', 'author', 'time', 'message', 'effect'),
    stringsAsFactors = FALSE
)

#format datetime into POSIX
log$time <- strptime(log$time, format = '%a %b %e %H:%M:%S %Y')

#empty columns for hydration
log$files_changed <- numeric(nrow(log))
log$insertions <- numeric(nrow(log))
log$deletions <- numeric(nrow(log))

#loop through effect column and parse out desired data
for (row in 1:nrow(log)) {
    log$files_changed[row] <- regmatches(
        log$effect[row],
        regexec('([0-9]+) files? changed', log$effect[row])
    )[[1]][2];
    log$insertions[row] <- regmatches(
        log$effect[row],
        regexec('([0-9]+) insertions?', log$effect[row])
    )[[1]][2];
    log$deletions[row] <- regmatches(
        log$effect[row],
        regexec('([0-9]+) deletions?', log$effect[row])
    )[[1]][2];
}
rm(row)

#cast numeric rows to numeric for reals
log$files_changed <- as.numeric(log$files_changed)
log$insertions <- as.numeric(log$insertions)
log$deletions <- as.numeric(log$deletions)

#only keep the columns we need
log <- log[, c(
    'commit',
    'author',
    'time',
    'message',
    'files_changed',
    'insertions',
    'deletions'
)]

