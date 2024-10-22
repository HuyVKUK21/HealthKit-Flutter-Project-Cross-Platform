import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("Hoặc", style: TextStyle(color: Color(0xFF787878)),),
            ),
            Expanded(child: Divider()),
          ],
        ),
        SizedBox(height: 18),
        SocialButton(
          text: "Đăng nhập với",
          imageLogo: Image.asset('assets/images/facebook_logo.png', width: 80),
          color: Colors.white,
          onPressed: () {},
        ),
        SizedBox(height: 18),
        SocialButton(
          text: "Đăng nhập với",
          imageLogo: Image.asset('assets/images/google_logo.png', width: 80),
          color: Colors.white,
          onPressed: () {},
        ),
      ],
    );
  }
}

class SocialButton extends StatelessWidget {
  final String text;
  final Image imageLogo;
  final Color color;
  final VoidCallback onPressed;

  const SocialButton({super.key,
    required this.text,
    required this.imageLogo,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(double.infinity, 54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Color(0xFFBCBCBC), width: 0.6),
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
          SizedBox(width: 8),
          imageLogo,
        ],
      ),
    );
  }
}