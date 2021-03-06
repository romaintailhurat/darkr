% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/java_utils.R
\name{map_of}
\alias{map_of}
\title{Create a \code{Map} from a vector of arguments to the \code{of} static method.
Example:
map_of(c("name", "Hadrien"))
map_of(row_to_map_args(c("NAME", "AGE"), c("Hadrien", 34)))}
\usage{
map_of(args_vector)
}
\arguments{
\item{args_vector}{A vector of argument}
}
\value{
A Java Map
}
\description{
Create a \code{Map} from a vector of arguments to the \code{of} static method.
Example:
map_of(c("name", "Hadrien"))
map_of(row_to_map_args(c("NAME", "AGE"), c("Hadrien", 34)))
}
