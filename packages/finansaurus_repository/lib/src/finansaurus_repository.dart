import 'package:finansaurus_api/finansaurus_api.dart';

class FinansaurusRepository {
  const FinansaurusRepository({required FinansaurusApi finansaurusApi})
      : _finansaurusApi = finansaurusApi;

  final FinansaurusApi _finansaurusApi;

  /**
   * PAYEES
   */
  Future<List<Payee>> getPayees() => _finansaurusApi.getPayees();

  Future<void> savePayee(Payee payee) => _finansaurusApi.savePayee(payee);

  Future<void> deletePayee(int id) => _finansaurusApi.deletePayee(id);

  /**
   * ACCOUNTS
   */
  Future<List<Account>> getAccounts() => _finansaurusApi.getAccounts();

  Future<void> saveAccount(Account account) =>
      _finansaurusApi.saveAccount(account);

  Future<void> deleteAccount(int id) => _finansaurusApi.deleteAccount(id);

  /**
   * CATEGORIES
   */
  Future<List<Category>> getCategories() => _finansaurusApi.getCategories();

  Future<List<Category>> getCategoriesWithoutSystem() =>
      _finansaurusApi.getCategoriesWithoutSystem();

  Future<void> saveCategory(Category category) =>
      _finansaurusApi.saveCategory(category);

  Future<void> deleteCategory(int id) => _finansaurusApi.deleteCategory(id);

  /**
   * TRANSACTIONS
   */
  Future<TransactionPage> getTransactions(int page, int size) =>
      _finansaurusApi.getTransactions(page, size);

  Future<void> saveTransaction(Transaction transaction) =>
      _finansaurusApi.saveTransaction(transaction);

  Future<void> deleteTransaction(int id) =>
      _finansaurusApi.deleteTransaction(id);
}
