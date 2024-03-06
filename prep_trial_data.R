# --------------------------------------------------------------------- #
# --------------------------------------------------------------------- #
# Prepare trial data for manipulation
# --------------------------------------------------------------------- #
# --------------------------------------------------------------------- #

# Start timing
tictoc::tic()

# Load packages
library(tidyverse)
library(feather)

# Set root directory for raw data
in_dir <- "delim"
extract_name <- "20240220_export"

# Set root directory for exporting as RDS
out_dir <- "feather"

# How many rows to read?
n_rows <- Inf

# Define metadata for requested files 
metadata <- tribble(
  ~file_name,             ~col_spec,
  "browse_conditions",    "iccc",
  "designs",              "icccccccccllll",
  "design_groups",        "icccc",
  "eligibilities",        "icccccccccllll",
  "facilities",           "iccccccc",
  "interventions",        "icccc",
  "keywords",             "iccc",
  "sponsors",             "icccc",
  "studies",              "ccDDDDDDcDDcDDcDDcccDcDccDccDccccccccciccciicclccclllllcccccccTTccccccc") 

# Stop if input directory doesn't exist
stopifnot(dir.exists(in_dir))

# Create out directory if doesn't exist
dir.create(out_dir, showWarnings = F)

# Read datasets
data <- 
  map2(
    metadata$file_name,
    metadata$col_spec,
    \(name, cols){
      path <- paste0(in_dir, "/", extract_name, "/", name, ".txt")
      print(paste("Reading", path))
      read_delim(path, delim = "|", col_type = cols, n_max = n_rows)
    }) %>% 
  setNames(metadata$file_name)

# Save as feather files
dir.create(paste0(out_dir, "/", extract_name), showWarnings = F)
walk2(metadata$file_name, 
      data,
      \(name, df){
        path <- paste0(out_dir, "/", extract_name, "/", name, ".feather")
        print(paste("Writing", path))
        write_feather(df, path)
      })

# Wrap up
tictoc::toc()
