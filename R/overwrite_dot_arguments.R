#' Overwrite arguments with dot arguments
#'
#' This function takes a list of function arguments and additional arguments passed
#' with the dot (...). It overwrites the function arguments with the values from the
#' dot arguments if they have the same names.
#'
#' @param function_args A named list of function arguments.
#' @param ... Additional arguments passed with the dot (...). These arguments will
#'   overwrite the corresponding ones in \code{function_args} if they have the same names.
#'
#' @return A list containing the original \code{function_args} with any overwritten values
#'   from the dot arguments.
#'
#' @examples
#' # Example usage
#' original_args <- list(a = 1, b = 2)
#' result <- overwrite_dot_arguments(original_args, b = 3, c = 4)
#' result
#'
#' @export
overwrite_dot_arguments <- function(function_args, ...) {
  dots <- list(...)
  return(c(function_args[setdiff(names(function_args), names(dots))], dots))
}
