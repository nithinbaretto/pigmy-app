import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/dio_client.dart';
import '../../core/network/network_info.dart';
import '../../core/services/isar_service.dart';
import '../../core/services/secure_storage_service.dart';
import '../../data/datasource/local/collection_local_datasource.dart';
import '../../data/datasource/local/sync_queue_local_datasource.dart';
import '../../data/datasource/local/transaction_local_datasource.dart';
import '../../data/datasource/remote/auth_remote_datasource.dart';
import '../../data/datasource/remote/collection_remote_datasource.dart';
import '../../data/datasource/remote/sync_remote_datasource.dart';
import '../../data/datasource/remote/transaction_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/bank_details_repository_impl.dart';
import '../../data/repositories/collection_repository_impl.dart';
import '../../data/repositories/sync_repository_impl.dart';
import '../../data/repositories/transaction_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/bank_details_repository.dart';
import '../../domain/repositories/collection_repository.dart';
import '../../domain/repositories/sync_repository.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/usecases/create_collection_usecase.dart';
import '../../domain/usecases/get_collections_usecase.dart';
import '../../domain/usecases/get_transactions_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/sync_pending_usecase.dart';
import '../../features/printer/service/printer_service.dart';
import '../../features/sync/service/sync_service.dart';

// ── Data Sources ──────────────────────────────────────────────────────────

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(ref.watch(dioProvider));
});

final collectionRemoteDataSourceProvider =
    Provider<CollectionRemoteDataSource>((ref) {
  return CollectionRemoteDataSourceImpl(ref.watch(dioProvider));
});

final transactionRemoteDataSourceProvider =
    Provider<TransactionRemoteDataSource>((ref) {
  return TransactionRemoteDataSourceImpl(ref.watch(dioProvider));
});

final syncRemoteDataSourceProvider = Provider<SyncRemoteDataSource>((ref) {
  return SyncRemoteDataSourceImpl(ref.watch(dioProvider));
});

final collectionLocalDataSourceProvider =
    Provider<CollectionLocalDataSource>((ref) {
  return CollectionLocalDataSourceImpl(ref.watch(isarServiceProvider));
});

final transactionLocalDataSourceProvider =
    Provider<TransactionLocalDataSource>((ref) {
  return TransactionLocalDataSourceImpl(ref.watch(isarServiceProvider));
});

final syncQueueLocalDataSourceProvider =
    Provider<SyncQueueLocalDataSource>((ref) {
  return SyncQueueLocalDataSourceImpl(ref.watch(isarServiceProvider));
});

// ── Repositories ──────────────────────────────────────────────────────────

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    secureStorage: ref.watch(secureStorageServiceProvider),
  );
});

final collectionRepositoryProvider = Provider<CollectionRepository>((ref) {
  return CollectionRepositoryImpl(
    localDataSource: ref.watch(collectionLocalDataSourceProvider),
    remoteDataSource: ref.watch(collectionRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
});

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return TransactionRepositoryImpl(
    localDataSource: ref.watch(transactionLocalDataSourceProvider),
    remoteDataSource: ref.watch(transactionRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
});

final syncRepositoryProvider = Provider<SyncRepository>((ref) {
  return SyncRepositoryImpl(
    localDataSource: ref.watch(syncQueueLocalDataSourceProvider),
    remoteDataSource: ref.watch(syncRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
});

final bankDetailsRepositoryProvider = Provider<BankDetailsRepository>((ref) {
  return BankDetailsRepositoryImpl();
});

// ── Use Cases ─────────────────────────────────────────────────────────────

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  return LogoutUseCase(ref.watch(authRepositoryProvider));
});

final getCollectionsUseCaseProvider = Provider<GetCollectionsUseCase>((ref) {
  return GetCollectionsUseCase(ref.watch(collectionRepositoryProvider));
});

final createCollectionUseCaseProvider = Provider<CreateCollectionUseCase>((ref) {
  return CreateCollectionUseCase(ref.watch(collectionRepositoryProvider));
});

final getTransactionsUseCaseProvider = Provider<GetTransactionsUseCase>((ref) {
  return GetTransactionsUseCase(ref.watch(transactionRepositoryProvider));
});

final syncPendingUseCaseProvider = Provider<SyncPendingUseCase>((ref) {
  return SyncPendingUseCase(ref.watch(syncRepositoryProvider));
});

// ── Services ──────────────────────────────────────────────────────────────

final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService(
    syncRepository: ref.watch(syncRepositoryProvider),
    networkInfo: ref.watch(networkInfoProvider),
    collectionRepository: ref.watch(collectionRepositoryProvider),
  );
});

final printerServiceProvider = Provider<PrinterService>((ref) {
  return PrinterService(
    secureStorage: ref.watch(secureStorageServiceProvider),
  );
});
