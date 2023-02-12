
String printIntPrice(int price) {
  String s = '';
  String digits = price.toString();
  int index = digits.length;
  if (index < 3) return digits;

  while (index - 3 >= 0) {
    if (index - 3 == 0) return '${digits.substring(index-3, index)}$s';

    s = '.${digits.substring(index-3, index)}$s';
    index -= 3;
  }
  
  return '${digits.substring(0, index)}$s';
}

String printDoublePrice(double price) {
  if (price == 0) return '0';
  if (price == price.round()) return printIntPrice(price.round());

  int intLegth = price.round().toString().length + 1;
  int totalLength = price.toString().length;
  return '${printIntPrice(price.round())},${price.toString().substring(
    intLegth,
    (totalLength - intLegth > 3) ? intLegth + 3 : null
  )}';
}