#include <stdio.h>
#include <stdarg.h>
#include <gmp.h>
#define TRUE 1
#define FALSE 0
  typedef struct mk
{
  mpz_t m;
  unsigned long int k;
} mk_t;
/* Function prototypes (Miller-Rabin) */
mk_t get_mk (mpz_t);
int millerrabin (mpz_t);
int mrcore (mpz_t, mpz_t, unsigned long int, unsigned long int, mpz_t, mpz_t,
	    mpz_t, mpz_t);
int in_array (mpz_t, unsigned long int *, int);
/* Function prototype (Fermat) */
int fermat (mpz_t);
/* Function implementations */
/* n must be an odd integer */
mk_t
get_mk (mpz_t n)
{
  unsigned long int k = 1;
  unsigned long int pow2 = 2;
  mpz_t quot;
  mpz_t n_cpy;
  mk_t mk;
  mpz_init (quot);
  mpz_init (n_cpy);
  mpz_init (mk.m);
/* Do not clobber the value of n */
  mpz_set (n_cpy, n);
/* n_cpy-- */
  mpz_sub_ui (n_cpy, n_cpy, 1);
/* n_cpy div pow2 and get the quotient */
  mpz_cdiv_q_ui (quot, n_cpy, pow2);
  while (mpz_even_p (quot))
    {
      pow2 *= 2;
      k++;
      mpz_cdiv_q_ui (quot, n_cpy, pow2);
    }
  mpz_set (mk.m, quot);
  mk.k = k;
/* Free up no longer used stuffs */
  mpz_clear (n_cpy);
  return mk;
}

int
mrcore (mpz_t min_one,
	mpz_t a,
	unsigned long int a_given,
	unsigned long int k, mpz_t b0, mpz_t b, mpz_t m, mpz_t n)
{
  unsigned long int i;
/* Choose a random integer a with 1 < a < n-1 */
  mpz_set_ui (a, a_given);
/* Compute b0 = a^m mod n */
  mpz_powm (b0, a, m, n);
/* If b0 = +/- 1 mod n, then n is probably prime */
  if (mpz_cmp_ui (b0, 1) == 0 || mpz_cmp (b0, min_one) == 0)
    {
      return TRUE;
    }
/* b = b0 */
  mpz_set (b, b0);
  for (i = 1; i <= k - 1; i++)
    {
      mpz_powm_ui (b, b, 2, n);
      if (mpz_cmp_ui (b, 1) == 0)
	{
	  return FALSE;
	}
      else if (mpz_cmp (b, min_one) == 0)
	{
	  return TRUE;
	}
    }
  return FALSE;
}

int
millerrabin (mpz_t n)
{
  const int SIZE = 30;
  mk_t mk;
  mpz_t a, b0, b, m, min_one;
  unsigned long int k;
  unsigned long int as[] = { 2, 3, 5, 7, 11,
    13, 17, 19, 23, 29,
    31, 37, 41, 43, 47,
    53, 59, 61, 67, 71,
    73, 79, 83, 89, 97,
    101, 103, 107, 109, 113
  };
  int mr_rslt = TRUE;
  int i;
  mpz_init (a);
  mpz_init (b0);
  mpz_init (b);
  mpz_init (m);
  mpz_init (min_one);
/* Check for all the a's, if it is one of the a's, it's automatically a
* prime.
*/
  if (in_array (n, as, SIZE))
    {
      return TRUE;
    }
/* Let n > 1 be an odd integer */
  if (mpz_cmp_ui (n, 1) <= 0)
    {
      return FALSE;
    }
  if (mpz_even_p (n))
    {
      return FALSE;
    }
/* Write n - 1 = 2^k * m where m is odd */
  mk = get_mk (n);
  mpz_set (m, mk.m);
  k = mk.k;
/* Compute n-1 which is -1 */
  mpz_sub_ui (min_one, n, 1);
/* Call mrcore for a = first 30 primes */
  for (i = 0; i < SIZE; i++)
    {
      mr_rslt = mr_rslt && mrcore (min_one, a, as[i], k, b0, b, m, n);
      if (!mr_rslt)
	{
	  return FALSE;
	}
    }
  return mr_rslt;
}

int
in_array (mpz_t needle, unsigned long int *arr, int arr_sz)
{
  int i;
  for (i = 0; i < arr_sz; i++)
    {
      if (mpz_cmp_ui (needle, arr[i]) == 0)
	{
	  return TRUE;
	}
    }
  return FALSE;
}

int
fermat (mpz_t n)
{
  unsigned long int i, a;
  mpz_t g, fer, base, exp1;
  i = 0;
  a = 2;
  mpz_init (g);
  mpz_init (fer);
  mpz_init (base);
  mpz_init (exp1);
  while (i < 10)
    {
      mpz_gcd_ui (g, n, a);
      if (mpz_cmp_ui (g, 1) == 0)
	{
	  i++;
	  mpz_set_ui (base, a);
	  mpz_sub_ui (exp1, n, 1);
	  mpz_powm (fer, base, exp1, n);
	  if (mpz_cmp_ui (fer, 1) != 0)
	    {
	      return FALSE;
	    }
	}
      a++;
    }
  if (mpz_cmp_ui (fer, 1) == 0)
    {
      return TRUE;
    }
}

int
main ()
{
  mpz_t n;
  mpz_init (n);
  printf ("Miller-Rabin/Fermat Primality Testing\n");
  printf ("Enter a number: ");
  gmp_scanf ("%Zd", n);
  printf ("Miller-Rabin says: %s\n",
	  millerrabin (n) ? "probably a prime..." : "not a prime.");
  printf ("Fermat says: %s\n",
	  fermat (n) ? "probably a prime..." : "not a prime.");
  return 0;
}
