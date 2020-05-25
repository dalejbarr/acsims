default : data_derived/simulation_results.rds

clean :
	rm -rf data_derived/
	rm -rf data_raw/

data_derived/simulation_results.rds : \
		scripts/simulation_results.R 
	@echo ""
	@mkdir -p data_derived
	@echo "--- Extracting files to data_raw..."
	@unzip -q data_raw.zip
	@echo "    Pre-processing raw data files..."
	@Rscript scripts/simulation_results.R
	@rm -rf data_raw/
	@echo "--- Done."
