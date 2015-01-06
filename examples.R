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

