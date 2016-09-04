#!/bin/bash
# Script para o Teste de conformidade dos resultados do powerSMT, simt-wattch.
# Run  benchmarks.
cd /opt/simuladores/benchmarks/SPEC/SPEC2000/inputs-spec2000

echo "Inicio da Execução `date`."

echo "Executando bechmarks (1-1)."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 1 1 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/simout_1.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/progout_1.txt -max:inst 489410582 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

echo "Executando bechmarks (2-2)."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 2 2 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/simout_2.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/progout_2.txt -max:inst 500000002 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

echo "Executando bechmarks (3-3)."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 3 3 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/simout_3.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/progout_3.txt -max:inst 404566663 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

echo "Executando bechmarks (4-4)."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 4 4 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/simout_4.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/progout_4.txt -max:inst 487163648 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

echo "Executando bechmarks (5-5)."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 5 5 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/simout_5.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/progout_5.txt -max:inst 451061631 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

echo "Executando bechmarks (6-6)."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 6 6 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/simout_6.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/progout_6.txt -max:inst 388255422 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

echo "Executando bechmarks (7-7)."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 7 7 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/simout_7.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/progout_7.txt -max:inst 490363765 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

echo "Executando bechmarks (8-8)."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 8 8 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/simout_8.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/progout_8.txt -max:inst 431045010 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

echo "Executando bechmarks (9-9)."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 9 9 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/simout_9.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/progout_9.txt -max:inst 500000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

echo "Executando bechmarks (10-10)."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 10 10 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/simout_10.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/progout_10.txt -max:inst 495612422 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

echo "Executando bechmarks (11-11)."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 11 11 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/simout_11.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/progout_11.txt -max:inst 422609171 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

echo "Executando bechmarks (12-12)."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 12 12 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/simout_12.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/progout_12.txt -max:inst 441333708 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

echo "Executando bechmarks (13-13)."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 13 13 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/simout_13.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/progout_13.txt -max:inst 436714537 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

echo "Executando bechmarks (14-14)."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 14 14 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/simout_14.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/progout_14.txt -max:inst 202757478 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

echo "Executando bechmarks (15-15)."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 15 15 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/simout_15.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/progout_15.txt -max:inst 451218380 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

echo "Executando bechmarks (16-16)."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 16 16 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/simout_16.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade01_1_1/progout_16.txt -max:inst 241437719 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 1 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -issue:inorder FALSE -issue:width 16 -ruulsq:type distributed -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000

echo "Término da Execução `date`."