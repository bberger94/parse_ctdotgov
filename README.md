# ClinicalTrials.gov Extract

* `delim` contains raw data extracts from the CTTI Aggregate Analysis of ClinicalTrials.gov (AACT) database in pipe-delimited format.
* `prep_trial_data.R` holds source code to convert a subset of the files to the Feather format, which is a portable file format for data frames. 
* Either run the Rscript or the executable using `./run`.
* Extracted files end up in the `feather` directory.
