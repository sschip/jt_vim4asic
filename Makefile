# makefile for generating ctags files

# define the installation path of your Exuberant Ctags and/or Universal Ctags command
ectags ?= /usr/bin/ctags
uctags ?= /usr/local/bin/ctags

USING_UNIVERSAL_CTAGS		?= 0
# define the source to be scanned, by default it's a directory (including all of its sub-directories)
USING_FILELIST	        	?= 0
USING_INPUT_FILE	    	?= 0

TAGS_FILE_NAME				?= tags
TAGS_REFERENCE_FILE_NAME	?= tags_reference

OUTPUT_DIR				?= ./tags_out

# Please use absolute path in the FILELIST
FILELIST				?= PLEASE_DEFINE_FILELIST

INPUT_DIR				?= PLEASE_DEFINE_INPUT_DIR
INPUT_FILE				?= PLEASE_DEFINE_INPUT_FILE

# use the absolute file path in the tags file
CTAGS_CMN_OPTS			?= --tag-relative=no

ifeq ($(USING_UNIVERSAL_CTAGS),1)
	ctags_exec   = $(uctags)
	CTAGS_OPTION           = 
	CTAGS_OPTION_REFERENCE = --options=./ctags_options/uctags_options_sv_verilog_vhdl_reference
	# don't generate tags for IO port, wire/reg definitions
	CTAGS_KINDS		       = --kinds-Verilog=-n-p-r --kinds-SystemVerilog=-n-p-r
	CTAGS_REFERENCE_KINDS  = 
else
	ctags_exec = $(ectags)
	CTAGS_OPTION 		   = --options=./ctags_options/ectags_options_sv_vhdl
	CTAGS_OPTION_REFERENCE = --options=./ctags_options/ectags_options_sv_verilog_vhdl_reference
	# don't generate tags for IO port, wire/reg definitions
	CTAGS_KINDS			   = --Verilog-kinds=-n-p-r --SystemVerilog-kinds=-v
	CTAGS_REFERENCE_KINDS  = --Verilog-kinds=-n-p-r --SystemVerilog-kinds=-v
endif

ifeq ($(USING_FILELIST),1)
    ifeq ($(USING_INPUT_FILE),1)
        CTAGS_SOURCE = $(shell realpath $(INPUT_FILE))
        CTAGS_INPUT	 = $(CTAGS_SOURCE)
    else
        CTAGS_SOURCE = $(FILELIST)
        CTAGS_INPUT	 = -L $(CTAGS_SOURCE)
    endif
else
    ifeq ($(USING_INPUT_FILE),1)
        CTAGS_SOURCE = $(shell realpath $(INPUT_FILE))
        CTAGS_INPUT	 = $(CTAGS_SOURCE)
    else
        CTAGS_SOURCE = $(shell realpath $(INPUT_DIR))
        CTAGS_INPUT	 = -R $(CTAGS_SOURCE)
    endif
endif

help:
	@echo "=================HELP BEG================"
	@echo "make all INPUT_DIR=<source_code_directory> - Using Exuberant Ctags to generate both the tags files of"
	@echo "                                             the definition and reference from the specified diretory (source_code_directory) recursively"
	@echo "make all USING_UNIVERSAL_CTAGS=1 INPUT_DIR=<source_code_directory> - Using Universal Ctags to generate both the tags file of" 
	@echo "                                                                     the definition and reference from the specified diretory" 
	@echo "                                                                     (source_code_directory) recursively"
	@echo "make all FILELIST=<filelist_of_source_code> - Using Exuberant Ctags to generate both the tags files of"
	@echo "                                              the definition and reference from a filelist specified by filelist_of_source_code"
	@echo "make ctags_gen INPUT_DIR=<source_code_directory> - Using Exuberant Ctags to generate both the tags files of"
	@echo "                                                   the definition from the specified diretory (source_code_directory) recursively"
	@echo "make ctags_gen_reference USING_UNIVERSAL_CTAGS=1 INPUT_DIR=<source_code_directory> - Using Universal Ctags to generate both the tags file of" 
	@echo "                                                                                     the reference from the specified diretory"
	@echo "                                                                                     (source_code_directory) recursively"
	@echo "=================HELP END================"

ctags_gen: $(CTAGS_SOURCE)
	@mkdir -p $(OUTPUT_DIR)
	@echo "$(ctags_exec) $(CTAGS_CMN_OPTS) $(CTAGS_OPTION) -f $(OUTPUT_DIR)/$(TAGS_FILE_NAME) $(CTAGS_KINDS) $(CTAGS_INPUT)"
	@$(ctags_exec) $(CTAGS_CMN_OPTS) $(CTAGS_OPTION) -f $(OUTPUT_DIR)/$(TAGS_FILE_NAME) $(CTAGS_KINDS) $(CTAGS_INPUT)
	@echo "Running post processing on $(OUTPUT_DIR)/$(TAGS_FILE_NAME)"
	@./scripts/tags_post_process.csh $(OUTPUT_DIR)/$(TAGS_FILE_NAME)

ctags_gen_reference: $(CTAGS_SOURCE)
	@mkdir -p $(OUTPUT_DIR)
	@echo "$(ctags_exec) $(CTAGS_CMN_OPTS) $(CTAGS_OPTION_REFERENCE) -f $(OUTPUT_DIR)/$(TAGS_REFERENCE_FILE_NAME) $(CTAGS_KINDS_REFERENCE) $(CTAGS_INPUT)"
	@$(ctags_exec) $(CTAGS_CMN_OPTS) $(CTAGS_OPTION_REFERENCE) -f $(OUTPUT_DIR)/$(TAGS_REFERENCE_FILE_NAME) $(CTAGS_KINDS_REFERENCE) $(CTAGS_INPUT)
	@echo "Running post processing on $(OUTPUT_DIR)/$(TAGS_REFERENCE_FILE_NAME)"
	@./scripts/tags_reference_post_process.csh $(OUTPUT_DIR)/$(TAGS_REFERENCE_FILE_NAME)

all: ctags_gen ctags_gen_reference
