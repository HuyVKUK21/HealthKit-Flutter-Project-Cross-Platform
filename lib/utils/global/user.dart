import 'package:fitnessapp/domain/entities/account_entity.dart';
import 'package:fitnessapp/domain/repositories/user/auth_local_data_source.dart';
import 'package:get_it/get_it.dart';

class GlobalUtil {
  static final AuthLocalDataSource _authLocalDataSource = GetIt.I<AuthLocalDataSource>();

  static Future<String?> getUserId() async {
    return await _authLocalDataSource.getUid();
  }

  static Future<void> saveUserId(String uid) async {
    await _authLocalDataSource.saveUid(uid);
  }

  static Future<void> clearUserId() async {
    await _authLocalDataSource.clearUid();
  }

  Future<AccountEntity?> getAccount() async {
    await _authLocalDataSource.getAccount();
  }
}
