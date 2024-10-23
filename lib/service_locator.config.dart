// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:fitnessapp/data/datasources/register/firebase_auth_datasource.dart'
    as _i1054;
import 'package:fitnessapp/data/repositories/register/user_repository_impl.dart'
    as _i965;
import 'package:fitnessapp/domain/repositories/register/user_repository.dart'
    as _i1024;
import 'package:fitnessapp/domain/usecases/register/register_usecase.dart'
    as _i987;
import 'package:fitnessapp/firebase_module.dart' as _i139;
import 'package:fitnessapp/presentation/bloc/register/register_bloc.dart'
    as _i761;
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
    gh.factory<_i1054.FirebaseAuthDataSource>(
        () => _i1054.FirebaseAuthDataSource(gh<_i59.FirebaseAuth>()));
    gh.lazySingleton<_i1024.UserRepository>(() => _i965.UserRepositoryImpl(
        firebaseAuthDataSource: gh<_i1054.FirebaseAuthDataSource>()));
    gh.factory<_i987.RegisterUseCase>(
        () => _i987.RegisterUseCase(gh<_i1024.UserRepository>()));
    gh.factory<_i761.RegisterBloc>(
        () => _i761.RegisterBloc(gh<_i987.RegisterUseCase>()));
    return this;
  }
}

class _$FirebaseAuthModule extends _i139.FirebaseAuthModule {}
