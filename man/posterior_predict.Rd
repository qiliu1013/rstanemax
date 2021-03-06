% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/posterior_predict.R
\name{posterior_predict}
\alias{posterior_predict}
\alias{posterior_predict.stanemax}
\alias{posterior_predict_quantile}
\title{Outcome prediction from posterior distribution of parameters}
\usage{
\method{posterior_predict}{stanemax}(object, newdata = NULL,
  returnType = c("matrix", "dataframe", "tibble"), ...)

posterior_predict_quantile(object, newdata = NULL)
}
\arguments{
\item{object}{A `stanemax` class object}

\item{newdata}{An optional data frame with a column named `exposure` or a numeric vector}

\item{returnType}{An optional string specifying the type of return object.}

\item{...}{Additional rguments passed to methods.}
}
\value{
An object that contain predicted response with posterior distribution of parameters.
The default is a matrix containing predicted response.
Each row of the matrix is a vector of predictions generated using a single draw of the model parameters from the posterior distribution.

If either __dataframe__ or __tibble__ is specified, the function returns a data frame or tibble object in a long format -
each row is a prediction generated using a single draw of the model parameters and a corresponding exposure.

Two types of predictions are generated with this function.
__respHat__ corresponds to the prediction without considering residual variability and is intended to provide credible interval of "mean" response.
__response__ include residual variability in its calculation, therefore the range represents prediction interval of observed response.

The return object also contains exposure and parameter values used for calculation.
}
\description{
Compute outcome predictions using posterior samples.
Exposure data for prediction can be either original data used for model fit or new data.
}
\details{
Run \code{vignette("emaxmodel", package = "rstanemax")} to see
how you can use the posterior prediction for plotting estimated Emax curve.
}
