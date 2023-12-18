// ignore_for_file: avoid_print

import 'package:first_task_1/core/controllers/login_cubit/login_cubit.dart';
import 'package:first_task_1/core/controllers/login_cubit/login_states.dart';
import 'package:first_task_1/core/managers/nav.dart';
import 'package:first_task_1/core/managers/values.dart';
import 'package:first_task_1/core/network/local/cache_helper.dart';
import 'package:first_task_1/screens/modules/prducts_screen.dart';
import 'package:first_task_1/screens/modules/register.dart';
import 'package:first_task_1/screens/widgets/botton.dart';
import 'package:first_task_1/screens/widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (state.loginModel.status == "success") {
            print(state.loginModel.message);
            CacheHelper.saveData(
              key: 'userId',
              value: state.loginModel.user!.nationalId,
            ).then((value) {
              natoinalId = state.loginModel.user!.nationalId;
            });
            CacheHelper.saveData(
              key: 'token',
              value: state.loginModel.user!.token,
            ).then((value) {
              token = state.loginModel.user!.token!;
              navigateAndFinishThisScreen(
                context,
                const ProductScreen(),
              );
            });
          } else {
            print(state.loginModel.message);
          }
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DefaultFieldForm(
                    labelStyle: const TextStyle(color: Colors.black),
                    controller: emailController,
                    keyboard: TextInputType.emailAddress,
                    valid: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter your Email';
                      }
                      return null;
                    },
                    label: 'Email Address',
                    prefix: Icons.email,
                    hint: 'Email Address',
                    hintStyle: const TextStyle(color: Colors.grey),
                    show: false,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DefaultFieldForm(
                    labelStyle: const TextStyle(color: Colors.black),
                    controller: passwordController,
                    keyboard: TextInputType.visiblePassword,
                    valid: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Your Password';
                      }
                      return null;
                    },
                    label: 'Password',
                    prefix: Icons.password,
                    hint: 'Password',
                    hintStyle: const TextStyle(color: Colors.grey),
                    show: false,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DefaultButton(
                    backgroundColor: Colors.black,
                    borderColor: Colors.transparent,
                    buttonWidget: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                    function: () {
                      if (formKey.currentState!.validate()) {
                        cubit.userLogin(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()),
                        );
                      },
                      child: const Text(
                        'Not registered? Register now',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
