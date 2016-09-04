#/bin/bash
# Script para o Teste de conformidade dos resultados do powerSMT, simt-wattch.
# Run  benchmarks.

# Keep directory simulator path.
HOME_SIM=`pwd`

# Change to inputs directory, necessary to get benchmarks inputs.
cd /opt/simuladores/benchmarks/SPEC/SPEC2000/inputs-spec2000

echo "Diretorio Inicial da Execução: `pwd`."


echo "Inicio da Execução `date`."

echo "Executando bechmarks (1-1)."

$HOME_SIM/powerSMT 1 1 -config $HOME_SIM/config/config_teste.cfg $HOME_SIM/batch/RUN_TESTE

echo "Executando bechmarks (2-2)."
$HOME_SIM/powerSMT 2 2 -config $HOME_SIM/config/config_teste.cfg $HOME_SIM/batch/RUN_TESTE

echo "Executando bechmarks (3-3)."
$HOME_SIM/powerSMT 3 3 -config $HOME_SIM/config/config_teste.cfg $HOME_SIM/batch/RUN_TESTE

echo "Executando bechmarks (4-4)."
$HOME_SIM/powerSMT 4 4 -config $HOME_SIM/config/config_teste.cfg $HOME_SIM/batch/RUN_TESTE

echo "Executando bechmarks (5-5)."
$HOME_SIM/powerSMT 5 5 -config $HOME_SIM/config/config_teste.cfg $HOME_SIM/batch/RUN_TESTE

echo "Executando bechmarks (6-6)."
$HOME_SIM/powerSMT 6 6 -config $HOME_SIM/config/config_teste.cfg $HOME_SIM/batch/RUN_TESTE

echo "Término da Execução `date`."

