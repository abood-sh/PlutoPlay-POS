import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pos/core/networking/api_service.dart';
import 'package:pos/core/networking/dio_factory.dart';
import 'package:pos/features/checkout/data/repos/checkout_repo.dart';
import 'package:pos/features/checkout/logic/cubit/checkout_cubit.dart';
import 'package:pos/features/home/data/repos/home_repos.dart';
import 'package:pos/features/home/logic/cubit/home_cubit.dart';
import 'package:pos/features/login/data/repos/login_repos.dart';
import 'package:pos/features/login/logic/cubit/login_cubit.dart';

final getIt = GetIt.instance;
Future<void> setupGetIt() async {
  // dio & api service
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
  // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  // home
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));

  // checkout
  getIt.registerLazySingleton<CheckoutRepo>(() => CheckoutRepo(getIt()));
  getIt.registerFactory<CheckoutCubit>(() => CheckoutCubit(getIt()));

  // // Firebase Services
  // getIt.registerLazySingleton<UserRepository>(() => UserRepository());
  // getIt.registerLazySingleton<ChatRepository>(() => ChatRepository());
  // getIt.registerFactory<UserCubit>(() => UserCubit(getIt<UserRepository>()));
  // getIt.registerFactory<ChatCubit>(() => ChatCubit(getIt<ChatRepository>()));

  // // stripe services
  // // Add to your existing DI setup
  // Dio dio_stripe = StripeDioFactory.getDio();

  // getIt.registerLazySingleton<StripeApiService>(
  //   () => StripeApiService(dio_stripe),
  // );

  // getIt.registerLazySingleton(() => StripeRepository(getIt()));
  // getIt.registerFactory<StripeCubit>(() => StripeCubit(getIt()));

  // // locale
  // final savedLocale = await LocaleCubit.getSavedLocale();
  // getIt.registerFactory<LocaleCubit>(() => LocaleCubit(savedLocale));
}
