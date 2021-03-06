#!/bin/bash
# Script to generate Command Lines to PowerSMT.
# Author: Rogério Aparecido Gonçalves (rogerio.rag@gmail.com)
# Para ser executado de dentro do diretorio de entradas dos benchmarks.

# Target Simulator Identifier.
# PS:  PowerSMT.
TARGET_SIM="PS"

# TEST identifier.
TEST_NAME="REAL_EXP4"

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
HOME_RESULTS="/home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/${TEST_NAME}"
# Build the out put dir.
# OUTPUT_DIR_NAME=`date +%d%m%Y%H%M%S`
OUTPUT_DIR_NAME=`date +%Y%m%d%H%M%S`
OUTPUT_DIR=$HOME_RESULTS/$OUTPUT_DIR_NAME

echo "-----------------------------------------------------------------------"
echo "Start script to generate Command lines to SimpleScalar, SS_SMT and powerSMT Simulators."
echo "This script was writed by Rogerio A. Gonçalves (rogerio.rag@gmail.com) "
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
CACTI_CALL_PARMS="-cache:il1_output_width 16 -cache:dl1_output_width 8 -cache:dl2_output_width 32"

# Memory Configuration.
MEM_CONFIG="-mem:width 64"

# Individual cache configurations to SS_SMT and powerSMT.
# <name>:<nbanks>:<csize>:<bsize>:<assoc>:<repl>
# Specific in this test. Configuration in nested loop.
# CACHE_IL1="-cache:il1 il1:1:32:64:4:l" 
CACHE_IL1="-cache:il1 il1:1:32:16:2:l"
CACHE_IL2="-cache:il2 dl2"
CACHE_DL1="-cache:dl1 dl1:1:32:8:2:l"
CACHE_DL2="-cache:dl2 ul2:1:512:32:2:l"

MODULES_CONFIG=""
      
# Cache configuration.
CACHE_CONFIG="${MODULES_CONFIG} ${CACHE_IL1} ${CACHE_IL2} ${CACHE_DL1} ${CACHE_DL2}"

# Modules configuration.
# Modules configuration in nested loop.
# MODULES_CONFIG="-imodules:num 16"

# Individual tlbs configurations.
# TLBS. 1024KB = 1MB
# itlb.
ITLB_CONFIG="-tlb:itlb itlb:16:64:1:l"

# dtlb.
DTLB_CONFIG="-tlb:dtlb dtlb:16:64:1:l"

# TLBS Configuration.
TLBS_CONFIG="${ITLB_CONFIG} ${DTLB_CONFIG}"

# Architectural Configuration.
# FETCH STAGE configuration.
FETCH_CONFIG="-fetch:width 4 -fetch:ifqsize 32 "

# DECOD configuration.
DECOD_CONFIG="-decode:width 4"

# Branch Predictor configuration.
# Branch Predictor.
#    GAg: 1 4096 12 0
# Gshare: 1 4096 12 1
# 512 x 2 (512 entradas de 2 bits de historico, o padrao é 2 bits já).
# 1 entrada no 1st level ( 1 reg. de 9 bits para endereçar os 512 entradas do 2nd level)
# BTB.
# -bpred:btb       <int list...>    # 512 4 # BTB config (<num_sets> <associativity>)
# -bpred:ras       <int>            # 8 # return address stack size (0 for no return stack)
BPRED_CONFIG="-bpred:type 2lev -bpred:2lev 1 512 9 1 -bpred:btb 32 1 -bpred:ras 0"

# RUU/LSQ configuration.
# RUU_LSQ_CONFIG="-ruulsq:type distributed -ruu:size 256 -lsq:size 128"
RUU_LSQ_CONFIG="-ruulsq:type shared -ruu:size 32 -lsq:size 16"

# ISSUE configuration.
ISSUE_CONFIG="-issue:inorder FALSE -issue:width 4"

# Functional Units configuration.
# heterogeneous
# FU_CONFIG="-fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32"
FU_CONFIG="-fu:type hetero -res:ialu 3 -res:imult 1 -res:fpalu 3 -res:fpmult 1 -res:memport 2"
# FU_CONFIG="-fu:type hetero -res:ialu 32 -res:imult 4 -res:fpalu 2 -res:fpmult 1 -res:memport 32"

# Commit configuration.
COMMIT_CONFIG="-commit:width 4"

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

# FILE_OUT_PUT=${START_DIR}/${OUT_PUT_NAME}.${SCRIPT_EXT}
FILE_OUT_PUT_BASE=${START_DIR}/${OUT_PUT_NAME}

echo "Deleting existing files by prefix ${FILE_OUT_PUT_BASE}..."
rm -f ${FILE_OUT_PUT_BASE}*

echo "Generating files..."

echo ${SCRIPT_HEADER} > ${FILE_OUT_PUT_BASE}

echo "# File generated by Script ($0) at `date +%d/%m/%Y-%H:%M:%S`." >> ${FILE_OUT_PUT_BASE}
echo "# This script must be executed in ${HOME_INPUTS}, because the inputs of inputs." >> ${FILE_OUT_PUT_BASE}
echo "" >> ${FILE_OUT_PUT_BASE}
# Make result dir, make parents if needed.
echo "mkdir -p ${OUTPUT_DIR}" >> ${FILE_OUT_PUT_BASE}
echo "cd ${HOME_INPUTS}" >> ${FILE_OUT_PUT_BASE}
echo "" >> ${FILE_OUT_PUT_BASE}

# Quantidade de linhas de comando geradas.
quantSimulacoes=0
FILE_OUT_PUT=""
FILE_OUT_PUT_INTER=""

# linhas de comando
# Quantidade de Processos: SMT-1, SMT-2, SMT-4, SMT-8 e SMT-16.
for numProcessos in 1 2 4 8 16
do
  echo "Num Processos: $numProcessos"
  iBenchmark=1
  maxBenchmark=16
  while [ "$iBenchmark" -le $maxBenchmark ]
  do
      echo "Benchmark: $iBenchmark"
      FILE_OUT_PUT=${FILE_OUT_PUT_BASE}_SMT_${numProcessos}.${SCRIPT_EXT}
      if [ -e ${FILE_OUT_PUT} ]; 
	then echo 'Arquivo ja existe'
	else cat ${FILE_OUT_PUT_BASE} > ${FILE_OUT_PUT}
      fi
      fIndex=`expr $iBenchmark + $numProcessos - 1` 
      # Incrementa a quantidade de linhas de comando geradas.
      let "quantSimulacoes+=1"
      echo "Generating Command Line [${quantSimulacoes}]: (proc:${numProcessos}, benchs:[${iBenchmark}, ${fIndex}])."
      echo "echo \"  Running config [${quantSimulacoes}]: (proc:${numProcessos}, benchs:[${iBenchmark}, ${fIndex}]).\"" >> ${FILE_OUT_PUT}
      echo "echo \"   Started at: ${DATE_CMD}.\"" >> ${FILE_OUT_PUT}
      # Specific Test Options.
      TEST_OPTIONS="-imodules:num ${numProcessos}"
      # Nome arquivo Saida Sim.
      NOME_ARQUIVO="${OUTPUT_DIR}/proc_${numProcessos}__benchs_${iBenchmark}_${fIndex}_sim.out"
      # Redirecting outputs.  		      
      REDIR_SIM="-redir:sim ${NOME_ARQUIVO}"
      REDIR_PROG="-redir:prog ${OUTPUT_DIR}/proc_${numProcessos}__benchs_${iBenchmark}_${fIndex}_prog.out"
      
      # CACTI outs in stdout.
      REDIR_STDOUT="> ${OUTPUT_DIR}/proc_${numProcessos}__benchs_${iBenchmark}_${fIndex}_stdout.out"
      
      # Building command line.
      COMMAND_LINE="${EXE_SIM} ${iBenchmark} ${fIndex} ${REDIR_SIM} ${REDIR_PROG} ${SIMULATOR_OPTIONS} ${TEST_OPTIONS} ${BATCH_FILE} ${REDIR_STDOUT}"  			  			
      
      # Write command line to file.
      # echo "${COMMAND_LINE}" >> ${FILE_OUT_PUT}
      # Write command line to file.
      echo "if [ -e ${NOME_ARQUIVO} ];" >> ${FILE_OUT_PUT}
      echo "then echo '     Arquivo ja existe'" >> ${FILE_OUT_PUT}
      echo "else " >> ${FILE_OUT_PUT}
      echo "  ${COMMAND_LINE}" >> ${FILE_OUT_PUT}
      #echo "  echo '     Falta:${NOME_ARQUIVO}'" >> ${FILE_OUT_PUT}
      echo "fi" >> ${FILE_OUT_PUT}
      echo "echo \"   Finished at: ${DATE_CMD}.\"" >> ${FILE_OUT_PUT}
      echo "" >> ${FILE_OUT_PUT}
      let "iBenchmark+=$numProcessos"
  done	
  
done
echo "File ${FILE_OUT_PUT_BASE} will be deleted."
rm -f ${FILE_OUT_PUT_BASE}

echo "File ${OUT_PUT_NAME} generated."

echo "Quantify command lines: ${quantSimulacoes}."

echo "End of Script Execution."
echo "Execute the ${OUT_PUT_NAME}.${SCRIPT_EXT} in ${HOME_INPUTS} directory."

echo "-----------------------------------------------------------------------"

# gerar o arquivo execBatch.
NOME_ARQ_BATCH="execBatch_REAL.sh"

echo "${SCRIPT_HEADER}" > ${NOME_ARQ_BATCH}

echo "echo \"Execution in Batch.\"" >> ${NOME_ARQ_BATCH}

for nomeArquivo in `ls -t --file-type RUN*.sh | cut -d"." -f1`
do
        echo "echo \"Execution $nomeArquivo.${SCRIPT_EXT}"\" >> ${NOME_ARQ_BATCH}
        echo "${START_DIR}/$nomeArquivo.${SCRIPT_EXT}" >> ${NOME_ARQ_BATCH}
        echo "" >> ${NOME_ARQ_BATCH}
done

echo "echo \"End of Execution in Batch."\" >> ${NOME_ARQ_BATCH}
