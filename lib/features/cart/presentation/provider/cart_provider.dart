import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_kart/components/custom_alert_message.dart';
import 'package:fresh_kart/features/cart/data/datasource/cart_data_source.dart';
import 'package:fresh_kart/features/cart/data/repository/cart_repo_impl.dart';
import 'package:fresh_kart/features/cart/domain/entity/add_to_cart_req_entity.dart';
import 'package:fresh_kart/features/cart/domain/entity/cart_entity.dart';
import 'package:fresh_kart/features/cart/domain/entity/delete_cart_item_req_entity.dart';
import 'package:fresh_kart/features/cart/domain/repository/cart_repository.dart';
import 'package:fresh_kart/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:fresh_kart/features/cart/domain/usecases/delete_cart_usecase.dart';
import 'package:fresh_kart/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:fresh_kart/features/cart/domain/usecases/update_quantity_usecase.dart';
import 'package:fresh_kart/routes/navigation.dart';
import 'package:fresh_kart/utils/helper.dart';

final cartdataSource = Provider<CartDataSource>((ref) {
  return CartDataSource();
});

final cartRepository = Provider<CartRepository>((ref) {
  final dataSource = ref.read(cartdataSource);
  return CartRepoImpl(remoteDataSource: dataSource);
});

final getCartUseCase = Provider<GetCartUsecase>((ref) {
  final repository = ref.read(cartRepository);

  return GetCartUsecase(repository);
});

final deleteCartUseCase = Provider<DeleteCartUsecase>((ref) {
  final repository = ref.read(cartRepository);

  return DeleteCartUsecase(repository);
});

final addToCartUseCase = Provider<AddToCartUsecase>((ref) {
  final repository = ref.read(cartRepository);

  return AddToCartUsecase(repository);
});

final updateCartUseCase = Provider<UpdateCartUsecase>((ref) {
  final repository = ref.read(cartRepository);

  return UpdateCartUsecase(repository);
});

final cartProvider =
    NotifierProvider<CartNotifier, CartState>(CartNotifier.new);

class CartNotifier extends Notifier<CartState> {
  @override
  CartState build() {
    return CartState.initial();
  }

  Future<void> getCart() async {
    state = state.copyWith(isLoading: true);
    final result = await ref.read(getCartUseCase)();
    result.fold(
      (cart) {
        state = state.copyWith(
          isLoading: false,
          cartEntity: cart,
        );
      },
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.toString(),
        );
      },
    );
  }

  Future<void> deleteCart(String cartId) async {
    final result = await ref.read(deleteCartUseCase)(
        cartId); // Replace 'itemId' with the actual item ID to delete
    result.fold(
      (cart) {
        AlertMessage.show(cart.message);
      },
      (failure) {
        AlertMessage.show(failure.toString());
      },
    );
  }

  Future<void> addToCart({
    required String productId,
    required int quantity,
    required String varientId,
    required BuildContext context,
  }) async {
    AddToCartReqEntity addToCartReqEntity = AddToCartReqEntity(
      productId: productId,
      quantity: quantity,
      variantId: varientId,
    );
    Helper.showLoaderDialog(context);
    final result = await ref.read(addToCartUseCase)(
        addToCartReqEntity); // Replace 'itemId' with the actual item ID to delete

    CustomNavigator.pop(context);
    result.fold(
      (cart) {},
      (failure) {
        AlertMessage.show(failure.toString());
      },
    );
  }

  Future<void> updateCart() async {
    UpdateCartItemReqEntity updateCartItemReqEntity = UpdateCartItemReqEntity(
      productId: '',
      quantity: 1,
      variantId: '',
      cartId: '',
    );
    final result = await ref.read(updateCartUseCase)(updateCartItemReqEntity);
    result.fold(
      (cart) {
        AlertMessage.show(cart.message);
      },
      (failure) {
        AlertMessage.show(failure.toString());
      },
    );
  }
}

class CartState {
  final bool isLoading;
  final String? errorMessage;
  final CartEntity? cartEntity;

  CartState({
    required this.isLoading,
    required this.errorMessage,
    required this.cartEntity,
  });

  factory CartState.initial() {
    return CartState(
      isLoading: false,
      errorMessage: null,
      cartEntity: null,
    );
  }

  CartState copyWith({
    bool? isLoading,
    String? errorMessage,
    CartEntity? cartEntity,
  }) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      cartEntity: cartEntity ?? this.cartEntity,
    );
  }
}
