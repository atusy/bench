% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mark.R
\name{summary.bench_mark}
\alias{summary.bench_mark}
\title{Summarize \link[bench:mark]{bench::mark} results.}
\usage{
\method{summary}{bench_mark}(object, filter_gc = TRUE,
  relative = FALSE, ...)
}
\arguments{
\item{object}{\link{bench_mark} object to summarize.}

\item{filter_gc}{If \code{TRUE} remove iterations that contained at least one
garbage collection before summarizing. If \code{TRUE} but an expression had
a garbage collection in every iteration, filtering is disabled, with a warning.}

\item{relative}{If \code{TRUE} all summaries are computed relative to the minimum
execution time rather than absolute time.}

\item{...}{Additional arguments ignored.}
}
\value{
A \link[tibble:tibble]{tibble} with the additional summary columns.
The following summary columns are computed
\itemize{
\item \code{min} - \code{bench_time} The minimum execution time.
\item \code{mean} - \code{bench_time} The arithmetic mean of execution time
\item \code{median} - \code{bench_time} The sample median of execution time.
\item \code{max} - \code{bench_time} The maximum execution time.
\item \code{mem_alloc} - \code{bench_bytes} Total amount of memory allocated by running the expression.
\item \code{itr/sec} - \code{integer} The estimated number of executions performed per second.
\item \code{n_itr} - \code{integer} Total number of iterations after filtering
garbage collections (if \code{filter_gc == TRUE}).
\item \code{n_gc} - \code{integer} Total number of garbage collections performed over all runs.
}
}
\description{
Summarize \link[bench:mark]{bench::mark} results.
}
\details{
If \code{filter_gc == TRUE} (the default) runs that contain a garbage
collection will be removed before summarizing. This is most useful for fast
expressions when the majority of runs do not contain a gc. Call
\code{summary(filter_gc = FALSE)} if you would like to compute summaries \emph{with}
these times, such as expressions with lots of allocations when all or most
runs contain a gc.
}
\examples{
dat <- data.frame(x = runif(10000, 1, 1000), y=runif(10000, 1, 1000))

# `bench::mark()` implicitly calls summary() automatically
results <- bench::mark(
  dat[dat$x > 500, ],
  dat[which(dat$x > 500), ],
  subset(dat, x > 500))

# However you can also do so explicitly to filter gc differently.
summary(results, filter_gc = FALSE)

# Or output relative times
summary(results, relative = TRUE)
}
