#!/bin/bash
# File generated by Script (/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/script/genPowerSMTCache_EXP1.sh) at 30/05/2008-20:21:05.
# This script must be executed in /opt/simuladores/benchmarks/SPEC/SPEC2000/inputs-spec2000, because the inputs of inputs.

mkdir -p /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105
cd /opt/simuladores/benchmarks/SPEC/SPEC2000/inputs-spec2000

echo "Execution SMT-1"
echo " Execution SMT-1 with MOD-1"
echo "  Running config: (proc:1, mod:1, nbank:1, benchs:[1, 1], csize:4Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 1 1 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_1_1__csize_4__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_1_1__csize_4__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 1 -cache:il1 il1:1:4:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_1_1__csize_4__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:1, mod:1, nbank:1, benchs:[1, 1], csize:8Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 1 1 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_1_1__csize_8__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_1_1__csize_8__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 1 -cache:il1 il1:1:8:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_1_1__csize_8__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:1, mod:1, nbank:1, benchs:[1, 1], csize:16Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 1 1 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_1_1__csize_16__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_1_1__csize_16__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 1 -cache:il1 il1:1:16:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_1_1__csize_16__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:1, mod:1, nbank:1, benchs:[1, 1], csize:32Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 1 1 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_1_1__csize_32__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_1_1__csize_32__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 1 -cache:il1 il1:1:32:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_1_1__csize_32__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:1, mod:1, nbank:1, benchs:[1, 1], csize:64Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 1 1 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_1_1__csize_64__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_1_1__csize_64__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 1 -cache:il1 il1:1:64:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_1_1__csize_64__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:1, mod:1, nbank:1, benchs:[1, 1], csize:128Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 1 1 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_1_1__csize_128__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_1_1__csize_128__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 1 -cache:il1 il1:1:128:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_1_1__csize_128__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:1, mod:1, nbank:1, benchs:[1, 1], csize:256Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 1 1 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_1_1__csize_256__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_1_1__csize_256__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 1 -cache:il1 il1:1:256:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_1_1__csize_256__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:1, mod:1, nbank:1, benchs:[9, 9], csize:4Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 9 9 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_9_9__csize_4__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_9_9__csize_4__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 1 -cache:il1 il1:1:4:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_9_9__csize_4__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:1, mod:1, nbank:1, benchs:[9, 9], csize:8Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 9 9 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_9_9__csize_8__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_9_9__csize_8__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 1 -cache:il1 il1:1:8:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_9_9__csize_8__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:1, mod:1, nbank:1, benchs:[9, 9], csize:16Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 9 9 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_9_9__csize_16__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_9_9__csize_16__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 1 -cache:il1 il1:1:16:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_9_9__csize_16__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:1, mod:1, nbank:1, benchs:[9, 9], csize:32Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 9 9 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_9_9__csize_32__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_9_9__csize_32__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 1 -cache:il1 il1:1:32:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_9_9__csize_32__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:1, mod:1, nbank:1, benchs:[9, 9], csize:64Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 9 9 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_9_9__csize_64__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_9_9__csize_64__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 1 -cache:il1 il1:1:64:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_9_9__csize_64__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:1, mod:1, nbank:1, benchs:[9, 9], csize:128Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 9 9 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_9_9__csize_128__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_9_9__csize_128__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 1 -cache:il1 il1:1:128:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_9_9__csize_128__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

echo "  Running config: (proc:1, mod:1, nbank:1, benchs:[9, 9], csize:256Kb, bsize:64 bytes, assoc:1, repl:l)."
echo "   Started at: `date`."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/powerSMT 9 9 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_9_9__csize_256__bsize_64__assoc_1__repl_l_sim.out -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_9_9__csize_256__bsize_64__assoc_1__repl_l_prog.out -fastfwd 50000000 -max:inst 300000000 -fetch:width 256 -fetch:ifqsize 256 -decode:width 256 -issue:inorder FALSE -issue:width 256 -commit:width 256 -ruulsq:type distributed -ruu:size 256 -lsq:size 128 -fu:type hetero -res:ialu 32 -res:imult 32 -res:fpalu 32 -res:fpmult 32 -res:memport 32 -bpred:type 2lev -bpred:2lev 1 4096 16 0 -technology TECH_070 -cache:il1_output_width 64 -cache:dl1_output_width 64 -cache:dl2_output_width 64 -tlb:itlb itlb:1024:4096:4:l -tlb:dtlb dtlb:1024:4096:4:l  -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -imodules:num 1 -cache:il1 il1:1:256:64:1:l /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT_impl_v_7/batch/RUN_SPEC2000 > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/dissertacao/CACHE_IL1/30052008202105/proc_1__mod_1__nbank_1__benchs_9_9__csize_256__bsize_64__assoc_1__repl_l_stdout.out
echo "   Finished at: `date`."

