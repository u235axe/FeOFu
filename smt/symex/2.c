void g(int d);

void f(int a, int b) {
  int c = 0;
  if (a > 3)
    if (b < 3)
      if (b > a)
        g(5 / c); // division by zero
}

/*
 * Ranges of symbol values:
 * (reg_$0<int a>): { [4, 2147483647] }
 * (reg_$1<int b>): { [-2147483648, 2] }
 */
