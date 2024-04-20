import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_chat/bloc/register_bloc/register_bloc.dart';
import 'package:v_chat/presentation/pages/login_page/page/login_page.dart';
import 'package:v_chat/presentation/pages/login_page/widgets/custom_span_text.dart';
import 'package:v_chat/presentation/pages/login_page/widgets/custom_text_field.dart';

import 'package:v_chat/presentation/pages/login_page/widgets/main_img.dart';
import 'package:v_chat/presentation/resources/string_manager.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameEditingController =
      TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController genderController = TextEditingController();
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
              customTextField(context, 'Full Name', fullNameController),
              customTextField(context, 'username', usernameEditingController),
              customTextField(
                  context, StringManager.password, passwordEditingController),
              customTextField(
                  context, 'Confirm Password', confirmPasswordController),
              customTextField(context, 'Gender', genderController),
              const SizedBox(height: 50),
              InkWell(
                  onTap: () {
                    context.read<RegisterBloc>().add(Register(
                        fullName: fullNameController.text,
                        username: usernameEditingController.text,
                        password: passwordEditingController.text,
                        confirmPassword: confirmPasswordController.text,
                        gender: genderController.text));
                  },
                  child: BlocListener<RegisterBloc, RegisterState>(
                    listener: (context, state) {
                      if (state.registerStatus == RegisterStatus.loaded) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => LoginPage()),
                        );
                      }
                    },
                    child: Container(
                      height: 40,
                      width: width * .8,
                      decoration: const BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                          child: context
                                      .watch<RegisterBloc>()
                                      .state
                                      .registerStatus ==
                                  RegisterStatus.loading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                    ),
                  )),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: customSpanText(
                    StringManager.alreadyHaveAccount, StringManager.login),
              )
            ],
          ),
        ),
      ),
    );
  }
}
