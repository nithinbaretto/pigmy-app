import '../../core/utils/result.dart';
import '../../domain/entities/bank_details_entity.dart';
import '../../domain/repositories/bank_details_repository.dart';

class BankDetailsRepositoryImpl implements BankDetailsRepository {
  BankDetailsRepositoryImpl();

  BankDetailsEntity? _cached;

  @override
  Future<Result<BankDetailsEntity>> getBankDetails() async {
    if (_cached != null) return Success(_cached!);
    return const Error(Failure(message: 'Bank details not configured'));
  }

  @override
  Future<Result<BankDetailsEntity>> updateBankDetails(
    BankDetailsEntity details,
  ) async {
    _cached = details;
    return Success(details);
  }
}
