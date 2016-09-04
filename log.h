#ifndef LOG_H_
#define LOG_H_

// #define log 

#ifndef log
	#define LOG(saida, mensagem)   
#else 
	#define LOG(saida, mensagem) fprintf(saida, mensagem); fflush(saida)
#endif

#endif /*LOG_H_*/
