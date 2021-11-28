import 'package:colored/sources/domain/data_models/nameable.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Given a $Nameable", () {
    group("when hashCode is called", () {
      test("then the hashCode is the same as the hascode from the name", () {
        const name = "Test";
        const nameable = Nameable(name);
        expect(nameable.hashCode, name.hashCode);
      });
    });
  });

  group("Given two $Nameable", () {
    group("when checking for equality", () {
      test("two $Nameable are equal if their names are equal", () {
        const firstNameable = Nameable("First");
        const secondNameable = Nameable("First");
        expect(firstNameable == secondNameable, isTrue);
      });

      test("two $Nameable are not equal if their names are not equal", () {
        const firstNameable = Nameable("First");
        const secondNameable = Nameable("Second");
        expect(firstNameable == secondNameable, isFalse);
      });
    });
  });
}
