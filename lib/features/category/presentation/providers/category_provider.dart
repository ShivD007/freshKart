// ------------------- Riverpod Provider -------------------

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_kart/components/custom_alert_message.dart';
import 'package:fresh_kart/features/category/data/datasource/category_data_source.dart';
import 'package:fresh_kart/features/category/data/repository/category_repo_impl.dart';
import 'package:fresh_kart/features/category/domain/repository/category_repo.dart';
import 'package:fresh_kart/features/category/domain/usecase/category_use_case.dart';
import 'package:fresh_kart/features/home/domain/entity/category_entity.dart';
import 'package:fresh_kart/features/home/presentation/provider/home_provider.dart';

final dataSourceProvider = Provider<CategoryDataSource>((ref) {
  return CategoryDataSource();
});

final repoProvider = Provider<CategoryRepo>((ref) {
  final dataSource = ref.read(dataSourceProvider);
  return CategoryRepoImpl(dataSource: dataSource);
});

final useCaseProvider = Provider<CategoryUseCase>((ref) {
  final repo = ref.read(repoProvider);
  return CategoryUseCase(categoryRepo: repo);
});

final categoryProvider =
    NotifierProvider<CategoryNotifier, CategoryState>(CategoryNotifier.new);

class CategoryNotifier extends Notifier<CategoryState> {
  @override
  build() {
    return CategoryState();
  }

  Future<void> getCategories(String newAddress,
      {required VoidCallback onComplete}) async {
    final result = await ref.read(useCaseProvider)();
    state = state.copyWith(isLoading: true);

    result.fold(
      (category) {
        state = state.copyWith(isLoading: false, categories: category);
      },
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.toString());
      },
    );
  }
}

class CategoryState {
  final bool? isLoading;
  final List<CategoryEntity>? categories;
  final String? error;

  CategoryState({
    this.isLoading = false,
    this.categories,
    this.error,
  });

  CategoryState copyWith(
      {bool isLoading = false,
      List<CategoryEntity>? categories,
      String? error}) {
    return CategoryState(
      isLoading: isLoading,
      categories: categories ?? this.categories,
      error: error ?? this.error,
    );
  }
}
