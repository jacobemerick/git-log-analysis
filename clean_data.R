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

