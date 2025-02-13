% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fit.R
\name{mmrm}
\alias{mmrm}
\title{Fit an MMRM}
\usage{
mmrm(
  formula,
  data,
  weights = NULL,
  reml = TRUE,
  optimizer = "automatic",
  n_cores = 1L,
  accept_singular = TRUE
)
}
\arguments{
\item{formula}{(\code{formula})\cr the model formula, see details.}

\item{data}{(\code{data})\cr the data to be used for the model.}

\item{weights}{(\code{vector})\cr an optional vector of weights to be used in the fitting process.
Should be NULL or a numeric vector.}

\item{reml}{(\code{flag})\cr whether restricted maximum likelihood (REML) estimation is used,
otherwise maximum likelihood (ML) is used.}

\item{optimizer}{(\code{string})\cr optimizer to be used to generate the model.}

\item{n_cores}{(\code{count})\cr number of cores which could in principle be used for
parallel computations on Linux or Mac machines.}

\item{accept_singular}{(\code{flag})\cr whether singular design matrices are reduced
to full rank automatically and additional coefficient estimates will be missing.}
}
\value{
An \code{mmrm} object.
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}}

This is the main function fitting the MMRM.
}
\details{
The \code{formula} typically looks like:
\code{FEV1 ~ RACE + SEX + ARMCD * AVISIT + us(AVISIT | USUBJID)}
so specifies response and covariates as usual, and exactly one special term
defines which covariance structure is used and what are the visit and
subject variables.

The covariance structures in the formula can be found in \code{\link{covariance_types}}.

When setting \code{optimizer = "automatic"}, first the default optimizer
(\code{L-BFGS-B}) is used to fit the model. If that converges, this is returned.
If not, the other available optimizers from \code{\link[=refit_multiple_optimizers]{refit_multiple_optimizers()}} are
tried (in parallel if \code{n_cores} is set and not on Windows, use e.g. \code{\link[=free_cores]{free_cores()}}).
If none of the optimizers converge, then the function fails. Otherwise
the best fit is returned.
}
\note{
The \code{mmrm} object is also an \code{mmrm_fit} and an \code{mmrm_tmb} object,
therefore corresponding methods also work (see \code{\link{mmrm_tmb_methods}}).
In addition it contains the Jacobian information \code{jac_list} and the \code{call}.
Use of the package \code{emmeans} is supported, see \code{\link{emmeans_support}}.
}
\examples{
fit <- mmrm(
  formula = FEV1 ~ RACE + SEX + ARMCD * AVISIT + us(AVISIT | USUBJID),
  data = fev_data
)
}
