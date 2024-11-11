// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:fitnessapp/data/datasources/auth/firebase_auth_datasource.dart'
    as _i1071;
import 'package:fitnessapp/data/datasources/bloodsugar/bloodsugar_remote_datasource.dart'
    as _i179;
import 'package:fitnessapp/data/datasources/bloodsure/bloodsure_remote_datasource.dart'
    as _i844;
import 'package:fitnessapp/data/datasources/weight/weight_remote_datasource.dart'
    as _i682;
import 'package:fitnessapp/data/repositories/bloodsugar/bloodsugar_repository_impl.dart'
    as _i411;
import 'package:fitnessapp/data/repositories/bloodsure/bloodsure_repository_impl.dart'
    as _i336;
import 'package:fitnessapp/data/repositories/cigarette/cigarette_repository_impl.dart'
    as _i240;
import 'package:fitnessapp/data/repositories/foot_step/foot_step_repository_impl.dart'
    as _i684;
import 'package:fitnessapp/data/repositories/medicine/medicine_repository_impl.dart'
    as _i708;
import 'package:fitnessapp/data/repositories/user/auth_local_data_source_impl.dart'
    as _i431;
import 'package:fitnessapp/data/repositories/user/forget_password_impl.dart'
    as _i837;
import 'package:fitnessapp/data/repositories/user/user_repository_impl.dart'
    as _i960;
import 'package:fitnessapp/data/repositories/weight/weight_repository_impl.dart'
    as _i255;
import 'package:fitnessapp/domain/repositories/bloodsugar/bloodsugar_repository.dart'
    as _i294;
import 'package:fitnessapp/domain/repositories/bloodsure/bloodsure_repository.dart'
    as _i27;
import 'package:fitnessapp/domain/repositories/cigarette/cigarette_repository.dart'
    as _i1069;
import 'package:fitnessapp/domain/repositories/foot_step/foot_step_repository.dart'
    as _i240;
import 'package:fitnessapp/domain/repositories/medicine/medicine_repository.dart'
    as _i91;
import 'package:fitnessapp/domain/repositories/user/auth_local_data_source.dart'
    as _i397;
import 'package:fitnessapp/domain/repositories/user/forget_password_respository.dart'
    as _i1069;
import 'package:fitnessapp/domain/repositories/user/user_repository.dart'
    as _i645;
import 'package:fitnessapp/domain/repositories/weight/weight_repository.dart'
    as _i191;
import 'package:fitnessapp/domain/usecases/bloodsugar/set_bloodsugar_usecase.dart'
    as _i212;
import 'package:fitnessapp/domain/usecases/bloodsure/get_bloodsure_usecase.dart'
    as _i399;
import 'package:fitnessapp/domain/usecases/bloodsure/set_bloodsure_usecase.dart'
    as _i945;
import 'package:fitnessapp/domain/usecases/cigarette/cigarette_usecase.dart'
    as _i520;
import 'package:fitnessapp/domain/usecases/foot_step/foot_step_usecase.dart'
    as _i535;
import 'package:fitnessapp/domain/usecases/medicine/medicine_usecase.dart'
    as _i915;
import 'package:fitnessapp/domain/usecases/user/forget_password_usercase.dart'
    as _i432;
import 'package:fitnessapp/domain/usecases/user/user_usecase.dart' as _i635;
import 'package:fitnessapp/domain/usecases/weight/get_weight_usecase.dart'
    as _i379;
import 'package:fitnessapp/domain/usecases/weight/set_weight_usecase.dart'
    as _i804;
import 'package:fitnessapp/firebase_module.dart' as _i139;
import 'package:fitnessapp/presentation/bloc/bloodsugar/bloodsugar_bloc.dart'
    as _i663;
import 'package:fitnessapp/presentation/bloc/bloodsure/bloodsure_bloc.dart'
    as _i320;
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
    gh.factory<_i844.BloodsureRemoteDatasource>(
        () => _i844.BloodsureRemoteDatasource(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i179.BloodsugarRemoteDatasource>(
        () => _i179.BloodsugarRemoteDatasource(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i91.MedicineRepository>(
        () => _i708.MedicineRepositoryImpl());
    gh.lazySingleton<_i1069.CigaretteRepository>(
        () => _i240.CigaretteRepositoryImpl());
    gh.lazySingleton<_i27.BloodsureRepository>(() =>
        _i336.BloodsureRepositoryImpl(gh<_i844.BloodsureRemoteDatasource>()));
    gh.lazySingleton<_i191.WeightRepository>(
        () => _i255.WeightRepositoryImpl(gh<_i682.WeightRemoteDatasource>()));
    gh.factory<_i915.MedicineUseCase>(
        () => _i915.MedicineUseCase(gh<_i91.MedicineRepository>()));
    gh.lazySingleton<_i397.AuthLocalDataSource>(
        () => _i431.AuthLocalDataSourceImpl());
    gh.factory<_i804.SetWeightUsecase>(
        () => _i804.SetWeightUsecase(gh<_i191.WeightRepository>()));
    gh.lazySingleton<_i240.FootStepRepository>(
        () => _i684.FootStepRepositoryImpl());
    gh.lazySingleton<_i1069.ForgetPasswordRespository>(
        () => _i837.ForgetPasswordImpl());
    gh.factory<_i535.FootStepUsecase>(
        () => _i535.FootStepUsecase(gh<_i240.FootStepRepository>()));
    gh.factory<_i379.GetWeightUsecase>(
        () => _i379.GetWeightUsecase(gh<_i191.WeightRepository>()));
    gh.lazySingleton<_i294.BloodsugarRepository>(() =>
        _i411.BloodsugarRepositoryImpl(gh<_i179.BloodsugarRemoteDatasource>()));
    gh.factory<_i1071.FirebaseAuthDataSource>(
        () => _i1071.FirebaseAuthDataSource(gh<_i59.FirebaseAuth>()));
    gh.factory<_i520.CigaretteUseCase>(
        () => _i520.CigaretteUseCase(gh<_i1069.CigaretteRepository>()));
    gh.factory<_i945.SetBloodsureUsecase>(
        () => _i945.SetBloodsureUsecase(gh<_i27.BloodsureRepository>()));
    gh.factory<_i399.GetBloodsureUsecase>(
        () => _i399.GetBloodsureUsecase(gh<_i27.BloodsureRepository>()));
    gh.factory<_i229.WeightBloc>(() => _i229.WeightBloc(
          gh<_i379.GetWeightUsecase>(),
          gh<_i804.SetWeightUsecase>(),
        ));
    gh.factory<_i432.ForgetPasswordUsercase>(() =>
        _i432.ForgetPasswordUsercase(gh<_i1069.ForgetPasswordRespository>()));
    gh.factory<_i212.SetBloodsugarUsecase>(
        () => _i212.SetBloodsugarUsecase(gh<_i294.BloodsugarRepository>()));
    gh.factory<_i663.BloodsugarBloc>(
        () => _i663.BloodsugarBloc(gh<_i212.SetBloodsugarUsecase>()));
    gh.lazySingleton<_i645.UserRepository>(() => _i960.UserRepositoryImpl(
          gh<_i1071.FirebaseAuthDataSource>(),
          gh<_i397.AuthLocalDataSource>(),
        ));
    gh.factory<_i320.BloodsureBloc>(() => _i320.BloodsureBloc(
          gh<_i945.SetBloodsureUsecase>(),
          gh<_i399.GetBloodsureUsecase>(),
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
