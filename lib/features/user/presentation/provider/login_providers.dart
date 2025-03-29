import 'package:fresh_kart/features/user/data/datasource/user_data_source.dart';
import 'package:fresh_kart/features/user/data/repository/user_repo_impl.dart';
import 'package:fresh_kart/features/user/domain/repository/user_repository.dart';
import 'package:fresh_kart/features/user/domain/usecase/login_usecase.dart';
import 'package:fresh_kart/features/user/domain/usecase/refresh_token_usecase.dart';
import 'package:fresh_kart/features/user/domain/usecase/register_usecase.dart';
import 'package:riverpod/riverpod.dart';

final userDataSourceProvider = Provider<UserDataSource>((ref) {
  return UserDataSource();
});

final userRepoProvider = Provider<UserRepository>((ref) {
  final datasource = ref.read(userDataSourceProvider);
  return UserRepoImpl(userDataSource: datasource);
});

final loginUserProvider = Provider<LoginUsecase>((ref) {
  final repo = ref.read(userRepoProvider);
  return LoginUsecase(userRepository: repo);
});
final refreshTokenProvider = Provider<RefreshTokenUsecase>((ref) {
  final repo = ref.read(userRepoProvider);
  return RefreshTokenUsecase(userRepository: repo);
});

final registerUserProvider = Provider<RegisterUserUseCase>((ref) {
  final repo = ref.read(userRepoProvider);
  return RegisterUserUseCase(userRepository: repo);
});

final userNotifierProviders = StateNotifierProvider<UserNotifier, void>((ref) {
  final RegisterUserUseCase registerUserUseCase =
      ref.read(registerUserProvider);
  final LoginUsecase loginUseCase = ref.read(loginUserProvider);
  final RefreshTokenUsecase refreshTokenUsecase =
      ref.read(refreshTokenProvider);

  return UserNotifier(refreshTokenUsecase, registerUserUseCase, loginUseCase);
});

class UserNotifier extends StateNotifier {
  final RefreshTokenUsecase refreshTokenUsecase;
  final RegisterUserUseCase registerUserUseCase;
  final LoginUsecase loginUsecase;

  UserNotifier(
    this.refreshTokenUsecase,
    this.registerUserUseCase,
    this.loginUsecase,
  ) : super(null);
}
