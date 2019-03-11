void g(int d);

void f(float c) {
  int a = 2;
  if (c > 42.0)
    return;
  if (c > 0.0)
    a = 0;
  if (-3.14*c*c > 0)
    g(3 / a); // division by zero
}

/*
 * Ranges of symbol values:
 * (empty)
 */
