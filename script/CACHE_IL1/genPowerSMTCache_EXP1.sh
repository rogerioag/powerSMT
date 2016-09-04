#!/bin/bash
# Script to generate Command Lines to PowerSMT.
# Author: Rogério Aparecido Gonçalves (rogerio.rag@gmail.com)
# Para ser executado de dentro do diretorio de entradas dos benchmarks.

# Target Simulator Identifier.
# PS:  PowerSMT.
TARGET_SIM="PS"

# TEST identifier.
TEST_NAME="CACHE_IL1_EXP1"

# File name to generate.
OUT_PUT_NAME="RUN_${TARGET_SIM}_${TEST_NAME}"
# Extension for script files.
SCRIPT_EXT="sh"
# Header identification of generate script.
SCRIPT_HEADER="#!/bin/bash"

# Execute the command line in inputs directory, because the inputs programs have inputs files in this 
# directory.
# Benchmarks inputs, necessary to execution, inputs of inputs are in this directory too.

# Instalation simulator directory.
HOME_SIM="/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7"
EXE_SIM_NAME="powerSMT"
EXE_SIM=${HOME_SIM}/${EXE_SIM_NAME}

# SMT configurations.
# Dir com batch files.
BATCH_DIR="${HOME_SIM}/batch"
# File with benchmark names.
BATCH_FILE="${BATCH_DIR}/RUN_SPEC2000"

CONFIG_DIR="${HOME_SIM}/config"

HOME_INPUTS="/opt/simuladores/benchmarks/SPEC/SPEC2000/inputs-spec2000"

# Keep the current dir.
START_DIR=`pwd`

# Date command.
DATE_CMD='`date`'

# Output directory.
HOME_RESULTS="/home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1"
# Build the out put dir.
OUTPUT_DIR_NAME=`date +%d%m%Y%H%M%S`
OUTPUT_DIR=$HOME_RESULTS/$OUTPUT_DIR_NAME

echo "-----------------------------------------------------------------------"
echo "Start script to generate Command lines to SimpleScalar, SS_SMT and powerSMT Simulators."
echo "This script has writed by Rogerio A. Gonçalves (rogerio.rag@gmail.com) "
echo "Variables assumed:													 "
echo "HOME_SIM: " ${HOME_SIM}
echo "HOME_INPUTS: " ${HOME_INPUTS}
echo "HOME_RESULTS: " ${HOME_RESULTS}
echo "START_DIR: " ${START_DIR}
echo "Generate file: " ${OUT_PUT_NAME}.${SCRIPT_EXT}
echo "-----------------------------------------------------------------------"
echo "Processing..."

# ------------------------------------------------------------------------------
# Configuration of simulator parameters.
# ------------------------------------------------------------------------------

# X1 and X2
X1="1"
X2="2"

# Number of instructions to fast foward.
NUM_INST_FWD=50000000
# Max number of instructions executed.
NUM_MAX_INST=300000000

# Original options from sim-outorder plus some new ones.

FAST_FWD="-fastfwd ${NUM_INST_FWD}"
MAX_INST="-max:inst ${NUM_MAX_INST}"

# Technological process.
TECH_PROC="-technology TECH_070"

# Some CACTI Call parameters.
# -cache:il1_output_width, -cache:dl1_output_width, -cache:dl2_output_width
CACTI_CALL_PARMS="-cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64"

# Memory Configuration.
MEM_CONFIG="-mem:width 128"

# Individual cache configurations to SS_SMT and powerSMT.
# <name>:<nbanks>:<csize>:<bsize>:<assoc>:<repl>
# Specific in this test. Configuration in nested loop.
# CACHE_IL1="-cache:il1 il1:1:32:64:4:l" 
CACHE_IL1=""
CACHE_IL2="-cache:il2 dl2"
CACHE_DL1="-cache:dl1 dl1:1:64:64:4:l"
CACHE_DL2="-cache:dl2 ul2:1:1024:128:8:l"
      
# Cache configuration.
CACHE_CONFIG="${CACHE_IL1} ${CACHE_IL2} ${CACHE_DL1} ${CACHE_DL2}"

# Modules configuration.
# Modules configuration in nested loop.
# MODULES_CONFIG="-imodules:num 16"

# Individual tlbs configurations.
# TLBS. 1024KB = 1MB
# itlb.
ITLB_CONFIG="-tlb:itlb itlb:1024:4096:4:l"

# dtlb.
DTLB_CONFIG="-tlb:dtlb dtlb:1024:4096:4:l"

# TLBS Configuration.
TLBS_CONFIG="${ITLB_CONFIG} ${DTLB_CONFIG}"

# Architectural Configuration.
# FETCH STAGE configuration.
FETCH_CONFIG="-fetch:width 256 -fetch:ifqsize 256"

# DECOD configuration.
DECOD_CONFIG="-decode:width 256"

# Branch Predictor configuration.
BPRED_CONFIG="-bpred:type 2lev -bpred:2lev 1 4096 16 0"

# RUU/LSQ configuration.
RUU_LSQ_CONFIG="-ruulsq:type distributed -ruu:size 256 -lsq:size 128"

# ISSUE configuration.
ISSUE_CONFIG="-issue:inorder FALSE -issue:width 256"

# Functional Units configuration.
# heterogeneous
FU_CONFIG="-fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32"
# FU_CONFIG="-fu:type hetero -res:ialu 32 -res:imult 4 -res:fpalu 2 -res:fpmult 1 -res:memport 32"

# Commit configuration.
COMMIT_CONFIG="-commit:width 256"

# Command line.
SIMULATOR_OPTIONS="${FAST_FWD} ${MAX_INST} ${FETCH_CONFIG} ${DECOD_CONFIG} ${ISSUE_CONFIG} ${COMMIT_CONFIG} ${RUU_LSQ_CONFIG} ${FU_CONFIG} ${BPRED_CONFIG} ${TECH_PROC} ${CACTI_CALL_PARMS} ${TLBS_CONFIG} ${CACHE_CONFIG}"

# ss_smt <x1> <x2> {options} batch file
# ss_smt 1 8 {options} RUN_SPEC2000
# which:
# <x1> : initial line to consider from <batch file> (ignoring blank and comentaries lines)
# <x2> : final line to consider from <batch file> (ignoring blank and comentaries lines)
# {options} : original options from sim-outorder plus some new ones
# <batch file> : text file: each line must be a command line for one application that will
# be executed for each slot
# ------------------------------------------------------------------------
# Loop to file generate.
# ------------------------------------------------------------------------
echo "Generating file..."

FILE_OUT_PUT=${START_DIR}/${OUT_PUT_NAME}.${SCRIPT_EXT}

echo ${SCRIPT_HEADER} > ${FILE_OUT_PUT}

echo "# File generated by Script ($0) at `date +%d/%m/%Y-%H:%M:%S`." >> ${FILE_OUT_PUT}
echo "# This script must be executed in ${HOME_INPUTS}, because the inputs of inputs." >> ${FILE_OUT_PUT}
echo "" >> ${FILE_OUT_PUT}
# Make result dir, make parents if needed.
echo "mkdir -p ${OUTPUT_DIR}" >> ${FILE_OUT_PUT}
echo "cd ${HOME_INPUTS}" >> ${FILE_OUT_PUT}
echo "" >> ${FILE_OUT_PUT}

# linhas de comando
# Quantidade de Processos: SMT-1, SMT-2, SMT-4, SMT-8 e SMT-16.
for numProcessos in 1 2 4 8 16
do
  echo "Num Processos: $numProcessos"
  echo "echo \"Execution SMT-${numProcessos}\"" >> ${FILE_OUT_PUT}
  # numModulos
  iModulo=1
  maxModulo=$numProcessos
  while [ "$iModulo" -le $maxModulo ]
  do
    echo "Num Modulos: $iModulo"
    echo "echo \" Execution SMT-${numProcessos} with MOD-${iModulo}\"" >> ${FILE_OUT_PUT}
    iBenchmark=1
    maxBenchmark=16
    while [ "$iBenchmark" -le $maxBenchmark ]
    do
      echo "Benchmark: $iBenchmark"
      # Tamanho da cache tem que ser em K Bytes. Estes valores estao em bytes pelo jeito.
      # Em bytes: 4096 8192 16384 32768 65536 131072 262144 524288 1048576 2097152 4194304
      # Em Kbytes: 4 8 16 32  64 128 256 512 1024 2048 4096
      for cacheSize in 4 8 16 32 64 128 256 512 1024 2048 4096
      do
      	for blockSize in 64
	    do
			for assoc in 1
  		    do
  		    	# 'l'-LRU, 'f'-FIFO, 'r'-random
  		    	for repl in l
  		    	do
  		    		fIndex=`expr $iBenchmark + $numProcessos - 1` 
  		    		il1_nBanks=$[$numProcessos / $iModulo]
  		      		echo "Generating Command Line: (proc:${numProcessos}, mod:${iModulo}, nbank:${il1_nBanks}, benchs:[${iBenchmark}, ${fIndex}], csize:${cacheSize}Kb, bsize:${blockSize} bytes, assoc:${assoc}, repl:${repl})."
  		      		echo "echo \"  Running config: (proc:${numProcessos}, mod:${iModulo}, nbank:${il1_nBanks}, benchs:[${iBenchmark}, ${fIndex}], csize:${cacheSize}Kb, bsize:${blockSize} bytes, assoc:${assoc}, repl:${repl}).\"" >> ${FILE_OUT_PUT}
  		      		echo "echo \"   Started at: ${DATE_CMD}.\"" >> ${FILE_OUT_PUT}
  		      
  		      		# Modules configuration.
  		      		MODULES_CONFIG="-imodules:num ${iModulo}"
  		      	      
  		      		# Cache definitions.
  		      		# <name>:<nbanks>:<csize>:<bsize>:<assoc>:<repl>
  		      		# Instruction Cache L1.
  		      		CACHE_IL1="-cache:il1 il1:${il1_nBanks}:${cacheSize}:${blockSize}:${assoc}:${repl}"
  		      			
			  		# Specific Test Options.
			  		TEST_OPTIONS="${MODULES_CONFIG} ${CACHE_IL1}"
  		      
  		      		# Redirecting outputs.  		      
  		      		REDIR_SIM="-redir:sim ${OUTPUT_DIR}/proc_${numProcessos}__mod_${iModulo}__nbank_${il1_nBanks}__benchs_${iBenchmark}_${fIndex}__csize_${cacheSize}__bsize_${blockSize}__assoc_${assoc}__repl_${repl}_sim.out"
			  		REDIR_PROG="-redir:prog ${OUTPUT_DIR}/proc_${numProcessos}__mod_${iModulo}__nbank_${il1_nBanks}__benchs_${iBenchmark}_${fIndex}__csize_${cacheSize}__bsize_${blockSize}__assoc_${assoc}__repl_${repl}_prog.out"
			  		
			  		# CACTI outs in stdout.
			  		REDIR_STDOUT="> ${OUTPUT_DIR}/proc_${numProcessos}__mod_${iModulo}__nbank_${il1_nBanks}__benchs_${iBenchmark}_${fIndex}__csize_${cacheSize}__bsize_${blockSize}__assoc_${assoc}__repl_${repl}_stdout.out"
			  
			  		# Building command line.
  			  		COMMAND_LINE="${EXE_SIM} ${iBenchmark} ${fIndex} ${REDIR_SIM} ${REDIR_PROG} ${SIMULATOR_OPTIONS} ${TEST_OPTIONS} ${BATCH_FILE} ${REDIR_STDOUT}"
  			  
  			  		# Write command line to file.
			  		echo "${COMMAND_LINE}" >> ${FILE_OUT_PUT}
			  		echo "echo \"   Finished at: ${DATE_CMD}.\"" >> ${FILE_OUT_PUT}
  			  		echo "" >> ${FILE_OUT_PUT}
  		    	done
  		    done	
    	  done
      done
      let "iBenchmark+=$numProcessos"
    done
    let "iModulo*=2"
  done
done
echo "File ${OUT_PUT_NAME} generated."

echo "End of Script Execution."
echo "Execute the ${OUT_PUT_NAME}.${SCRIPT_EXT} in ${HOME_INPUTS} directory."

echo "-----------------------------------------------------------------------"

