#' Write Package Config.yml to User-Defined Location
#'
#' This function retrieves the package's default `config.yml` file and writes it to a specified location.
#' If no location is specified, it defaults to the current working directory.
#'
#' @param output_path A character string specifying the path where the `config.yml` file should be written. Defaults to the current working directory.
#'
#' @return NULL. The function writes the `config.yml` file to the specified location.
#'
#' @examples
#' # Write to the current working directory
#' \dontrun{
#' vvprojector_write_package_config_yml()
#' }
#'
#' # Write to a specific location
#' \dontrun{
#' vvprojector_write_package_config_yml(output_path = "path/to/config/directory")
#' }
#'
#' @export
vvprojector_write_package_config_yml <- function(output_path = getwd()) {
  # Define the path to the package's default config.yml
  package_config_path <- system.file("config.yml", package = "vvprojector", mustWork = TRUE)

  # Ensure the output directory exists
  if (!dir.exists(output_path)) {
    dir.create(output_path, recursive = TRUE)
  }

  # Copy the package's config.yml to the specified location
  file.copy(from = package_config_path, to = file.path(output_path, "config.yml"))

  message("Package config.yml copied to: ", file.path(output_path, "config.yml"))
}
