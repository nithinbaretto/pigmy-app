import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/customer.dart';
import '../repository/customer_repository.dart';
import '../../../shared/providers/repository_providers.dart';

final customersProvider = FutureProvider<List<Customer>>((ref) async {
  final repo = ref.watch(customerRepositoryProvider);
  return repo.getCustomers();
});

final customerSearchProvider =
    StateNotifierProvider<CustomerSearchController, AsyncValue<List<Customer>>>(
  (ref) => CustomerSearchController(ref.watch(customerRepositoryProvider)),
);

final customerByIdProvider =
    FutureProvider.family<Customer?, String>((ref, id) async {
  final repo = ref.watch(customerRepositoryProvider);
  return repo.getCustomerById(id);
});

class CustomerSearchController extends StateNotifier<AsyncValue<List<Customer>>> {
  CustomerSearchController(this._repository) : super(const AsyncValue.loading()) {
    loadCustomers();
  }

  final CustomerRepository _repository;
  String _query = '';

  Future<void> loadCustomers() async {
    state = const AsyncValue.loading();
    try {
      final customers = _query.isEmpty
          ? await _repository.getCustomers()
          : await _repository.searchCustomers(_query);
      state = AsyncValue.data(customers);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> search(String query) async {
    _query = query;
    await loadCustomers();
  }
}
