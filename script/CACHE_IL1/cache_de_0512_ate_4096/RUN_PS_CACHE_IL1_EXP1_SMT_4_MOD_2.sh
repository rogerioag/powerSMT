#!/bin/bash
# File generated by Script (../genPowerSMTCache_EXP1_orgByMod.sh) at 03/06/2008-17:03:09.
# This script must be executed in /opt/simuladores/benchmarks/SPEC/SPEC2000/inputs-spec2000, because the inputs of inputs.

mkdir -p /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309
cd /opt/simuladores/benchmarks/SPEC/SPEC2000/inputs-spec2000

echo "Execution SMT-4"
echo " Execution SMT-4 with MOD-2"
echo "  Running config: (proc:4, mod:2, nbank:2, benchs:[1, 4], csize:512Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 1 4 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_1_4__csize_512__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_1_4__csize_512__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 2 -cache:il1 il1:2:512:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_1_4__csize_512__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:4, mod:2, nbank:2, benchs:[1, 4], csize:1024Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 1 4 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_1_4__csize_1024__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_1_4__csize_1024__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 2 -cache:il1 il1:2:1024:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_1_4__csize_1024__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:4, mod:2, nbank:2, benchs:[1, 4], csize:2048Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 1 4 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_1_4__csize_2048__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_1_4__csize_2048__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 2 -cache:il1 il1:2:2048:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_1_4__csize_2048__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:4, mod:2, nbank:2, benchs:[1, 4], csize:4096Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 1 4 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_1_4__csize_4096__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_1_4__csize_4096__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 2 -cache:il1 il1:2:4096:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_1_4__csize_4096__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:4, mod:2, nbank:2, benchs:[5, 8], csize:512Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 5 8 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_5_8__csize_512__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_5_8__csize_512__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 2 -cache:il1 il1:2:512:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_5_8__csize_512__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:4, mod:2, nbank:2, benchs:[5, 8], csize:1024Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 5 8 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_5_8__csize_1024__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_5_8__csize_1024__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 2 -cache:il1 il1:2:1024:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_5_8__csize_1024__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:4, mod:2, nbank:2, benchs:[5, 8], csize:2048Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 5 8 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_5_8__csize_2048__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_5_8__csize_2048__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 2 -cache:il1 il1:2:2048:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_5_8__csize_2048__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:4, mod:2, nbank:2, benchs:[5, 8], csize:4096Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 5 8 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_5_8__csize_4096__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_5_8__csize_4096__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 2 -cache:il1 il1:2:4096:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_5_8__csize_4096__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:4, mod:2, nbank:2, benchs:[9, 12], csize:512Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 9 12 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_9_12__csize_512__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_9_12__csize_512__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 2 -cache:il1 il1:2:512:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_9_12__csize_512__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:4, mod:2, nbank:2, benchs:[9, 12], csize:1024Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 9 12 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_9_12__csize_1024__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_9_12__csize_1024__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 2 -cache:il1 il1:2:1024:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_9_12__csize_1024__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:4, mod:2, nbank:2, benchs:[9, 12], csize:2048Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 9 12 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_9_12__csize_2048__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_9_12__csize_2048__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 2 -cache:il1 il1:2:2048:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_9_12__csize_2048__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:4, mod:2, nbank:2, benchs:[9, 12], csize:4096Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 9 12 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_9_12__csize_4096__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_9_12__csize_4096__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 2 -cache:il1 il1:2:4096:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_9_12__csize_4096__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:4, mod:2, nbank:2, benchs:[13, 16], csize:512Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 13 16 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_13_16__csize_512__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_13_16__csize_512__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 2 -cache:il1 il1:2:512:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_13_16__csize_512__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:4, mod:2, nbank:2, benchs:[13, 16], csize:1024Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 13 16 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_13_16__csize_1024__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_13_16__csize_1024__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 2 -cache:il1 il1:2:1024:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_13_16__csize_1024__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:4, mod:2, nbank:2, benchs:[13, 16], csize:2048Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 13 16 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_13_16__csize_2048__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_13_16__csize_2048__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 2 -cache:il1 il1:2:2048:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_13_16__csize_2048__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:4, mod:2, nbank:2, benchs:[13, 16], csize:4096Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 13 16 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_13_16__csize_4096__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_13_16__csize_4096__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 2 -cache:il1 il1:2:4096:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/20080603170309/proc_4__mod_2__nbank_2__benchs_13_16__csize_4096__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo " End Execution SMT-4 with MOD-2"
echo "End Execution SMT-4"
