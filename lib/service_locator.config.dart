// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:fitnessapp/data/datasources/user/firebase_auth_datasource.dart'
    as _i66;
import 'package:fitnessapp/data/datasources/weight/weight_remote_datasource.dart'
    as _i682;
import 'package:fitnessapp/data/repositories/medicine/medicine_repository_impl.dart'
    as _i708;
import 'package:fitnessapp/data/repositories/user/auth_local_data_source_impl.dart'
    as _i431;
import 'package:fitnessapp/data/repositories/user/user_repository_impl.dart'
    as _i960;
import 'package:fitnessapp/data/repositories/weight/weight_repository_impl.dart'
    as _i255;
import 'package:fitnessapp/domain/repositories/medicine/medicine_repository.dart'
    as _i91;
import 'package:fitnessapp/domain/repositories/user/auth_local_data_source.dart'
    as _i397;
import 'package:fitnessapp/domain/repositories/user/user_repository.dart'
    as _i645;
import 'package:fitnessapp/domain/repositories/weight/weight_repository.dart'
    as _i191;
import 'package:fitnessapp/domain/usecases/medicine/medicine_usecase.dart'
    as _i915;
import 'package:fitnessapp/domain/usecases/user/user_usecase.dart' as _i635;
import 'package:fitnessapp/domain/usecases/weight/get_weight_usecase.dart'
    as _i379;
import 'package:fitnessapp/domain/usecases/weight/set_weight_usecase.dart'
    as _i804;
import 'package:fitnessapp/firebase_module.dart' as _i139;
import 'package:fitnessapp/presentation/bloc/signin/signin_bloc.dart' as _i876;
import 'package:fitnessapp/presentation/bloc/signup/signup_bloc.dart' as _i447;
import 'package:fitnessapp/presentation/bloc/weight/weight_bloc.dart' as _i229;
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
    gh.lazySingleton<_i974.FirebaseFirestore>(
        () => firebaseAuthModule.firebaseFireStore);
    gh.factory<_i682.WeightRemoteDatasource>(
        () => _i682.WeightRemoteDatasource(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i191.WeightRepository>(
        () => _i255.UserRepositoryImpl(gh<_i682.WeightRemoteDatasource>()));
    gh.lazySingleton<_i91.MedicineRepository>(
        () => _i708.MedicineRepositoryImpl());
    gh.factory<_i915.MedicineUseCase>(
        () => _i915.MedicineUseCase(gh<_i91.MedicineRepository>()));
    gh.lazySingleton<_i397.AuthLocalDataSource>(
        () => _i431.AuthLocalDataSourceImpl());
    gh.factory<_i804.SetWeightUsecase>(
        () => _i804.SetWeightUsecase(gh<_i191.WeightRepository>()));
    gh.factory<_i379.GetWeightUsecase>(
        () => _i379.GetWeightUsecase(gh<_i191.WeightRepository>()));
    gh.factory<_i66.FirebaseAuthDataSource>(
        () => _i66.FirebaseAuthDataSource(gh<_i59.FirebaseAuth>()));
    gh.factory<_i229.WeightBloc>(() => _i229.WeightBloc(
          gh<_i379.GetWeightUsecase>(),
          gh<_i804.SetWeightUsecase>(),
        ));
    gh.lazySingleton<_i645.UserRepository>(() => _i960.UserRepositoryImpl(
          gh<_i66.FirebaseAuthDataSource>(),
          gh<_i397.AuthLocalDataSource>(),
        ));
    gh.factory<_i635.UserUseCase>(() => _i635.UserUseCase(
          gh<_i645.UserRepository>(),
          gh<_i397.AuthLocalDataSource>(),
        ));
    gh.factory<_i876.SignInBloc>(
        () => _i876.SignInBloc(gh<_i635.UserUseCase>()));
    gh.factory<_i447.SignupBloc>(
        () => _i447.SignupBloc(gh<_i635.UserUseCase>()));
    return this;
  }
}

class _$FirebaseAuthModule extends _i139.FirebaseAuthModule {}
