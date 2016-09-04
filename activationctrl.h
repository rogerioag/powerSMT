/* 
 * activation.h - Activation control routines for PowerSMT Simulator
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

#ifndef ACTIVATIONCTRL_H
#define ACTIVATIONCTRL_H

#include <stdio.h>

#include "host.h"
#include "misc.h"
#include "machine.h"
/* Activation Control */

/* Estrutura para os elementos */
struct elemctrl_t
{
	short int ativado;
};

/* Registro para armazenar os valores do tamanho do conjunto de linhas ativas, 
 * e o tamanho do conjunto de linhas ativas acima do ideal que é 2 */
struct registerctrl_t
{
	quad_t acumNumActiveLines;
	quad_t acumNumActiveLinesOverIdeal;
	quad_t divisorActiveLines;
	quad_t divisorActiveLinesOverIdeal;	
};

struct activationctrl_t
{ 
  /* Latência para a ativar uma linha */
  unsigned int line_act_latency;
  
  /* Ponteiro para a alocação do array de ponteiros para as tuplas */
  struct elemctrl_t **lines_activation;
  
  counter_t numActiveLines; /* Número de linhas ativas, para nao ficar tendo de varrer a estrutura a t o d o ciclo */
  
  /* Contador para as tentativas de acesso quando a linha estava desligada */
  counter_t tryAccessInInactiveMode;

  /* Contador para as tentativas de ativar uma linha já ativada */
  counter_t tryActivateActivatedLine;
  
  /* Contador para as tentativas de desativar uma linha já desativada */
  counter_t tryDeactivateDeactivatedLine;
  
  md_addr_t last_address;	/* last set accessed */
  
  short int is_valid_last_address; /* Marca como o ultimo endereço setado como válido para ser desativado */
  
  counter_t activation_errors; /* quantidade de erros de ativacao */
  
  // md_addr_t last_set_proxAdj; /* O ultimo conjunto proximo Adjacente */

  // Registro para as informações do conjunto de linhas ativas.
  struct registerctrl_t *regActiveLinesSet;
  
};


/* Functions */
struct activationctrl_t *activationctrl_create();

/* Activation Control */

#endif /*ACTIVATIONCTRL_H*/
