import 'package:fitnessapp/data/datasources/user/firebase_auth_datasource.dart';
import 'package:fitnessapp/domain/entities/user_entity.dart';
import 'package:fitnessapp/domain/repositories/user/auth_local_data_source.dart';
import 'package:fitnessapp/domain/repositories/user/user_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<void> clearUid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_uid');
  }

  @override
  Future<String?> getUid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_uid');
  }

  @override
  Future<void> saveUid(String uid) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_uid', uid);
  }
}