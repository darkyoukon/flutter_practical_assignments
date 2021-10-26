// feels like interface - most accurate, {} without abstract
abstract class Noiser {
  bool shy = false;

  void speak() {}
}

class Human {
  Human(this.color, this.age);
  Human.createHuman(this.color, this.age);

  final String color;
  final int age;
}

/*
generally to copy some methods when you have already parent extended class
on allows to use mixin within only with such class
and(!) already import that method in class
*/
mixin Walking on Human {
  void walk() => print("Walking through da streets");
}

/* consists of all Human fields and methods - extends and only one
must override all Noiser fields and methods - implements

save class logic (which mustn't implement constructor) - with
(mixin if don't want to use class separately)
 */
class Gender extends Human with Walking implements Noiser {
  Gender(this.sex, {required int age, String color = "default"})
      : super(color, age);
  Gender.createGender(argSex, color, age):
        sex = argSex, super.createHuman(color, age);

  final String sex;

  @override
  void speak() {
    shy ? print("It's my personal business to talk about gender :)")
        : print("I'm $age y.o. human with $sex gender!");
    shy = shy ? shy : true;
  }

  @override
  bool shy = false;
}