import 'dart:math';

class TestString {
  String _testName;
  int checkStatic = Random().nextInt(99999);

  TestString.initName(this._testName); // named constructor
  static TestString app = TestString.initName("");

  factory TestString(String sameName) {
    return app = app._testName != sameName
        ? TestString.initName(sameName) : app; // ternary operator
  }

  int showCheckStatic() {
    return checkStatic;
  }
}