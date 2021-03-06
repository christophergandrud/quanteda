% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tokens_lookup.R
\name{tokens_lookup}
\alias{tokens_lookup}
\title{apply a dictionary to a tokens object}
\usage{
tokens_lookup(x, dictionary, valuetype = c("glob", "regex", "fixed"),
  case_insensitive = TRUE, capkeys = FALSE, concatenator = " ",
  verbose = FALSE)
}
\arguments{
\item{x}{tokens object to which dictionary or thesaurus will be supplied}

\item{dictionary}{the \link{dictionary}-class object that will be applied to 
\code{x}}

\item{valuetype}{how to interpret keyword expressions: \code{"glob"} for 
"glob"-style wildcard expressions; \code{"regex"} for regular expressions;
or \code{"fixed"} for exact matching. See \link{valuetype} for details.}

\item{case_insensitive}{ignore the case of dictionary values if \code{TRUE} 
uppercase to distinguish them from other features}

\item{capkeys}{if TRUE, convert dictionary keys to uppercase to distinguish 
them from other features}

\item{concatenator}{a charactor that connect words in multi-words entries}

\item{verbose}{print status messages if \code{TRUE}}
}
\description{
Convert tokens into equivalence classes defined by values of a dictionary 
object.
}
\examples{
toks <- tokens(data_corpus_inaugural)
dict <- dictionary(list(country = "united states", 
                   law=c('law*', 'constitution'), 
                   freedom=c('*', 'libert*')))
dfm(tokens_lookup(toks, dict, 'glob', verbose = TRUE))

dict_fix <- dictionary(list(country = "united states", 
                       law = c('law', 'constitution'), 
                       freedom = c('freedom', 'liberty'))) 
dfm(applyDictionary(toks, dict_fix, valuetype='fixed'))
dfm(tokens_lookup(toks, dict_fix, valuetype='fixed'))
}

