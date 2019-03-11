void g(int d);

void f(int *a, int *b) {
  int c = 5;
  if ((a - b) == 0)
    c = 0;
  if (a != b)
    g(3 / c); // division by zero
}

/*
 * Ranges of symbol values:
 * (reg_$0<int *a>) - (reg_$1<int *b>): { [0, 0] }
 * (reg_$1<int *b>) - (reg_$0<int *a>): { [-9223372036854775808, -1],
 *                                        [1, 9223372036854775807] }
 */
