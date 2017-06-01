#!/usr/bin/make -f

NAME = gsaponaro-glu2017

pdf:
	pdflatex $(NAME) # --shell-escape option needed by epstopdf
	bibtex $(NAME)
	pdflatex $(NAME)
	pdflatex $(NAME)
	pdflatex $(NAME)

clean:
	rm -f *.aux *.bbl *.bcf *.blg *.brf *.dvi *.log *.out *.pdf *.run.xml
