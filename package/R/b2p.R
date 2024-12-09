#' Convert Bracken Output to Phyloseq Object
#'
#' This function converts a Bracken output file into a `phyloseq` object by linking the taxonomy id provided by bracken 
#' with a NCBI database provided by`taxonomizr`and optionally adding metadata.
#'
#' @param file Path to the Bracken output file (tab-delimited).
#' @param database Path to the `taxonomizr` database (e.g., `accessionTaxa.sql`). Run setupdb() first.
#' @param mdata Optional. Path to a metadata file (CSV with semicolon as separator) to merge into the `phyloseq` object. Names should be equal to bracken input files.
#' @return A `phyloseq` object containing the OTU table and taxonomy table, and optionally, sample metadata.
#' @import phyloseq taxonomizr
#' @export
#' @examples
#' \dontrun{
#' # Example usage
#' bracken <- b2p(file = "bracken.tsv", database = "database/accessionTaxa.sql")
#' 
#' # Example with metadata
#' bracken <- b2p(file = "bracken.tsv", database = "database/accessionTaxa.sql", mdata = "metadata.csv")
#' }

b2p <- function(file, database, mdata = NULL) {
  # Load the data
  data <- read.delim(file, header = TRUE, row.names = 2)
  
  # Remove specific columns: 'name', 'taxonomy_lvl', and columns containing 'bracken_frac'
  data <- data[, !grepl("name|taxonomy_lvl|bracken_frac", colnames(data))]
  
  # Remove ".bracken_num" from column names
  colnames(data) <- gsub("\\.bracken_num", "", colnames(data))
  
  # Convert taxonomy IDs to numeric
  taxonomyid <- as.numeric(unlist(row.names(data)))
  
  # Get taxonomy data
  taxonomy <- getTaxonomy(taxonomyid, database, desiredTaxa = c("superkingdom", "phylum", "class", "order", "family", "genus", "species"))
  row.names(taxonomy) 
  row.names(taxonomy)=gsub("[[:space:]]","",row.names(taxonomy))
  
  # Replace NA values in the data
  data[is.na(data)] <- 0
  
  # Create phyloseq OTU table and TAX table
  OTU <- otu_table(data, taxa_are_rows = TRUE)
  TAX <- tax_table(as.matrix(taxonomy))  # Convert taxonomy to matrix for phyloseq compatibility
  
  physeq <- phyloseq(OTU, TAX)
  
  # If metadata file is provided
  if (!is.null(mdata)) {
    meta_data <- read.csv(mdata, sep = ";")
    sampledata <- sample_data(data.frame(
      meta_data, row.names = sample_names(physeq), stringsAsFactors = FALSE
    ))
    physeq <- merge_phyloseq(physeq, sampledata)
  }
  
  return(physeq)
}
