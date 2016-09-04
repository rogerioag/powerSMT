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


