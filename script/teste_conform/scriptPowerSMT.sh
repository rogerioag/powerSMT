#!/bin/bash
# File generated by Script (./powerSMTCommandLines.sh) at 19/11/2007-18:45:39.
# Run  benchmarks.
cd /opt/simuladores/benchmarks/SPEC/SPEC2000/inputs-spec2000

echo "Executando bechmarks (1-1)."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 1 1 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_1.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_1.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 2 2 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_2.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_2.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 3 3 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_3.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_3.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 4 4 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_4.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_4.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 5 5 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_5.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_5.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 6 6 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_6.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_6.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 7 7 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_7.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_7.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 8 8 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_8.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_8.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 9 9 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_9.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_9.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 10 10 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_10.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_10.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 11 11 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_11.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_11.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 12 12 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_12.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_12.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 13 13 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_13.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_13.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 14 14 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_14.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_14.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 15 15 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_15.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_15.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 16 16 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_16.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_16.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 17 17 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_17.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_17.txt -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 18 18 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_18.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_18.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

echo "Executando bechmarks (1-2)."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 1 2 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_1_2.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_1_2.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 2 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 3 4 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_3_4.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_3_4.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 2 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 5 6 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_5_6.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_5_6.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 2 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 7 8 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_7_8.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_7_8.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 2 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 9 10 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_9_10.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_9_10.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 2 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 11 12 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_11_12.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_11_12.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 2 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 13 14 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_13_14.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_13_14.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 2 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 15 16 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_15_16.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_15_16.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 2 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 17 18 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_17_18.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_17_18.txt 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 2 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000


echo "Executando bechmarks (1-4)."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 1 4 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_1_4.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_1_4.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 2 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 5 8 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_5_8.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_5_8.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 2 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 9 12 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_9_12.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_9_12.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 2 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 13 16 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_13_16.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_13_16.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 2 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000


echo "Executando bechmarks (1-8)."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 1 8 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_1_8.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_1_8.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 2 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 9 16 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/simout_9_16.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/19112007184539/progout_9_16.txt -fastfwd 50000000 -max:inst 200000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 2 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000


echo "Término da Execução `date`."
