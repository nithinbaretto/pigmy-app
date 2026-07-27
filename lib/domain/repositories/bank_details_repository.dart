import '../../core/utils/result.dart';
import '../entities/bank_details_entity.dart';

abstract class BankDetailsRepository {
  Future<Result<BankDetailsEntity>> getBankDetails();

  Future<Result<BankDetailsEntity>> updateBankDetails(BankDetailsEntity details);
}
