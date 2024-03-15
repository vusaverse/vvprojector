#' Create Configuration CSV Files for Reading and Writing Data
#'
#' This function initializes project configuration by creating two CSV files:
#' one for reading data and another for writing data.
#' It uses either a user-specified `config.yml` file or the package's default `config.yml` file
#' to determine the structure of these configuration files.
#'
#' @param user_config_path A character string specifying the path to the user-specified
#' `config.yml` file. Defaults to "user_config.yml".
#' @param output_dir_path A character string specifying the directory path where the configuration
#' CSV files will be written. Defaults to "config_files".
#'
#' @return NULL. The function writes two CSV files to the specified directory: `config_read.csv`
#' for reading configurations and `config_write.csv` for writing configurations.
#'
#' @examples
#' \dontrun{
#' # Using the default config.yml
#' create_config_csv_files()
#' }
#'
#' \dontrun{
#' # Specifying a user-defined config.yml
#' create_config_csv_files(user_config_path = "path/to/user_config.yml")
#' }
#'
#' @export
create_config_csv_files <- function(user_config_path = "user_config.yml", output_dir_path = "config_files") {
  # Inform the user about the initialization process
  message("Initializing project configuration...")

  # Check if the user has specified a config.yml file
  if (file.exists(user_config_path)) {
    message("User-specified config.yml found at: ", user_config_path)
    # Load the user-specified configuration
    user_config <- config::get(file = user_config_path)
  } else {
    message("No user-specified config.yml found. Using package defaults.")
    # Fall back to the package's default config.yml
    package_config_path <- system.file("config.yml", package = "vvprojector", mustWork = TRUE)
    user_config <- config::get(file = package_config_path)

    # Inform the user about the package defaults
    message("Package defaults are:")
    print(user_config)

    # Prompt the user to confirm if they want to use the package defaults
    use_defaults <- readline(prompt = "Use package defaults? (y/n): ")
    if (tolower(use_defaults) != "y") {
      message("Exiting without initializing the project configuration.")
      return(NULL)
    }
  }

  # Extract the colnames_config from the loaded configuration
  colnames_config_read <- user_config$colnames_config_read
  colnames_config_write <- user_config$colnames_config_write

  # Create data frames with the expected column names and default values for reading and writing
  config_df_read <- data.frame(matrix(ncol = length(colnames_config_read), nrow = 0))
  colnames(config_df_read) <- colnames_config_read

  config_df_write <- data.frame(matrix(ncol = length(colnames_config_write), nrow = 0))
  colnames(config_df_write) <- colnames_config_write

  # Ensure the output directory exists
  if (!dir.exists(output_dir_path)) {
    dir.create(output_dir_path)
  }

  # Write the data frames to CSV files, semicolon-separated and without quotes
  utils::write.table(config_df_read, file = file.path(output_dir_path, "config_read.csv"), sep = ";", quote = FALSE, row.names = FALSE)
  utils::write.table(config_df_write, file = file.path(output_dir_path, "config_write.csv"), sep = ";", quote = FALSE, row.names = FALSE)

  message("Read configuration file initialized at: ", file.path(output_dir_path, "config_read.csv"))
  message("Write configuration file initialized at: ", file.path(output_dir_path, "config_write.csv"))
}

