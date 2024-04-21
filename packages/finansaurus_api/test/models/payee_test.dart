// ignore_for_file: prefer_const_constructors
import 'package:finansaurus_api/finansaurus_api.dart';
import 'package:test/test.dart';

void main() {
  group('Payee', () {
    const id = 1;
    const name = 'mock-name';
    const lastCategoryId = 123;

    test('copyWith with filled values returns the filled values', () {
      final payee = Payee(id: id, name: name, lastCategoryId: lastCategoryId);
      final copiedPayee =
          payee.copyWith(id: 2, name: 'mock-name-2', lastCategoryId: 456);

      expect(copiedPayee.id, 2);
      expect(copiedPayee.name, 'mock-name-2');
      expect(copiedPayee.lastCategoryId, 456);
    });

    test('copyWith with empty values returns the original values', () {
      final payee = Payee(id: id, name: name, lastCategoryId: lastCategoryId);
      final copiedPayee = payee.copyWith();

      expect(copiedPayee, payee);
    });

    test('fromJson returns a Payee', () {
      final json = {
        'id': id,
        'name': name,
        'lastCategoryId': lastCategoryId
      };
      final payee = Payee(id: id, name: name, lastCategoryId: lastCategoryId);

      expect(Payee.fromJson(json), payee);
    });

    test('toJson returns json for the Payee', () {
      final json = {
        'id': id,
        'name': name,
        'lastCategoryId': lastCategoryId
      };
      final payee = Payee(id: id, name: name, lastCategoryId: lastCategoryId);

      expect(payee.toJson(), json);
    });
  });
}
