exit(0)


				echo "Generating Command Line: (${tamCache}, ${blockSize}, ${assoc}, ${index})."
				echo "echo 'Executando config (${tamCache}, ${blockSize}, ${assoc}, ${index}).'" >> ${FILE_OUT_PUT}
				DATE_CMD='`date`'
				echo "echo \"Inicio: ${DATE_CMD}.\"" >> ${FILE_OUT_PUT}
				echo "#${index} ${benchmark_type[index]}" >> ${FILE_OUT_PUT}
				SAIDA_SIM="${DIR_SAIDA}/${benchmark_output_id[index]}_${tamCache}_${blockSize}_${assoc}_sim.out"
				SAIDA_PROG="${DIR_SAIDA}/${benchmark_output_id[index]}_${tamCache}_${blockSize}_${assoc}_prog.out"
				ADD_SIM_OPT="${HOME_SIM}/sim-outorder -fastfwd ${NUM_INST_AQUEC} -max:inst ${NUM_INST_MAX} -redir:sim ${SAIDA_SIM} -redir:prog ${SAIDA_PROG}"

				# Cache definitions.
				il1_nSets=$[tamCache / blockSize / assoc]
				CACHE_IL1_DEF="-cache:il1 il1:${il1_nSets}:${blockSize}:${assoc}:l"

				# Cache de dados com o dobro do tamanho da de instrucoes.
				dl1_nSets=$[il1_nSets * 2]
				CACHE_DL1_DEF="-cache:dl1 dl1:${dl1_nSets}:${blockSize}:${assoc}:l"

				# Não mexe no nivel 2.
				CACHE_IL2_DEF="-cache:il2 dl2"
				CACHE_DL2_DEF="-cache:dl2 ul2:1024:128:8:l"
				
				CACHES_DEFS="${CACHE_IL1_DEF} ${CACHE_DL1_DEF} ${CACHE_IL2_DEF} ${CACHE_DL2_DEF}"
								
				ADD_SIM_OPT="${ADD_SIM_OPT} ${CACHES_DEFS} ${TLBS_DEFS} ${STAGES_DEFS} ${RUU_LSQ_DEFS} ${RES_DEFS}"
				echo "${ADD_SIM_OPT} ${benchmark_command_line[index]}" >> ${FILE_OUT_PUT}
				echo "echo \"Termino: ${DATE_CMD}.\"" >> ${FILE_OUT_PUT}
				echo "" >> ${FILE_OUT_PUT}








echo "echo \"Executando bechmarks (1-1).\"" >> ${FILE_OUT_PUT}

# Generate command lines SMT-1.
for index in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
do
  REDIR_SIM="-redir:sim ${OUTPUT_DIR}/simout_${index}.txt"
  REDIR_PROG="-redir:prog ${OUTPUT_DIR}/progout_${index}.txt"
  COMMAND_LINE="${EXE_SIM} ${index} ${index} ${REDIR_SIM} ${REDIR_PROG} ${SIMULATOR_OPTIONS} ${BATCH_FILE}"
  echo "${COMMAND_LINE}" >> ${FILE_OUT_PUT}
  echo "" >> ${FILE_OUT_PUT}
done

echo "" >> ${FILE_OUT_PUT}
echo "echo \"Executando bechmarks (1-2).\"" >> ${FILE_OUT_PUT}

# Generate command lines SMT-2.
for index in 1 3 5 7 9 11 13 15 17
do
  indexMais1=$[${index}+1]
  REDIR_SIM="-redir:sim ${OUTPUT_DIR}/simout_${index}_${indexMais1}.txt"
  REDIR_PROG="-redir:prog ${OUTPUT_DIR}/progout_${index}_${indexMais1}.txt"
  COMMAND_LINE="${EXE_SIM} ${index} ${indexMais1} ${REDIR_SIM} ${REDIR_PROG} ${SIMULATOR_OPTIONS} ${BATCH_FILE}"
  echo "${COMMAND_LINE}" >> ${FILE_OUT_PUT}
  echo "" >> ${FILE_OUT_PUT}
done

echo "" >> ${FILE_OUT_PUT}
echo "echo \"Executando bechmarks (1-4).\"" >> ${FILE_OUT_PUT}

# Generate command lines SMT-4.
for index in 1 5 9 13
do
  indexMais3=$[${index}+3]
  REDIR_SIM="-redir:sim ${OUTPUT_DIR}/simout_${index}_${indexMais3}.txt"
  REDIR_PROG="-redir:prog ${OUTPUT_DIR}/progout_${index}_${indexMais3}.txt"
  COMMAND_LINE="${EXE_SIM} ${index} ${indexMais3} ${REDIR_SIM} ${REDIR_PROG} ${SIMULATOR_OPTIONS} ${BATCH_FILE}"
  echo "${COMMAND_LINE}" >> ${FILE_OUT_PUT}
  echo "" >> ${FILE_OUT_PUT}
done

echo "" >> ${FILE_OUT_PUT}
echo "echo \"Executando bechmarks (1-8).\"" >> ${FILE_OUT_PUT}

# Generate command lines SMT-8.
for index in 1 9
do
  indexMais7=$[${index}+7]
  REDIR_SIM="-redir:sim ${OUTPUT_DIR}/simout_${index}_${indexMais7}.txt"
  REDIR_PROG="-redir:prog ${OUTPUT_DIR}/progout_${index}_${indexMais7}.txt"
  COMMAND_LINE="${EXE_SIM} ${index} ${indexMais7} ${REDIR_SIM} ${REDIR_PROG} ${SIMULATOR_OPTIONS} ${BATCH_FILE}"
  echo "${COMMAND_LINE}" >> ${FILE_OUT_PUT}
  echo "" >> ${FILE_OUT_PUT}
done

# Generate command lines SMT-16.
for index in 1
do
  indexMais15=$[${index}+15]
  REDIR_SIM="-redir:sim ${OUTPUT_DIR}/simout_${index}_${indexMais15}.txt"
  REDIR_PROG="-redir:prog ${OUTPUT_DIR}/progout_${index}_${indexMais15}.txt"
  COMMAND_LINE="${EXE_SIM} ${index} ${indexMais15} ${REDIR_SIM} ${REDIR_PROG} ${SIMULATOR_OPTIONS} ${BATCH_FILE}"
  echo "${COMMAND_LINE}" >> ${FILE_OUT_PUT}
  echo "" >> ${FILE_OUT_PUT}
done

echo "" >> ${FILE_OUT_PUT}
echo "echo \"Executando bechmarks (1-16).\"" >> ${FILE_OUT_PUT}



echo "" >> ${FILE_OUT_PUT}
echo "echo \"Término da Execução \`date\`.\"" >> ${FILE_OUT_PUT}

