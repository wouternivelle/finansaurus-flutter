import 'package:finansaurus_api/finansaurus_api.dart';

abstract class FinansaurusApi {
  const FinansaurusApi();

  Future<List<Payee>> getPayees();

  Future<void> savePayee(Payee payee);

  Future<void> deletePayee(int id);

  Future<List<Account>> getAccounts();

  Future<void> saveAccount(Account account);

  Future<void> deleteAccount(int id);

  Future<List<Category>> getCategories();

  Future<List<Category>> getCategoriesWithoutSystem();

  Future<void> saveCategory(Category category);

  Future<void> deleteCategory(int id);

  Future<TransactionPage> getTransactions(int page, int size);

  Future<void> saveTransaction(Transaction transaction);

  Future<void> deleteTransaction(int id);
}

class PayeeNotFoundException implements Exception {}

class PayeeException implements Exception {}

class AccountNotFoundException implements Exception {}

class AccountException implements Exception {}

class CategoryNotFoundException implements Exception {}

class CategoryException implements Exception {}

class TransactionNotFoundException implements Exception {}

class TransactionException implements Exception {}
