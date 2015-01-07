#examples of analysis that can be done on tidy git data
#depends on data being formatted from clean_data.R

#limit to 2014 data
log2014 <- log[
    format(log$time, '%Y') == '2014',
    c('author', 'insertions', 'deletions')
]

#output breakdown of changes by author
aggregate(insertions ~ author, log2014, sum)
aggregate(deletions ~ author, log2014, sum)


#or, for something completely different, a graph

#limit to 2014 data
log2014month <- log[
    format(log$time, '%Y') == '2014',
    c('commit', 'author', 'time')
]
#add column for month/year aggregation
log2014month$short_time <- strftime(
    log2014month$time,
    format = '%Y/%m'
)
#aggregate commits by author by month
log2014month <- aggregate(
    commit ~ short_time + author,
    log2014month,
    length
)
#constrain result to at least five commits per month
log2014month <- log2014month[
    log2014month$commit >= 5,
]

#graph the result using ggplot
ggplot(log2014month, aes(short_time, commit)) +
    geom_point(aes(color = author))

