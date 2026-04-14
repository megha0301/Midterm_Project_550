report_midterm.html: code/04_render.R report_midterm.Rmd components
	Rscript code/04_render.R
	
output/data_clean.rds: code/read_data_mp.R
	Rscript code/read_data_mp.R
	
output/table_one.rds: code/01_table_one_EL.R 
	Rscript code/01_table_one_EL.R
	
output/boxplot.rds: code/02_boxplot.R 
	Rscript code/02_boxplot.R
	
output/regression_table.rds: code/03_linear_model.R
	Rscript code/03_linear_model.R
	
.PHONY: components
components: output/table_one.rds output/boxplot.rds output/regression_table.rds
	