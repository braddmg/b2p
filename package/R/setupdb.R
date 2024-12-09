#' Setup Taxonomizr Database
#'
#' This function sets up the `taxonomizr` database in a specified directory.
#'
#' @param path Directory to store the database. Default is "database/".
#' @return None
#' @export

setupdb <- function(path = "database/") {
  # Ensure the required package is loaded
  if (!requireNamespace("taxonomizr", quietly = TRUE)) {
    stop("The 'taxonomizr' package is required. Please install it using install.packages('taxonomizr').")
  }

  # Create the directory if it doesn't exist
  if (!dir.exists(path)) {
    dir.create(path, recursive = TRUE)
    message("Created directory: ", path)
  }

  # Call prepareDatabase function from taxonomizr
  taxonomizr::prepareDatabase('accessionTaxa.sql', tmpDir = path)

  message("Database setup completed in: ", path)
}
