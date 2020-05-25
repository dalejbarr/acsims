alldat <- readRDS("data_derived/simulation_results.rds")

message("    saving to stage_1/data_derived/simulation_results.csv ...")
readr::write_csv(alldat, "data_derived/simulation_results.csv")
