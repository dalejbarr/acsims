default : data_derived/simulation_results.rds

clean :
	rm -rf data_derived/

csv : data_derived/simulation_results.csv.zip

data_derived/simulation_results.rds : \
		scripts/simulation_results.R \
		$(wildcard data_raw/%.rds)
	@echo ""
	@mkdir -p data_derived
	@echo "--- Pre-processing raw data files..."
	@Rscript scripts/simulation_results.R
	@echo "--- Done."

data_derived/simulation_results.csv.zip : data_derived/simulation_results.rds
	@echo ""
	@echo "--- Converting R binary to CSV file..."
	@Rscript scripts/rds_to_csv.R
	@echo "    compressing CSV file to ZIP (may take a few minutes...)"
	@zip -q data_derived/simulation_results.csv.zip \
	        data_derived/simulation_results.csv
	@rm -f data_derived/simulation_results.csv
	@echo "--- Wrote stage_1/data_derived/simulation_results.csv.zip."
