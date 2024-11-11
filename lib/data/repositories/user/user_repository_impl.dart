
import 'package:fitnessapp/data/datasources/auth/firebase_auth_datasource.dart';
import 'package:fitnessapp/domain/entities/account_entity.dart';
import 'package:fitnessapp/domain/entities/user_entity.dart';
import 'package:fitnessapp/domain/repositories/user/auth_local_data_source.dart';
import 'package:fitnessapp/domain/repositories/user/user_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final FirebaseAuthDataSource firebaseAuthDataSource;
  final AuthLocalDataSource _localDataSource;

  UserRepositoryImpl(this.firebaseAuthDataSource, this._localDataSource);


  @override
  Future<UserEntity> signIn(String email, String password) async{
    final user = await firebaseAuthDataSource.signInWithEmailAndPassword(email, password);
    return UserEntity(email: user.email!, uid: user.uid!);
  }

  @override
  Future<UserEntity> signInWithGoogle() async{
    final user = await firebaseAuthDataSource.signInWithGoogle();
    return UserEntity(email: user.email!, uid: user.uid!);
  }

  @override
  Future<UserEntity> register(String email, String password, {required String fullName, required String age, required String phone}) async{
    final user = await firebaseAuthDataSource.registerWithEmailAndPassword(email, password, fullName: fullName, age: age, phone: phone);
    return UserEntity(email: user.email!, uid: user.uid!);
  }

  @override
  Future<AccountEntity> saveInfoAccount(String userId) async{
    final account = await firebaseAuthDataSource.getInfoAccount(userId);
    return account!.toEntity();
  }
}