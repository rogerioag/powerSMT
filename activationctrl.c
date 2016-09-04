/* 
 * activation.c - Activation control routines for PowerSMT Simulator
 * 
 * This simulator was developed by Rogerio A. Goncalves using the
 * SS_SMT simulator 1.0 and Sim-Wattch 1.02 Power Model.
 * 
 * This work was done as part of his Master Thesis under guidance of
 * Dr. Ronaldo A. L. Goncalves professor at Informatics Department in 
 * the State University of Maringa - Parana - Brazil.
 * 
 * The original SS_SMT.C was modified with adding of Wattch Power Model modified, 
 * Wattch is a framework was developed by David Brooks
 */

/* Activation Control  */
//	struct ctrl_ativacao_t *ctrl_ativacao;
/* Activation Control  */

#include "activationctrl.h"

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <assert.h>
#include <signal.h>
#include <ctype.h>
#include <errno.h>

/*
 * Create the Activation Control.
 */
struct activationctrl_t *activationctrl_create() {

	struct activationctrl_t *actctrl;
	
	return actctrl;	
}

 
   // Activation Control
// Inicializa o Controle de Ativação

//if(b_create_ctrl_act) {
//	// fprintf(stderr,"Init Activation Control to Cache %s \n", cp->name);
//	// initActivationControl(cp, line_act_latency);
//	int ind = 0;
//
//	fprintf(stderr,"Alocando %s->ctrl_ativacao->lines_activation\n", cp->name);
//	struct ctrl_elem_t **nwLinesAtivacao = (struct ctrl_elem_t **) calloc(cp->nsets, sizeof(struct ctrl_elem_t*));
//
//	if (!nwLinesAtivacao)
//	fprintf(stderr,"out of virtual memory to allocate nwLinesAtivacao\n");
//
//	fprintf(stderr,"Inicializando %s->ctrl_ativacao->lines_activation\n", cp->name);
//
// Inicializa a estrutura
//	for (ind=0; ind < cp->nsets; ind++) {
//		struct ctrl_elem_t *nwElem = (struct ctrl_elem_t *) calloc(1, sizeof(struct ctrl_elem_t));
//		nwElem->ativado = FALSE;
//		nwLinesAtivacao[ind] = nwElem;
//	}
//
//	struct ctrl_ativacao_t *nwCtrlAtivacao = (struct ctrl_ativacao_t *) calloc(1, sizeof(struct ctrl_ativacao_t));
//
//	if (!nwCtrlAtivacao)
//	fprintf(stderr,"out of virtual memory to allocate nwCtrlAtivacao\n");
//
//	nwCtrlAtivacao->lines_activation = nwLinesAtivacao;
//	nwCtrlAtivacao->tryAccessInInactiveMode = 0;
//	nwCtrlAtivacao->tryActivateActivatedLine = 0;
//	nwCtrlAtivacao->tryDeactivateDeactivatedLine = 0;
//
//	nwCtrlAtivacao->last_address = 0;
//	nwCtrlAtivacao->activation_errors = 0;
//
// Inicializa a line activation latency 
//	nwCtrlAtivacao->line_act_latency = line_act_latency;
//
//	nwCtrlAtivacao->numActiveLines = 0;
//	nwCtrlAtivacao->is_valid_last_address = FALSE;
//
//	cp->ctrl_ativacao = nwCtrlAtivacao;
//
//	if (!cp->ctrl_ativacao->lines_activation)
//	fprintf(stderr,"out of virtual memory to allocate %s->ctrl_ativacao->lines_activation\n", cp->name);
//
// Aloca o registro para armazenamento de informações sobre o conjunto de linhas ativas
// O global e os números acima do ideal 2
	 
//	struct ctrl_register_t *registro = (struct ctrl_register_t *) calloc(1, sizeof(struct ctrl_register_t));
//
//	registro->acumNumActiveLines = 0;
//	registro->acumNumActiveLinesOverIdeal = 0;
//	registro->divisorActiveLines = 0;
//	registro->divisorActiveLinesOverIdeal = 0;
//
//	cp->ctrl_ativacao->regActiveLinesSet = registro;
//
//}
//else {
//	cp->ctrl_ativacao = NULL;
//}
//
// Activation Control 
//
// Utilização 
//
// Line Activation Control 
// Se esta definido um controle de ativacao para a cache 
//if(cp->ctrl_ativacao) {
//	// fprintf(stdout,"Acessando controle de ativacao.\n");
//
//	// Ativação do Atual e do Proximo movido para o final.
//
	// Desativa a anterior 
	// Recupera o numero do ultimo conjunto acessado 
//
//	// fprintf(stderr, "Last_address: %d\n", cp->ctrl_ativacao->last_address);
//
	// Se ja teve um acesso e o ultimo endereco é valido para ser desativado 
//	if(cp->ctrl_ativacao->is_valid_last_address) {
//
//		md_addr_t conjAnt = CACHE_SET(cp, cp->ctrl_ativacao->last_address);
//		if(conjAnt != set) {
//			if(cp->ctrl_ativacao->lines_activation[conjAnt]->ativado) {
//				// fprintf(stderr, "Desativando: %d\n", conjAnt);
//				cp->ctrl_ativacao->lines_activation[conjAnt]->ativado = FALSE;
//				cp->ctrl_ativacao->numActiveLines -= 1;
//			} else {
//				cp->ctrl_ativacao->tryDeactivateDeactivatedLine++;
//			}
//		}
//
//		// Desativa o proximo do anterior.
		// Se o conjunto atual não é o proximo desejado, o proximo do anterior
		//	Ocorreu um erro na ativação. A quantidade de erros deve ser igual ao número de linhas ativas 
//		md_addr_t proximoAdjacenteDoAnterior = incrementoCircular(conjAnt, cp->nsets);
//
//		if((set != conjAnt) && (set != proximoAdjacenteDoAnterior)) {
//			cp->ctrl_ativacao->activation_errors++;
//
//			// Desativa o proximo adjacente determinado pelo algoritmo para o anterior
//			// fprintf(stderr, "Desativando proximoAdjacenteDoAnterior: %d\n", proximoAdjacenteDoAnterior);
//			cp->ctrl_ativacao->lines_activation[proximoAdjacenteDoAnterior]->ativado = FALSE;
//			cp->ctrl_ativacao->numActiveLines -= 1;
//			// Não desativar ainda, primeiro algoritmo não desativa
//		}
//	}
//
	// Ativa a corrente 
	// Se a linha corrente está desativada 
//	if(!cp->ctrl_ativacao->lines_activation[set]->ativado) {
//		// Ativa a linha corrente 
//		// fprintf(stderr, "Ativando: %d\n", set);
//		cp->ctrl_ativacao->lines_activation[set]->ativado = TRUE;
//		cp->ctrl_ativacao->numActiveLines += 1;
//		// Acrescenta a penalidade 
//		lat += cp->ctrl_ativacao->line_act_latency;
//		cp->ctrl_ativacao->tryAccessInInactiveMode++;
//	}
//
	// Ativa a proxima 
//	md_addr_t conjProximoAdjacente = incrementoCircular(set, cp->nsets);
//	if(!cp->ctrl_ativacao->lines_activation[conjProximoAdjacente]->ativado) {
//		// fprintf(stderr, "Ativando Prox: %d\n", conjProximoAdjacente);
//		cp->ctrl_ativacao->lines_activation[conjProximoAdjacente]->ativado = TRUE;
//		cp->ctrl_ativacao->numActiveLines += 1;
//	} else {
//		cp->ctrl_ativacao->tryActivateActivatedLine++;
//	}
//
	// Armazena o ultimo endereco acessado 
//	cp->ctrl_ativacao->last_address = addr;
//
//	// Seta o last address como válido para as desativacoes 
//	// fprintf(stderr, "Antes is valid Last_address: %d\n", cp->ctrl_ativacao->is_valid_last_address);
//	cp->ctrl_ativacao->is_valid_last_address = TRUE;
//	// fprintf(stderr, "Depois is valid Last_address: %d\n", cp->ctrl_ativacao->is_valid_last_address);
//
//	registrarAcessoConjunto(cp, set);
//
//}
// Line Activation Control 
// Activation Control 
//
// Inicializa o controle de ativação 
////void initActivationControl(struct cache_t *cache, unsigned int line_act_latency){
////	
////	  int ind = 0;
////	  
////	  fprintf(stderr,"Alocando %s->ctrl_ativacao->lines_activation\n", cache->name);
////	  struct ctrl_elem_t **nwLinesAtivacao = (struct ctrl_elem_t **) calloc(cache->nsets, sizeof(struct ctrl_elem_t*));
////	  
////	  if (!nwLinesAtivacao)
////	  	 fprintf(stderr,"out of virtual memory to allocate nwLinesAtivacao\n");
////	  
////	  fprintf(stderr,"Inicializando %s->ctrl_ativacao->lines_activation\n", cache->name);
////	  	    
////	  // Inicializa a estrutura  
////	  for (ind=0; ind < cache->nsets; ind++){
////	   	struct ctrl_elem_t *nwElem = (struct ctrl_elem_t *) calloc(1, sizeof(struct ctrl_elem_t));
////	   	nwElem->ativado = FALSE;
////	   	nwLinesAtivacao[ind] = nwElem;
////	  }	  
////	  
////	  struct ctrl_ativacao_t *nwCtrlAtivacao = (struct ctrl_ativacao_t *) calloc(1, sizeof(struct ctrl_ativacao_t));
////	  
////	  if (!nwCtrlAtivacao)
////	  	 fprintf(stderr,"out of virtual memory to allocate nwCtrlAtivacao\n");
////	  
////	  nwCtrlAtivacao->lines_activation = nwLinesAtivacao;
////	  nwCtrlAtivacao->tryAccessInInactiveMode = 0;
////	  nwCtrlAtivacao->tryActivateActivatedLine = 0;
////	  nwCtrlAtivacao->tryDeactivateDeactivatedLine = 0;
////	  
////	  nwCtrlAtivacao->last_address = 0;
////	  nwCtrlAtivacao->activation_errors = 0;
////	  
////	  // Inicializa a line activation latency 
////	  nwCtrlAtivacao->line_act_latency = line_act_latency;
////	  
////	  cache->ctrl_ativacao = nwCtrlAtivacao;
////	  
////	  if (!cache->ctrl_ativacao->lines_activation)
////	  	fprintf(stderr,"out of virtual memory to allocate %s->ctrl_ativacao->lines_activation\n", cache->name);
////	  
////	  // Aloca o registro para armazenamento de informações sobre o conjunto de linhas ativas
////	   * O global e os números acima do ideal 2
////	   
////	  struct ctrl_register_t *registro = (struct ctrl_register_t *) calloc(1, sizeof(struct ctrl_register_t));
////	  
////	  registro->acumNumActiveLines = 0;
////	  registro->acumNumActiveLinesOverIdeal = 0;
////	  registro->divisorActiveLines = 0;
////	  registro->divisorActiveLinesOverIdeal = 0;
////	  
////	  cache->ctrl_ativacao->regActiveLinesSet = registro;
////	  
////}
//
//
// Activation Controle 
//   

  

