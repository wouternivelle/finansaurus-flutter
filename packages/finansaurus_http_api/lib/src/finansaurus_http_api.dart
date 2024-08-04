import 'dart:convert';

import 'package:authenticated_http_client/authenticated_http_client.dart';
import 'package:finansaurus_api/finansaurus_api.dart';

class FinansaurusHttpApi extends FinansaurusApi {
  FinansaurusHttpApi({required this.baseUrl});

  String baseUrl;

  @override
  Future<void> deletePayee(int id) async {
    final response =
        await AuthenticatedHttpClient().delete('$baseUrl/accounts/$id');

    if (response.statusCode != 204) {
      throw AccountException();
    }
  }

  @override
  Future<List<Payee>> getPayees() async {
    final response = await AuthenticatedHttpClient().get('$baseUrl/payees');
    final responseAsJson = jsonDecode(response.body) as Map<String, dynamic>;
    final payees = responseAsJson['_embedded']['payees'] as List<dynamic>;

    if (response.statusCode == 200) {
      return payees
          .map((payee) => Payee.fromJson(payee as Map<String, dynamic>))
          .toList();
    } else {
      throw PayeeException();
    }
  }

  @override
  Future<void> savePayee(Payee payee) async {
    final response = await AuthenticatedHttpClient()
        .post('$baseUrl/payees', payee.toJson());

    if (response.statusCode != 200) {
      throw PayeeException();
    }
  }

  @override
  Future<void> deleteAccount(int id) async {
    final response =
        await AuthenticatedHttpClient().delete('$baseUrl/accounts/$id');

    if (response.statusCode != 204) {
      throw AccountException();
    }
  }

  @override
  Future<List<Account>> getAccounts() async {
    final response = await AuthenticatedHttpClient().get('$baseUrl/accounts');
    final responseAsJson = jsonDecode(response.body) as Map<String, dynamic>;
    final accounts = responseAsJson['_embedded']['accounts'] as List<dynamic>;

    if (response.statusCode == 200) {
      return accounts
          .map((account) => Account.fromJson(account as Map<String, dynamic>))
          .toList();
    } else {
      throw PayeeException();
    }
  }

  @override
  Future<void> saveAccount(Account account) async {
    final response = await AuthenticatedHttpClient()
        .post('$baseUrl/accounts', account.toJson());

    if (response.statusCode != 200) {
      throw AccountException();
    }
  }

  @override
  Future<void> deleteCategory(int id) async {
    final response =
        await AuthenticatedHttpClient().delete('$baseUrl/categories/$id');

    if (response.statusCode != 204) {
      throw CategoryException();
    }
  }

  @override
  Future<List<Category>> getCategories() async {
    final response =
        await AuthenticatedHttpClient().get('$baseUrl/categories');
    final responseAsJson = jsonDecode(response.body) as Map<String, dynamic>;
    final categories =
        responseAsJson['_embedded']['categories'] as List<dynamic>;

    if (response.statusCode == 200) {
      return categories
          .map(
              (category) => Category.fromJson(category as Map<String, dynamic>))
          .toList();
    } else {
      throw CategoryException();
    }
  }

  @override
  Future<List<Category>> getCategoriesWithoutSystem() async {
    final response =
        await AuthenticatedHttpClient().get('$baseUrl/categories/no-system');
    final responseAsJson = jsonDecode(response.body) as Map<String, dynamic>;
    final categories =
        responseAsJson['_embedded']['categories'] as List<dynamic>;

    if (response.statusCode == 200) {
      return categories
          .map(
              (category) => Category.fromJson(category as Map<String, dynamic>))
          .toList();
    } else {
      throw CategoryException();
    }
  }

  @override
  Future<void> saveCategory(Category category) async {
    final response = await AuthenticatedHttpClient()
        .post('$baseUrl/categories', category.toJson());

    if (response.statusCode != 200) {
      throw CategoryException();
    }
  }

  @override
  Future<void> deleteTransaction(int id) async {
    final response =
        await AuthenticatedHttpClient().delete('$baseUrl/transactions/$id');

    if (response.statusCode != 204) {
      throw TransactionException();
    }
  }

  @override
  Future<TransactionPage> getTransactions(int page, int size) async {
    final response = await AuthenticatedHttpClient()
        .get('$baseUrl/transactions?page=$page&size=$size&sort=date,desc');
    final responseAsJson = jsonDecode(response.body) as Map<String, dynamic>;
    final embedded = responseAsJson['_embedded'];
    final transactions = embedded['transactions'] as List<dynamic>;
    final totalElements = responseAsJson['page']['totalElements'];
    final totalPages = responseAsJson['page']['totalPages'];

    if (response.statusCode == 200) {
      return TransactionPage(
          transactions: transactions
              .map((transaction) =>
                  Transaction.fromJson(transaction as Map<String, dynamic>))
              .toList(),
          size: size,
          page: page,
          totalElements: totalElements,
          totalPages: totalPages);
    } else {
      throw TransactionException();
    }
  }

  @override
  Future<void> saveTransaction(Transaction transaction) async {
    final response = await AuthenticatedHttpClient()
        .post('$baseUrl/transactions', transaction.toJson());

    if (response.statusCode != 200) {
      throw TransactionException();
    }
  }
}
