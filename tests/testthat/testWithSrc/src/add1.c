// In C ----------------------------------------
#include <R.h>
#include <Rinternals.h>

SEXP add1(SEXP a) {
  SEXP result = PROTECT(allocVector(REALSXP, 1));
  REAL(result)[0] = asReal(a) + 1;
  UNPROTECT(1);

  return result;
}

SEXP mult2(SEXP a) {
  SEXP result = PROTECT(allocVector(REALSXP, 1));
  REAL(result)[0] = asReal(a) * 2;
  UNPROTECT(1);

  return result;
}
