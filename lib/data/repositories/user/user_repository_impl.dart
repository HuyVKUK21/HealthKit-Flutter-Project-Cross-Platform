import 'package:fitnessapp/data/datasources/user/firebase_auth_datasource.dart';
import 'package:fitnessapp/domain/entities/user_entity.dart';
import 'package:fitnessapp/domain/repositories/user/user_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final FirebaseAuthDataSource firebaseAuthDataSource;

  UserRepositoryImpl({required this.firebaseAuthDataSource});

  @override
  Future<UserEntity> register(String email, String password) async{
    final user = await firebaseAuthDataSource.registerWithEmailAndPassword(email, password);
    return UserEntity(email: user.email!, uid: user.uid!);
  }

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

}