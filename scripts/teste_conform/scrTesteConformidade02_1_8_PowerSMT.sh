#!/bin/bash
# Script para o Teste de conformidade dos resultados do powerSMT, simt-wattch.
# Run  benchmarks.
cd /opt/simuladores/benchmarks/SPEC/SPEC2000/inputs-spec2000

echo "Inicio da Execução `date`."

echo "Executando bechmarks (1-8)."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 1 8 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade02_1_8/simout_1_8.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade02_1_8/progout_1_8.txt -max:inst 500000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 2 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type shared -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000  > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade02_1_8/stdout_1_8.out

echo "Executando bechmarks (9-16)."
/home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/powerSMT 9 16 -redir:sim /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade02_1_8/simout_9_16.txt -redir:prog /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade02_1_8/progout_9_16.txt -max:inst 500000000 -cache:il1 il1:1:32:64:4:l -cache:il2 dl2 -cache:dl1 dl1:1:64:64:4:l -cache:dl2 ul2:1:1024:128:8:l -tlb:itlb itlb:256:4096:8:l -tlb:dtlb dtlb:512:4096:8:l -imodules:num 2 -fetch:width 8 -fetch:ifqsize 8 -decode:width 16 -bpred:type forced:100 -issue:inorder FALSE -issue:width 16 -ruulsq:type shared -ruu:size 16 -lsq:size 8 -fu:type hetero -res:ialu 5 -res:imult 2 -res:memport 3 -res:fpalu 5 -res:fpmult 2 -commit:width 16 /home/rogerio/projetos.eclipse/projetos.cpp/powerSMT/RUN_SPEC2000  > /home/rogerio/mestrado/pesquisa/simulacoes/resultados/powerSMT/tstConformidade02_1_8/stdout_9_16.out

echo "Término da Execução `date`."

