enum PrintSize {
  normal(0),
  normalBold(1),
  mediumBold(2),
  largeBold(3);

  final int val;
  const PrintSize(this.val);
}

enum PrintAlign {
  left(0),
  center(1),
  right(2);

  final int val;
  const PrintAlign(this.val);
}
