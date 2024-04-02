import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_chat/bloc/login_bloc/login_bloc.dart';
import 'package:v_chat/presentation/pages/contacts_page/page/contacts_page.dart';

import 'package:v_chat/presentation/pages/login_page/widgets/custom_span_text.dart';
import 'package:v_chat/presentation/pages/login_page/widgets/custom_text_field.dart';
import 'package:v_chat/presentation/pages/login_page/widgets/main_btn.dart';
import 'package:v_chat/presentation/pages/login_page/widgets/main_img.dart';
import 'package:v_chat/presentation/pages/register_page/pages/register_page.dart';
import 'package:v_chat/presentation/resources/string_manager.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController usernameEditingController =
      TextEditingController(text: 'nehalgamal');
  final TextEditingController passwordEditingController =
      TextEditingController(text: '123456');
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              mainImg(),
              customTextField(
                  context, StringManager.email, usernameEditingController),
              customTextField(
                  context, StringManager.password, passwordEditingController),
              const SizedBox(height: 50),
              InkWell(
                  onTap: () {
                    context.read<LoginBloc>().add(Login(
                        username: usernameEditingController.text,
                        password: passwordEditingController.text));
                  },
                  child: BlocListener<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state.loadingStatus == LoginStatus.loaded) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (_) => const ContactsPage()),
                        );
                      }
                    },
                    child: mainBtn(context, StringManager.login),
                  )),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                child: customSpanText(
                    StringManager.dontHaveAccount, StringManager.register),
              )
            ],
          ),
        ),
      ),
    );
  }
}
