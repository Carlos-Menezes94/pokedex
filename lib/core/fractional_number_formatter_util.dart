class FractionalNumberFormatterUtil {
  static String format(int number) {
    double result = number / 10;
    String formattedNumber = result.toStringAsFixed(2).replaceAll('.', ',');
    return formattedNumber;
  }
}
