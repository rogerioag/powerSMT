#!/bin/bash
# File generated by Script (../genPowerSMT_REAL_EXP4.sh) at 24/07/2008-10:30:26.
# This script must be executed in /opt/simuladores/benchmarks/SPEC/SPEC2000/inputs-spec2000, because the inputs of inputs.

mkdir -p /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026
cd /opt/simuladores/benchmarks/SPEC/SPEC2000/inputs-spec2000

echo "  Running config [31]: (proc:16, benchs:[1, 16])."
echo "   Started at: `date`."
if [ -e /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_16__benchs_1_16_sim.out ];
then echo '     Arquivo ja existe'
else 
  /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 1 16 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_16__benchs_1_16_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_16__benchs_1_16_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 4 -fetch:ifqsize 32  -decode:width 4 -issue:inorder FALSE -issue:width 4 -commit:width 4 -ruulsq:type shared -ruu:size 32 -lsq:size 16 -fu:type hetero -res:ialu 3 -res:imult 1 -res:fpalu 3 -res:fpmult 1 -res:memport 2 -bpred:type 2lev -bpred:2lev 1 512 9 1 -bpred:btb 32 1 -bpred:ras 0 -technology TECH_070 -cache:il1_output_width 16 -cache:dl1_output_width 8 -cache:dl2_output_width 32 -tlb:itlb itlb:16:64:1:l -tlb:dtlb dtlb:16:64:1:l  -cache:il1 il1:1:32:16:2:l -cache:il2 dl2 -cache:dl1 dl1:1:32:8:2:l -cache:dl2 ul2:1:512:32:2:l -imodules:num 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_16__benchs_1_16_stdout.out
fi
echo "   Finished at: `date`."

