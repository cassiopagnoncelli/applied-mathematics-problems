#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int
erro(const char *str)
{
  fprintf(stderr, "%s.\n", str);
  return EXIT_FAILURE;
}

int
main(int argc, char **argv)
{
  if (argc != 2)
    return erro("A chamada correta contém exatamente um argumento com a palavra");

  unsigned int tam = strlen(argv[1]);
  char *palavra = malloc((tam+1) * sizeof(char));
  if (!palavra)
    return erro("malloc(): palavra");
  memcpy(palavra, argv[1], tam);

  double *probs = malloc((tam+1) * sizeof(double));
  if (!probs)
    return erro("malloc(): probs");

  double *log_probs = malloc((tam+1) * sizeof(double));
  if (!log_probs)
    return erro("malloc(): log_probs");

  unsigned int *ocorrencias = calloc(tam + 1, sizeof(int));
  if (!ocorrencias)
    return erro("calloc(): ocorrencias");

  unsigned int i, j;
  for (i=0; i<tam; i++)
    for (j=0; j<tam; j++)
      if (palavra[i] == palavra[j])
	ocorrencias[i]++;

  for (i=0; i<tam; i++) {
    probs[i] = (double) ocorrencias[i] / tam;
    log_probs[i] = (double) log(probs[i]) / log(2);
    /*printf("%d: %d %1.3f %1.3f\n", i, ocorrencias[i], probs[i], log_probs[i]);*/
  }

  double entropia = 0;
  for (i=0; i<tam; i++)
    entropia -= probs[i] * log_probs[i];

  printf("%2.5f\n", entropia);

  return EXIT_SUCCESS;
}
