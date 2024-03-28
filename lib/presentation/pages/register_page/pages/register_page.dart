import 'package:flutter/material.dart';
import 'package:v_chat/presentation/pages/login_page/page/login_page.dart';
import 'package:v_chat/presentation/pages/login_page/widgets/custom_span_text.dart';
import 'package:v_chat/presentation/pages/login_page/widgets/custom_text_field.dart';
import 'package:v_chat/presentation/pages/login_page/widgets/main_btn.dart';
import 'package:v_chat/presentation/pages/login_page/widgets/main_img.dart';
import 'package:v_chat/presentation/resources/string_manager.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            mainImg(),
            customTextField(context, StringManager.email),
            customTextField(context, StringManager.password),
            const SizedBox(height: 50),
            mainBtn(context, StringManager.register),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: customSpanText(
                  StringManager.alreadyHaveAccount, StringManager.login),
            )
          ],
        ),
      ),
    );
  }
}
