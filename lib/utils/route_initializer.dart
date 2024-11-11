import 'package:fitnessapp/domain/repositories/user/auth_local_data_source.dart';
import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:fitnessapp/presentation/screens/signin/signin_screen.dart';
import 'package:fitnessapp/utils/global/user.dart';

class RouteInitializer {
  static Future<String> getInitialRoute() async {
    final account = await GlobalUtil.getAccount();
    return (account != null && account.userId.isNotEmpty)
        ? DashboardScreen.routeName
        : SigninScreen.routeName;
  }
}