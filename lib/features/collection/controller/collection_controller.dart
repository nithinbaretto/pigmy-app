import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/collection_entity.dart';
import '../../../shared/providers/providers.dart';
import '../model/collection_form_state.dart';
import '../repository/collection_feature_repository.dart';

final collectionFeatureRepositoryProvider =
    Provider<CollectionFeatureRepository>((ref) {
  return CollectionFeatureRepository(ref.watch(collectionRepositoryProvider));
});

class CollectionListState {
  const CollectionListState({
    this.collections = const [],
    this.isLoading = false,
    this.error,
  });

  final List<CollectionEntity> collections;
  final bool isLoading;
  final String? error;

  CollectionListState copyWith({
    List<CollectionEntity>? collections,
    bool? isLoading,
    String? error,
  }) {
    return CollectionListState(
      collections: collections ?? this.collections,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class CollectionListController extends StateNotifier<CollectionListState> {
  CollectionListController(this._repository, this._type)
      : super(const CollectionListState());

  final CollectionFeatureRepository _repository;
  final CollectionType _type;

  Future<void> loadCollections() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final collections = await _repository.getCollections(_type);
      state = state.copyWith(collections: collections, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final collectionListControllerProvider = StateNotifierProvider.autoDispose
    .family<CollectionListController, CollectionListState, CollectionType>(
  (ref, type) {
    final controller = CollectionListController(
      ref.watch(collectionFeatureRepositoryProvider),
      type,
    );
    controller.loadCollections();
    return controller;
  },
);

class CollectionFormController extends StateNotifier<CollectionFormState> {
  CollectionFormController(this._repository, this._type)
      : super(const CollectionFormState());

  final CollectionFeatureRepository _repository;
  final CollectionType _type;

  void updateAccountNumber(String value) =>
      state = state.copyWith(accountNumber: value);
  void updateCustomerName(String value) =>
      state = state.copyWith(customerName: value);
  void updateCustomerMobile(String value) =>
      state = state.copyWith(customerMobile: value);
  void updateAmount(String value) => state = state.copyWith(amount: value);
  void updateRemarks(String value) => state = state.copyWith(remarks: value);

  Future<CollectionEntity?> submit() async {
    state = state.copyWith(isSubmitting: true, error: null);
    try {
      final entity = await _repository.createCollection(state.toEntity(_type));
      state = state.copyWith(isSubmitting: false);
      return entity;
    } catch (e) {
      state = state.copyWith(isSubmitting: false, error: e.toString());
      return null;
    }
  }
}

final collectionFormControllerProvider = StateNotifierProvider.autoDispose
    .family<CollectionFormController, CollectionFormState, CollectionType>(
  (ref, type) {
    return CollectionFormController(
      ref.watch(collectionFeatureRepositoryProvider),
      type,
    );
  },
);
