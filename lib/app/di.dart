import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../data/data_source/data_source.dart';
import '../data/data_source/local_data_source.dart';
import '../data/network/app_api.dart';
import '../data/network/dio_factory.dart';
import '../data/network/network_info.dart';
import '../domain/repository/repository.dart';
import '../domain/repository/repository_imp.dart';
import '../domain/usecase/forgetPassword_usecase.dart';
import '../domain/usecase/home_usecase.dart';
import '../domain/usecase/login_usecase.dart';
import '../domain/usecase/register_usecase.dart';
import '../domain/usecase/store_usecase.dart';
import '../presenation/forget_password/viewmodel/forgetPassword_viewmodel.dart';
import '../presenation/login/viewmodel/login_viewmodel.dart';
import '../presenation/main/pages/home/view_model/home_viewmodel.dart';
import '../presenation/register/register_viewmodel/register_viewmodel.dart';
import '../presenation/store_details/view_model/store_details_viewmodel.dart';
import 'app_prefs.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';


final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  Dio dio = await instance<DioFactory>().getDio();
  //app service client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
          () => RemoteDataSourceImpl(instance<AppServiceClient>()));

  // local data source
  instance.registerLazySingleton<LocalDataSource>(
          () => LocalDataSourceImpl());

  // repository

  instance.registerLazySingleton<Repository>(
          () => RepositoryImpl(instance(), instance(),instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}
  initForgotPasswordModule() {
    if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
      instance.registerFactory<ForgotPasswordUseCase>(
              () => ForgotPasswordUseCase(instance()));
      instance.registerFactory<ForgotPasswordViewModel>(
              () => ForgotPasswordViewModel(instance()));
    }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(
            () => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());

  }


}
initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance
        .registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(
            () => HomeViewModel(instance()));
  }
}

initStoreDetailsModule() {
  if (!GetIt.I.isRegistered<StoreUseCase>()) {
    instance
        .registerFactory<StoreUseCase>(() => StoreUseCase(instance()));

    instance.registerFactory<StoreViewModel>(
            () => StoreViewModel(instance()));
  }
}