# b2p: Bracken to Phyloseq

`b2p`is an R package that converts Bracken output into phyloseq objects for microbial diversity analysis.

## Installation

To install `b2p` from GitHub:

```R
install.packages("devtools")
devtools::install_github("braddmg/b2p/package")
```
## Setting Up the Database
Run the following command to download the database required to assign full taxonomy paths to the phyloseq object. This process may take several hours depending on your internet connection. The database size is approximately 87 GB.
```R
library(b2p)
setupdb(path = "your/path")
```
## Converting bracken output file

Refer to the TSV file in the Example folder for the correct Bracken file format. The package processes Bracken outputs without requiring modifications. 
Note: Ensure the metadata file has sample names matching those in the Bracken file, excluding the ".bracken_num" extension (see mdata file in Example folder). Specify the column name containing sample IDs in the metadata file. 
```R
# Example usage
phyloseq_object <- b2p(file = "bracken.tsv", database = "database/accessionTaxa.sql")
 
# Example with metadata and custom sample column
phyloseq_object <- b2p(file = "bracken.tsv", database = "database/accessionTaxa.sql", mdata = "metadata.csv", sample_column = "SampleName")
```


