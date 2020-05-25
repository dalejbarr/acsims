options(tidyverse.quiet = TRUE)
library("autocorr")
library("tidyverse")

load_results <- function(x, path) {
  readRDS(file.path(path, x))
}

rawpath <- "data_raw"

## first thing: consolidate all the results to temp directory
tdir <- tempfile()
dir.create(tdir)
message("    consolidating raw data...")
suppressMessages(consolidate_results(rawpath, tdir))

allfiles <- tibble(fname = dir(tdir, "^[0-9].+\\.rds$"),
                   tmp = sub("\\.rds$", "", fname)) %>%
  separate(tmp, c("ns", "ni", "A", "B", "AB",
                  "srfx0", "srfx1",
                  "irfx0", "irfx1", "case"), sep = "_",
           convert = TRUE) %>%
  select(case, A, B, AB, fname)

alldat <- allfiles %>%
  mutate(d = map(fname, load_results, tdir)) %>%
  select(-fname) %>%
  unnest(d)

message("    saving to stage_1/data_derived/simulation_results.rds ...")
saveRDS(alldat, "data_derived/simulation_results.rds")

unlink(tdir, TRUE)
