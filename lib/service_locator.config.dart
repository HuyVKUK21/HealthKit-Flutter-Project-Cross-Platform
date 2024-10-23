// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:fitnessapp/data/datasources/user/firebase_auth_datasource.dart'
    as _i66;
import 'package:fitnessapp/data/repositories/user/user_repository_impl.dart'
    as _i960;
import 'package:fitnessapp/domain/repositories/user/user_repository.dart'
    as _i645;
import 'package:fitnessapp/domain/usecases/user/user_usecase.dart' as _i635;
import 'package:fitnessapp/firebase_module.dart' as _i139;
import 'package:fitnessapp/presentation/bloc/register/register_bloc.dart'
    as _i761;
import 'package:fitnessapp/presentation/bloc/signin/signin_bloc.dart' as _i876;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firebaseAuthModule = _$FirebaseAuthModule();
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseAuthModule.firebaseAuth);
    gh.factory<_i66.FirebaseAuthDataSource>(
        () => _i66.FirebaseAuthDataSource(gh<_i59.FirebaseAuth>()));
    gh.lazySingleton<_i645.UserRepository>(() => _i960.UserRepositoryImpl(
        firebaseAuthDataSource: gh<_i66.FirebaseAuthDataSource>()));
    gh.factory<_i635.UserUseCase>(
        () => _i635.UserUseCase(gh<_i645.UserRepository>()));
    gh.factory<_i761.RegisterBloc>(
        () => _i761.RegisterBloc(gh<_i635.UserUseCase>()));
    gh.factory<_i876.SignInBloc>(
        () => _i876.SignInBloc(gh<_i635.UserUseCase>()));
    return this;
  }
}

class _$FirebaseAuthModule extends _i139.FirebaseAuthModule {}
