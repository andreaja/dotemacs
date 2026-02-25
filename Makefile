ELISP := $(HOME)/.emacs.d
EMACS := emacs

.PHONY: clean_byte compile all

clean_byte:
	find . -name "*.elc" -delete

compile:
	$(EMACS) -batch -f batch-byte-recompile-directory $(ELISP)

all: compile
