import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/home/domain/entity/product_entity.dart';
import 'package:fresh_kart/features/product/data/datasource/product_data_source.dart';
import 'package:fresh_kart/features/product/data/repository/product_repo_impl.dart';
import 'package:fresh_kart/features/product/domain/repository/product_repo.dart';
import 'package:fresh_kart/features/product/domain/usecase/products_use_case.dart';

final productDataSourceProvider = Provider<ProductDataSource>((ref) {
  return ProductDataSource();
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final productDataSource = ref.read(productDataSourceProvider);
  return ProductRepoImpl(dataSource: productDataSource);
});

final productUsecaseProvider = Provider<ProductsUseCase>((ref) {
  final productRepository = ref.read(productRepositoryProvider);
  return ProductsUseCase(productRepo: productRepository);
});

final productNotifierProvider =
    StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  final productUsecase = ref.read(productUsecaseProvider);

  return ProductNotifier(productUsecase);
});

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductsUseCase productUseCase;

  ProductNotifier(
    this.productUseCase,
  ) : super(ProductState());

  Future<void> loadProducts({String? categoryId}) async {
    state = state.copyWith(isLoading: true, failure: null);

    final Either<List<ProductEntity>, Failure> result =
        await productUseCase(categoryId);

    result.fold(
      (product) =>
          state = state.copyWith(isLoading: false, productEntity: product),
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
    );
  }
}

class ProductState {
  final List<ProductEntity>? productEntity;
  final Failure? failure;
  final bool isLoading;

  ProductState({
    this.productEntity,
    this.failure,
    this.isLoading = false,
  });

  ProductState copyWith({
    List<ProductEntity>? productEntity,
    Failure? failure,
    bool? isLoading,
  }) {
    return ProductState(
      productEntity: productEntity ?? [],
      failure: failure,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
