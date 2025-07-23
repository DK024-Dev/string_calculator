// String Calculator TDD Kata in Dart

int add(String numbers) {
  if (numbers.isEmpty) return 0;

  String delimiter = ',';
  if (numbers.startsWith('//')) {
    int newlineIndex = numbers.indexOf('\n');
    delimiter = numbers.substring(2, newlineIndex);
    numbers = numbers.substring(newlineIndex + 1);
  }

  numbers = numbers.replaceAll('\n', delimiter);
  var parts = numbers.split(delimiter).where((e) => e.isNotEmpty).toList();
  var values = parts.map(int.parse).where((n) => n <= 1000).toList();

  var negatives = values.where((n) => n < 0).toList();
  if (negatives.isNotEmpty) {
    throw Exception('negatives not allowed ${negatives.join(",")}');
  }

  return values.fold(0, (sum, n) => sum + n);
}

void main() {
  // Test cases
  assert(add("") == 0);
  assert(add("1") == 1);
  assert(add("1,5") == 6);
  assert(add("1,2,3,4") == 10);
  assert(add("1\n2,3") == 6);
  assert(add("//;\n1;2") == 3);
  assert(add("2,1001") == 2);

  try {
    add("1,-2,-3");
  } catch (e) {
    assert(e.toString().contains("negatives not allowed -2,-3"));
  }

  print("All tests passed!");
}
