import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0), // Thêm padding cho title
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Căn chỉnh giữa các phần tử
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/app_logo.png',
                  width: 34,
                  height: 34,
                ),
                SizedBox(width: 10),
                Text(
                  'HealthKit',
                  style: TextStyle(
                    color: Color(0xFF043723),
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            // Gộp IconButton vào đây
            Row(
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.circleUser, color: Colors.black),
                  onPressed: () {},
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.bell, color: Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
