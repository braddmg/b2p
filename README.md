# b2p: Bracken to Phyloseq

`b2p` is an R package that converts Bracken output into `phyloseq` objects for diversity analysis.

## Installation

To install `b2p` from GitHub:

```R
install.packages("devtools") # or remotes
devtools::install_github("braddmg/b2p/package")
```
## Setup database
run the next line to download database to assign the full path of taxonomy to the phyloseq object. This process might take several hours depending of your internet conection. Database size is around 87gb.
```R
library(b2p)
setupdb(path = "your/path")
```
## Convert bracken output file

See in Example folder for a bracken file format. But you should be able to use the output obtained from running bracken.
Metadata file must have the same names as the bracken file (without the ".bracken_num" extension)

```R
physeq <- b2p(file = "bracken.tsv", database = "path/to/database.sql")
```


