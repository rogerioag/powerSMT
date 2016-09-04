#!/bin/bash
# File generated by Script (../genPowerSMT_REAL_EXP4.sh) at 24/07/2008-10:30:26.
# This script must be executed in /opt/simuladores/benchmarks/SPEC/SPEC2000/inputs-spec2000, because the inputs of inputs.

mkdir -p /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026
cd /opt/simuladores/benchmarks/SPEC/SPEC2000/inputs-spec2000

echo "  Running config [1]: (proc:1, benchs:[1, 1])."
echo "   Started at: `date`."
if [ -e /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_1_1_sim.out ];
then echo '     Arquivo ja existe'
else 
  /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 1 1 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_1_1_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_1_1_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 4 -fetch:ifqsize 32  -decode:width 4 -issue:inorder FALSE -issue:width 4 -commit:width 4 -ruulsq:type shared -ruu:size 32 -lsq:size 16 -fu:type hetero -res:ialu 3 -res:imult 1 -res:fpalu 3 -res:fpmult 1 -res:memport 2 -bpred:type 2lev -bpred:2lev 1 512 9 1 -bpred:btb 32 1 -bpred:ras 0 -technology TECH_070 -cache:il1_output_width 16 -cache:dl1_output_width 8 -cache:dl2_output_width 32 -tlb:itlb itlb:16:64:1:l -tlb:dtlb dtlb:16:64:1:l  -cache:il1 il1:1:32:16:2:l -cache:il2 dl2 -cache:dl1 dl1:1:32:8:2:l -cache:dl2 ul2:1:512:32:2:l -imodules:num 1 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_1_1_stdout.out
fi
echo "   Finished at: `date`."

echo "  Running config [2]: (proc:1, benchs:[2, 2])."
echo "   Started at: `date`."
if [ -e /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_2_2_sim.out ];
then echo '     Arquivo ja existe'
else 
  /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 2 2 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_2_2_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_2_2_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 4 -fetch:ifqsize 32  -decode:width 4 -issue:inorder FALSE -issue:width 4 -commit:width 4 -ruulsq:type shared -ruu:size 32 -lsq:size 16 -fu:type hetero -res:ialu 3 -res:imult 1 -res:fpalu 3 -res:fpmult 1 -res:memport 2 -bpred:type 2lev -bpred:2lev 1 512 9 1 -bpred:btb 32 1 -bpred:ras 0 -technology TECH_070 -cache:il1_output_width 16 -cache:dl1_output_width 8 -cache:dl2_output_width 32 -tlb:itlb itlb:16:64:1:l -tlb:dtlb dtlb:16:64:1:l  -cache:il1 il1:1:32:16:2:l -cache:il2 dl2 -cache:dl1 dl1:1:32:8:2:l -cache:dl2 ul2:1:512:32:2:l -imodules:num 1 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_2_2_stdout.out
fi
echo "   Finished at: `date`."

echo "  Running config [3]: (proc:1, benchs:[3, 3])."
echo "   Started at: `date`."
if [ -e /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_3_3_sim.out ];
then echo '     Arquivo ja existe'
else 
  /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 3 3 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_3_3_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_3_3_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 4 -fetch:ifqsize 32  -decode:width 4 -issue:inorder FALSE -issue:width 4 -commit:width 4 -ruulsq:type shared -ruu:size 32 -lsq:size 16 -fu:type hetero -res:ialu 3 -res:imult 1 -res:fpalu 3 -res:fpmult 1 -res:memport 2 -bpred:type 2lev -bpred:2lev 1 512 9 1 -bpred:btb 32 1 -bpred:ras 0 -technology TECH_070 -cache:il1_output_width 16 -cache:dl1_output_width 8 -cache:dl2_output_width 32 -tlb:itlb itlb:16:64:1:l -tlb:dtlb dtlb:16:64:1:l  -cache:il1 il1:1:32:16:2:l -cache:il2 dl2 -cache:dl1 dl1:1:32:8:2:l -cache:dl2 ul2:1:512:32:2:l -imodules:num 1 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_3_3_stdout.out
fi
echo "   Finished at: `date`."

echo "  Running config [4]: (proc:1, benchs:[4, 4])."
echo "   Started at: `date`."
if [ -e /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_4_4_sim.out ];
then echo '     Arquivo ja existe'
else 
  /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 4 4 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_4_4_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_4_4_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 4 -fetch:ifqsize 32  -decode:width 4 -issue:inorder FALSE -issue:width 4 -commit:width 4 -ruulsq:type shared -ruu:size 32 -lsq:size 16 -fu:type hetero -res:ialu 3 -res:imult 1 -res:fpalu 3 -res:fpmult 1 -res:memport 2 -bpred:type 2lev -bpred:2lev 1 512 9 1 -bpred:btb 32 1 -bpred:ras 0 -technology TECH_070 -cache:il1_output_width 16 -cache:dl1_output_width 8 -cache:dl2_output_width 32 -tlb:itlb itlb:16:64:1:l -tlb:dtlb dtlb:16:64:1:l  -cache:il1 il1:1:32:16:2:l -cache:il2 dl2 -cache:dl1 dl1:1:32:8:2:l -cache:dl2 ul2:1:512:32:2:l -imodules:num 1 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_4_4_stdout.out
fi
echo "   Finished at: `date`."

echo "  Running config [5]: (proc:1, benchs:[5, 5])."
echo "   Started at: `date`."
if [ -e /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_5_5_sim.out ];
then echo '     Arquivo ja existe'
else 
  /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 5 5 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_5_5_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_5_5_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 4 -fetch:ifqsize 32  -decode:width 4 -issue:inorder FALSE -issue:width 4 -commit:width 4 -ruulsq:type shared -ruu:size 32 -lsq:size 16 -fu:type hetero -res:ialu 3 -res:imult 1 -res:fpalu 3 -res:fpmult 1 -res:memport 2 -bpred:type 2lev -bpred:2lev 1 512 9 1 -bpred:btb 32 1 -bpred:ras 0 -technology TECH_070 -cache:il1_output_width 16 -cache:dl1_output_width 8 -cache:dl2_output_width 32 -tlb:itlb itlb:16:64:1:l -tlb:dtlb dtlb:16:64:1:l  -cache:il1 il1:1:32:16:2:l -cache:il2 dl2 -cache:dl1 dl1:1:32:8:2:l -cache:dl2 ul2:1:512:32:2:l -imodules:num 1 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_5_5_stdout.out
fi
echo "   Finished at: `date`."

echo "  Running config [6]: (proc:1, benchs:[6, 6])."
echo "   Started at: `date`."
if [ -e /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_6_6_sim.out ];
then echo '     Arquivo ja existe'
else 
  /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 6 6 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_6_6_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_6_6_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 4 -fetch:ifqsize 32  -decode:width 4 -issue:inorder FALSE -issue:width 4 -commit:width 4 -ruulsq:type shared -ruu:size 32 -lsq:size 16 -fu:type hetero -res:ialu 3 -res:imult 1 -res:fpalu 3 -res:fpmult 1 -res:memport 2 -bpred:type 2lev -bpred:2lev 1 512 9 1 -bpred:btb 32 1 -bpred:ras 0 -technology TECH_070 -cache:il1_output_width 16 -cache:dl1_output_width 8 -cache:dl2_output_width 32 -tlb:itlb itlb:16:64:1:l -tlb:dtlb dtlb:16:64:1:l  -cache:il1 il1:1:32:16:2:l -cache:il2 dl2 -cache:dl1 dl1:1:32:8:2:l -cache:dl2 ul2:1:512:32:2:l -imodules:num 1 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_6_6_stdout.out
fi
echo "   Finished at: `date`."

echo "  Running config [7]: (proc:1, benchs:[7, 7])."
echo "   Started at: `date`."
if [ -e /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_7_7_sim.out ];
then echo '     Arquivo ja existe'
else 
  /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 7 7 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_7_7_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_7_7_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 4 -fetch:ifqsize 32  -decode:width 4 -issue:inorder FALSE -issue:width 4 -commit:width 4 -ruulsq:type shared -ruu:size 32 -lsq:size 16 -fu:type hetero -res:ialu 3 -res:imult 1 -res:fpalu 3 -res:fpmult 1 -res:memport 2 -bpred:type 2lev -bpred:2lev 1 512 9 1 -bpred:btb 32 1 -bpred:ras 0 -technology TECH_070 -cache:il1_output_width 16 -cache:dl1_output_width 8 -cache:dl2_output_width 32 -tlb:itlb itlb:16:64:1:l -tlb:dtlb dtlb:16:64:1:l  -cache:il1 il1:1:32:16:2:l -cache:il2 dl2 -cache:dl1 dl1:1:32:8:2:l -cache:dl2 ul2:1:512:32:2:l -imodules:num 1 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_7_7_stdout.out
fi
echo "   Finished at: `date`."

echo "  Running config [8]: (proc:1, benchs:[8, 8])."
echo "   Started at: `date`."
if [ -e /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_8_8_sim.out ];
then echo '     Arquivo ja existe'
else 
  /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 8 8 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_8_8_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_8_8_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 4 -fetch:ifqsize 32  -decode:width 4 -issue:inorder FALSE -issue:width 4 -commit:width 4 -ruulsq:type shared -ruu:size 32 -lsq:size 16 -fu:type hetero -res:ialu 3 -res:imult 1 -res:fpalu 3 -res:fpmult 1 -res:memport 2 -bpred:type 2lev -bpred:2lev 1 512 9 1 -bpred:btb 32 1 -bpred:ras 0 -technology TECH_070 -cache:il1_output_width 16 -cache:dl1_output_width 8 -cache:dl2_output_width 32 -tlb:itlb itlb:16:64:1:l -tlb:dtlb dtlb:16:64:1:l  -cache:il1 il1:1:32:16:2:l -cache:il2 dl2 -cache:dl1 dl1:1:32:8:2:l -cache:dl2 ul2:1:512:32:2:l -imodules:num 1 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_8_8_stdout.out
fi
echo "   Finished at: `date`."

echo "  Running config [9]: (proc:1, benchs:[9, 9])."
echo "   Started at: `date`."
if [ -e /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_9_9_sim.out ];
then echo '     Arquivo ja existe'
else 
  /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 9 9 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_9_9_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_9_9_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 4 -fetch:ifqsize 32  -decode:width 4 -issue:inorder FALSE -issue:width 4 -commit:width 4 -ruulsq:type shared -ruu:size 32 -lsq:size 16 -fu:type hetero -res:ialu 3 -res:imult 1 -res:fpalu 3 -res:fpmult 1 -res:memport 2 -bpred:type 2lev -bpred:2lev 1 512 9 1 -bpred:btb 32 1 -bpred:ras 0 -technology TECH_070 -cache:il1_output_width 16 -cache:dl1_output_width 8 -cache:dl2_output_width 32 -tlb:itlb itlb:16:64:1:l -tlb:dtlb dtlb:16:64:1:l  -cache:il1 il1:1:32:16:2:l -cache:il2 dl2 -cache:dl1 dl1:1:32:8:2:l -cache:dl2 ul2:1:512:32:2:l -imodules:num 1 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_9_9_stdout.out
fi
echo "   Finished at: `date`."

echo "  Running config [10]: (proc:1, benchs:[10, 10])."
echo "   Started at: `date`."
if [ -e /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_10_10_sim.out ];
then echo '     Arquivo ja existe'
else 
  /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 10 10 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_10_10_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_10_10_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 4 -fetch:ifqsize 32  -decode:width 4 -issue:inorder FALSE -issue:width 4 -commit:width 4 -ruulsq:type shared -ruu:size 32 -lsq:size 16 -fu:type hetero -res:ialu 3 -res:imult 1 -res:fpalu 3 -res:fpmult 1 -res:memport 2 -bpred:type 2lev -bpred:2lev 1 512 9 1 -bpred:btb 32 1 -bpred:ras 0 -technology TECH_070 -cache:il1_output_width 16 -cache:dl1_output_width 8 -cache:dl2_output_width 32 -tlb:itlb itlb:16:64:1:l -tlb:dtlb dtlb:16:64:1:l  -cache:il1 il1:1:32:16:2:l -cache:il2 dl2 -cache:dl1 dl1:1:32:8:2:l -cache:dl2 ul2:1:512:32:2:l -imodules:num 1 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_10_10_stdout.out
fi
echo "   Finished at: `date`."

echo "  Running config [11]: (proc:1, benchs:[11, 11])."
echo "   Started at: `date`."
if [ -e /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_11_11_sim.out ];
then echo '     Arquivo ja existe'
else 
  /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 11 11 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_11_11_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_11_11_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 4 -fetch:ifqsize 32  -decode:width 4 -issue:inorder FALSE -issue:width 4 -commit:width 4 -ruulsq:type shared -ruu:size 32 -lsq:size 16 -fu:type hetero -res:ialu 3 -res:imult 1 -res:fpalu 3 -res:fpmult 1 -res:memport 2 -bpred:type 2lev -bpred:2lev 1 512 9 1 -bpred:btb 32 1 -bpred:ras 0 -technology TECH_070 -cache:il1_output_width 16 -cache:dl1_output_width 8 -cache:dl2_output_width 32 -tlb:itlb itlb:16:64:1:l -tlb:dtlb dtlb:16:64:1:l  -cache:il1 il1:1:32:16:2:l -cache:il2 dl2 -cache:dl1 dl1:1:32:8:2:l -cache:dl2 ul2:1:512:32:2:l -imodules:num 1 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_11_11_stdout.out
fi
echo "   Finished at: `date`."

echo "  Running config [12]: (proc:1, benchs:[12, 12])."
echo "   Started at: `date`."
if [ -e /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_12_12_sim.out ];
then echo '     Arquivo ja existe'
else 
  /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 12 12 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_12_12_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_12_12_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 4 -fetch:ifqsize 32  -decode:width 4 -issue:inorder FALSE -issue:width 4 -commit:width 4 -ruulsq:type shared -ruu:size 32 -lsq:size 16 -fu:type hetero -res:ialu 3 -res:imult 1 -res:fpalu 3 -res:fpmult 1 -res:memport 2 -bpred:type 2lev -bpred:2lev 1 512 9 1 -bpred:btb 32 1 -bpred:ras 0 -technology TECH_070 -cache:il1_output_width 16 -cache:dl1_output_width 8 -cache:dl2_output_width 32 -tlb:itlb itlb:16:64:1:l -tlb:dtlb dtlb:16:64:1:l  -cache:il1 il1:1:32:16:2:l -cache:il2 dl2 -cache:dl1 dl1:1:32:8:2:l -cache:dl2 ul2:1:512:32:2:l -imodules:num 1 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_12_12_stdout.out
fi
echo "   Finished at: `date`."

echo "  Running config [13]: (proc:1, benchs:[13, 13])."
echo "   Started at: `date`."
if [ -e /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_13_13_sim.out ];
then echo '     Arquivo ja existe'
else 
  /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 13 13 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_13_13_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_13_13_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 4 -fetch:ifqsize 32  -decode:width 4 -issue:inorder FALSE -issue:width 4 -commit:width 4 -ruulsq:type shared -ruu:size 32 -lsq:size 16 -fu:type hetero -res:ialu 3 -res:imult 1 -res:fpalu 3 -res:fpmult 1 -res:memport 2 -bpred:type 2lev -bpred:2lev 1 512 9 1 -bpred:btb 32 1 -bpred:ras 0 -technology TECH_070 -cache:il1_output_width 16 -cache:dl1_output_width 8 -cache:dl2_output_width 32 -tlb:itlb itlb:16:64:1:l -tlb:dtlb dtlb:16:64:1:l  -cache:il1 il1:1:32:16:2:l -cache:il2 dl2 -cache:dl1 dl1:1:32:8:2:l -cache:dl2 ul2:1:512:32:2:l -imodules:num 1 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_13_13_stdout.out
fi
echo "   Finished at: `date`."

echo "  Running config [14]: (proc:1, benchs:[14, 14])."
echo "   Started at: `date`."
if [ -e /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_14_14_sim.out ];
then echo '     Arquivo ja existe'
else 
  /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 14 14 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_14_14_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_14_14_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 4 -fetch:ifqsize 32  -decode:width 4 -issue:inorder FALSE -issue:width 4 -commit:width 4 -ruulsq:type shared -ruu:size 32 -lsq:size 16 -fu:type hetero -res:ialu 3 -res:imult 1 -res:fpalu 3 -res:fpmult 1 -res:memport 2 -bpred:type 2lev -bpred:2lev 1 512 9 1 -bpred:btb 32 1 -bpred:ras 0 -technology TECH_070 -cache:il1_output_width 16 -cache:dl1_output_width 8 -cache:dl2_output_width 32 -tlb:itlb itlb:16:64:1:l -tlb:dtlb dtlb:16:64:1:l  -cache:il1 il1:1:32:16:2:l -cache:il2 dl2 -cache:dl1 dl1:1:32:8:2:l -cache:dl2 ul2:1:512:32:2:l -imodules:num 1 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_14_14_stdout.out
fi
echo "   Finished at: `date`."

echo "  Running config [15]: (proc:1, benchs:[15, 15])."
echo "   Started at: `date`."
if [ -e /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_15_15_sim.out ];
then echo '     Arquivo ja existe'
else 
  /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 15 15 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_15_15_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_15_15_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 4 -fetch:ifqsize 32  -decode:width 4 -issue:inorder FALSE -issue:width 4 -commit:width 4 -ruulsq:type shared -ruu:size 32 -lsq:size 16 -fu:type hetero -res:ialu 3 -res:imult 1 -res:fpalu 3 -res:fpmult 1 -res:memport 2 -bpred:type 2lev -bpred:2lev 1 512 9 1 -bpred:btb 32 1 -bpred:ras 0 -technology TECH_070 -cache:il1_output_width 16 -cache:dl1_output_width 8 -cache:dl2_output_width 32 -tlb:itlb itlb:16:64:1:l -tlb:dtlb dtlb:16:64:1:l  -cache:il1 il1:1:32:16:2:l -cache:il2 dl2 -cache:dl1 dl1:1:32:8:2:l -cache:dl2 ul2:1:512:32:2:l -imodules:num 1 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_15_15_stdout.out
fi
echo "   Finished at: `date`."

echo "  Running config [16]: (proc:1, benchs:[16, 16])."
echo "   Started at: `date`."
if [ -e /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_16_16_sim.out ];
then echo '     Arquivo ja existe'
else 
  /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 16 16 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_16_16_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_16_16_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 4 -fetch:ifqsize 32  -decode:width 4 -issue:inorder FALSE -issue:width 4 -commit:width 4 -ruulsq:type shared -ruu:size 32 -lsq:size 16 -fu:type hetero -res:ialu 3 -res:imult 1 -res:fpalu 3 -res:fpmult 1 -res:memport 2 -bpred:type 2lev -bpred:2lev 1 512 9 1 -bpred:btb 32 1 -bpred:ras 0 -technology TECH_070 -cache:il1_output_width 16 -cache:dl1_output_width 8 -cache:dl2_output_width 32 -tlb:itlb itlb:16:64:1:l -tlb:dtlb dtlb:16:64:1:l  -cache:il1 il1:1:32:16:2:l -cache:il2 dl2 -cache:dl1 dl1:1:32:8:2:l -cache:dl2 ul2:1:512:32:2:l -imodules:num 1 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/REAL_EXP4/20080724103026/proc_1__benchs_16_16_stdout.out
fi
echo "   Finished at: `date`."

