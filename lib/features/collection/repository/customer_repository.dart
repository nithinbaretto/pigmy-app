import '../model/customer.dart';

/// Abstract customer repository — swap [MockCustomerRepository] with API impl later.
abstract class CustomerRepository {
  Future<List<Customer>> getCustomers();
  Future<Customer?> getCustomerById(String id);
  Future<List<Customer>> searchCustomers(String query);
  Future<void> updateCustomerBalance(String customerId, double newBalance);
}
