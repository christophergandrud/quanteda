% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plots.R
\name{textplot_scale1d}
\alias{textplot_scale1d}
\title{plot a fitted wordfish model}
\usage{
textplot_scale1d(x, margin = c("documents", "features"), doclabels = NULL,
  sort = TRUE, mar_left = 8, highlighted = NULL, alpha = 0.5, ...)
}
\arguments{
\item{x}{the fitted \link{textmodel_wordfish} object to be plotted}

\item{margin}{\code{"documents"} to plot document scores theta (the default)
or \code{"features"} to plot psi against beta parameters}

\item{doclabels}{a vector of names for document. If left NULL (the default), 
ordinary document names will be used.}

\item{sort}{if \code{TRUE} (the default), order points from low to high score. If a 
vector, order according to these values from low to high. Only applies when
\code{margin = "documents"}}

\item{mar_left}{an overridden left margin, passed to \code{par} (default 
8.1). This overrides R's default 4.1, which is typically too cramped for 
document names.}

\item{highlighted}{a vector of feature names to draw attention to in a feature 
plot. Only applies if \code{margin = "features"}.}

\item{alpha}{A number between 0 and 1 (default 0.5) representing the level of
alpha transparency used to overplot feature names in a feature plot. Only 
applies if \code{margin = "features"}.}

\item{...}{additional arguments passed to \code{\link{plot}}}
}
\description{
Plot a fitted wordfish model, either as an ideal point-style plot (theta plus
confidence interval on the x-axis, document labels on the y) with optional 
renaming and sorting, or as a plot of estimated feature-level parameters
(beta on the x, psi on the y, feature names over-plotted with alpha
transparency, optionally some highlighted) as in Slapin and Proksch, 2008.
}
\examples{
postwar <- dfm_trim(dfm(data_corpus_inaugural[41:57]), min_count = 5, min_docfreq = 2)
mod <- textmodel(postwar, model = "wordfish")
textplot_scale1d(mod, sort = FALSE)
textplot_scale1d(mod, sort = TRUE)
textplot_scale1d(mod, margin = "features", 
                 highlighted = c("government", "countries", "children", 
                             "the", "nuclear", "federal"))
}
\author{
Adam Obeng
}
\references{
Jonathan Slapin and Sven-Oliver Proksch.  2008. "A Scaling Model 
  for Estimating Time-Series Party Positions from Texts." \emph{American 
  Journal of Political Science} 52(3):705-772.
}

