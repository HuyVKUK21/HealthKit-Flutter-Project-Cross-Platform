import 'package:fitnessapp/data/repositories/user/forget_password_impl.dart';
import 'package:fitnessapp/domain/entities/account_entity.dart';
import 'package:fitnessapp/domain/usecases/user/forget_password_usercase.dart';
import 'package:fitnessapp/presentation/screens/change_password/change_password_screen.dart';
import 'package:fitnessapp/presentation/screens/change_password/detail_profile_screen.dart';
import 'package:fitnessapp/presentation/screens/signin/signin_screen.dart';
import 'package:fitnessapp/presentation/widgets/appbar/custom_app_bar.dart';
import 'package:fitnessapp/utils/global/user.dart';
import 'package:fitnessapp/utils/page_route_builder.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {

  SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>{

  late String userId = "";
  String? _targetScreen;
  AccountEntity? account;
  final ForgetPasswordUsercase _forgetPasswordUsercase = ForgetPasswordUsercase(ForgetPasswordImpl());

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  Future<void> _getUserId() async {
    final fetchedAccount = await GlobalUtil.getAccount();
    setState(() {
      account = fetchedAccount;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ProfileSection(accountEntity: account!),
            const SizedBox(height: 10.0),
            SettingsCategory(
              title: 'Chung',
              items: [
                SettingsItem(
                  icon: Icons.person,
                  title: 'Hồ sơ',
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteHelper.createFadeRoute(DetailProfileScreen()),
                    );
                  },
                ),
                SettingsItem(icon: Icons.info, title: 'Phiên bản ứng dụng'),
                SettingsItem(icon: Icons.cloud, title: 'Tài khoản & dữ liệu'),
                SettingsItem(
                  icon: Icons.password,
                  title: 'Thay đổi mật khẩu',
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteHelper.createFadeRoute(ChangePasswordScreen()),
                    );
                  },
                ),
                SettingsItem(icon: Icons.public, title: 'Quốc gia'),
              ],
            ),
            const SizedBox(height: 10.0),
            SettingsCategory(
              title: 'Sức khoẻ',
              items: const [
                SettingsItem(
                    icon: Icons.health_and_safety,
                    title: 'Tình trạng sức khoẻ'),
                SettingsItem(icon: Icons.schedule, title: 'Kế hoạch sức khoẻ'),
                SettingsItem(
                    icon: Icons.local_hospital, title: 'Bệnh viện / Bác sĩ'),
                SettingsItem(icon: Icons.fitness_center, title: 'Đơn vị'),
                SettingsItem(icon: Icons.book, title: 'Hướng dẫn sức khoẻ'),
              ],
            ),
            const SizedBox(height: 10.0),
            SettingsCategory(
              title: 'Quyền truy cập',
              items: const [
                SettingsItem(icon: Icons.notifications, title: 'Thông báo'),
                SettingsItem(
                    icon: Icons.health_and_safety, title: 'Ứng dụng sức khoẻ'),
                SettingsItem(
                    icon: Icons.bluetooth, title: 'Thiết bị Bluetooth'),
              ],
            ),
            const SizedBox(height: 10.0),
            SettingsCategory(
              title: 'Giới thiệu',
              items: [
                SettingsItem(icon: Icons.info, title: 'Về chúng tôi'),
                SettingsItem(
                    icon: Icons.help_outline,
                    title: 'Giới thiệu về Ngày Đầu Tiên'),
                SettingsItem(
                    icon: Icons.rule, title: 'Điều khoản và điều kiện'),
                SettingsItem(
                    icon: Icons.privacy_tip, title: 'Chính sách bảo mật'),
                SettingsItem(icon: Icons.games, title: 'Quy tắc Trò chơi hoá'),
                SettingsItem(icon: Icons.cookie, title: 'Chính sách Cookie'),
                SettingsItem(
                  icon: Icons.logout,
                  title: 'Đăng xuất',
                  onTap: () {
                    _forgetPasswordUsercase.signOut();
                    Navigator.pushReplacement(
                      context,
                      RouteHelper.createFadeRoute(SigninScreen()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  final AccountEntity accountEntity;

  const ProfileSection({
    Key? key,
    required this.accountEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 4,
              offset: Offset(0, 2)),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/images/profile_user.png'),
          ),
          const SizedBox(height: 8.0),
          Text(
            accountEntity.fullName!,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const Text(
            'Thành viên HealthKit',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

class SettingsCategory extends StatelessWidget {
  final String title;
  final List<SettingsItem> items;

  const SettingsCategory({required this.title, required this.items, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 6,
              offset: const Offset(0, 2)),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ...items
              .map((item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: item,
          ))
              .toList(),
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const SettingsItem(
      {required this.icon, required this.title, this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing:
      const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      onTap: onTap,
    );
  }
}


