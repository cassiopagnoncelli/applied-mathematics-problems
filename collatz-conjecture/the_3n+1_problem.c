/*   @JUDGE_ID:   108451   100   C   "usando ./cria_problema"   */
/* @BEGIN_OF_SOURCE_CODE */
#include <stdio.h>

int
collatz(int n)
{
  int soma = 1;
  unsigned long long int k = (unsigned long long) n;
  while (1) {
    if (k <= 1)
      return soma;

    if (k % 2 == 1)
      k = 3 * k + 1;
    else
      k = k / 2;

    ++soma;
  }
}

int
max_collatz(int a, int b)
{
  if (a > b)
    return max_collatz(b, a);

  int i, m = 0, c;
  for (i=a; i<=b; i++) {
    c = collatz(i);
    if (c > m)
      m = c;
  }
  return m;
}

int
main()
{
  int a, b;
  while (fscanf(stdin, "%d %d", &a, &b) != EOF) {
    printf("%d %d %d\n", a, b, max_collatz(a, b));
  }

  return 0;
}
/* @END_OF_SOURCE_CODE */
