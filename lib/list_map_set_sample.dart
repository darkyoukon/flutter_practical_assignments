import 'dart:math';
const String chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

Function createNeededTypeAndReturnFirstNeededElement(int quantity) {
  switch(Random().nextInt(3)) {
    case 0: {
      return (int i) => i < quantity ?
      List.generate(quantity,
              (index) => Random().nextInt(quantity))[i] :
      Exception("nested function argument must be smaller than argument of the creator function");
    }
    case 1: {
      return (int j) => j < quantity ?
      <String>{for (var i = 1; i <= quantity; i++)
        String.fromCharCodes(Iterable.generate(
            quantity, (_) =>
            chars.codeUnitAt(Random().nextInt(chars.length))))}.elementAt(j):
      Exception("nested function argument must be smaller than argument of the creator function");
    }
    case 2: {
      return (int k) => k < quantity ?
      { for (var i = 1; i <= quantity; i++)
        i.toString() : Random().nextInt(quantity) }[k.toString()] :
      Exception("nested function argument must be smaller than argument of the creator function");
    }
  }
  return () => null;
}