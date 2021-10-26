import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter/factory_class.dart';

void main() {
  test('Create two objects that have links to one instance in memory', () {
    expect(TestString("dart") == TestString("dart"), equals(true));
  });

  test('Create two objects that have links to diff instances in memory', () {
    expect(TestString("dart") == TestString("dart2"), equals(false));
  });
}
