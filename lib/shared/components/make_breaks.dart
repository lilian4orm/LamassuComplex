String addCommasToNumber(int number) {
  String result = number.toString();
  String reversed = result.split('').reversed.join();

  Iterable<String> chunks = List.generate(
    (reversed.length / 3).ceil(),
        (i) => reversed.substring(i * 3, (i + 1) * 3 < reversed.length ? (i + 1) * 3 : reversed.length),
  );

  result = chunks.join(',').split('').reversed.join();

  return result;
}