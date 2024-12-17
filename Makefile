
.PHONY: all figures clean-dats clean-figures clean-all

fig_path = "results/figure"

# Run and Generate everything
all: report/count_report.html

# Dat generations
results/isles.dat : data/isles.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=data/isles.txt --output_file=results/isles.dat

results/abyss.dat : data/abyss.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=data/abyss.txt --output_file=results/abyss.dat

results/last.dat : data/last.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=data/last.txt --output_file=results/last.dat

results/sierra.dat : data/sierra.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=data/sierra.txt --output_file=results/sierra.dat


# Figure generations
figures : ${fig_path}/isles.png ${fig_path}/abyss.png ${fig_path}/last.png ${fig_path}/sierra.png

${fig_path}/isles.png : results/isles.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=results/isles.dat --output_file=${fig_path}/isles.png

${fig_path}/abyss.png : results/abyss.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=results/abyss.dat --output_file=${fig_path}/abyss.png

${fig_path}/last.png : results/last.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=results/last.dat --output_file=${fig_path}/last.png

${fig_path}/sierra.png : results/sierra.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=results/sierra.dat --output_file=${fig_path}/sierra.png

# Report generation
report/count_report.html : report/count_report.qmd figures
	quarto render report/count_report.qmd --to html

# Clean up
# Remove dats
clean-dats : 
	rm -f results/isles.dat results/abyss.dat results/last.dat results/sierra.dat

# Remove figures
clean-figures : 
	rm -f ${fig_path}/isles.png ${fig_path}/abyss.png ${fig_path}/last.png ${fig_path}/sierra.png

clean : clean-dats clean-figures 
	rm -f report/count_report.html 
	rm -rf report/count_report_files