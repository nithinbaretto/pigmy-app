import '../model/customer.dart';
import 'customer_repository.dart';

/// In-memory mock customer repository with ~20 sample customers.
class MockCustomerRepository implements CustomerRepository {
  MockCustomerRepository() {
    _customers = _generateMockCustomers();
  }

  late List<Customer> _customers;

  static List<Customer> _generateMockCustomers() {
    const names = [
      'Vinayak Manvi',
      'Sumith G',
      'Hemavathi',
      'Siddharth',
      'Pooja',
      'Aniket',
      'Ananya',
      'Vikram',
      'Aditya',
      'Niharika',
      'Rakesh Palla',
      'Priya Sharma',
      'Karthik Reddy',
      'Meera Nair',
      'Arjun Desai',
      'Deepa Rao',
      'Sanjay Kumar',
      'Lakshmi Devi',
      'Rahul Verma',
      'Kavya Iyer',
    ];

    return List.generate(names.length, (index) {
      final isFirst = index == 0;
      return Customer(
        id: 'cust_${index + 1}',
        pigmyNumber: isFirst ? 'PC00001000000352' : 'MG000010005007L',
        customerName: names[index],
        phone: '98765${(43210 + index).toString().padLeft(5, '0')}',
        address: '${index + 1}, MG Road, Bangalore',
        openingBalance: 5000 + (index * 250),
        todayDue: 500,
        status: 'active',
        openDate: DateTime(2014, 9, 4),
      );
    });
  }

  @override
  Future<List<Customer>> getCustomers() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_customers);
  }

  @override
  Future<Customer?> getCustomerById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    try {
      return _customers.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Customer>> searchCustomers(String query) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    if (query.isEmpty) return getCustomers();
    final lower = query.toLowerCase();
    return _customers
        .where(
          (c) =>
              c.customerName.toLowerCase().contains(lower) ||
              c.pigmyNumber.toLowerCase().contains(lower),
        )
        .toList();
  }

  @override
  Future<void> updateCustomerBalance(String customerId, double newBalance) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    final index = _customers.indexWhere((c) => c.id == customerId);
    if (index != -1) {
      _customers[index] = _customers[index].copyWith(openingBalance: newBalance);
    }
  }
}
