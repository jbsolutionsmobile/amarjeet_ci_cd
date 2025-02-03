import 'package:amarjeet_ci_cd/animal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAnimal extends Mock implements Animal{}

void main(){
  late MockAnimal animal;

  setUp(() {
    animal = MockAnimal();
  });

  test("Let's verify the dog behaviour", () {
    when(animal.bark()).thenReturn("Bhaww");

    animal.bark();

    verify(animal.bark());

  });

  test("Let's verify the cat behaviour", () {
    when(animal.meow()).thenReturn("Meowwwww");

    animal.meow();

    verify(animal.meow());

  });
}