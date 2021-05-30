import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop/layouts/shop_layuot/shop_layout.dart';
import 'package:shop/modules/register_screen/register_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/cubit/login_cubit/login_cubit.dart';
import 'package:shop/shared/cubit/login_cubit/login_states.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status) {
              // ignore: avoid_print
              print(state.loginModel.message);
              // ignore: avoid_print
              print(state.loginModel.data!.token);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              // ignore: avoid_print
              print(state.loginModel.message);
              showToast(
                  text: state.loginModel.message, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          var logCubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text('LOGIN', style: TextStyle(fontSize: 34)),
                        const Text('Login now to browse our hot offers',
                            style: TextStyle(fontSize: 18, color: Colors.grey)),
                        const SizedBox(height: 30.0),
                        defaultTextFormFiled(
                          controller: emailController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please type your email address';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                          inputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 15.0),
                        defaultTextFormFiled(
                          controller: passwordController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Password is too short';
                            }
                            return null;
                          },
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              logCubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          onSuffixPressed: () {
                            logCubit.changePasswordVisibility();
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: logCubit.suffix,
                          isObscure: logCubit.isObscure,
                          inputType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(height: 25.0),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>
                              state is! LoginLoadingState,
                          widgetBuilder: (context) => buildElevatedButton(
                              context: context,
                              label: 'login',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  logCubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              }),
                          fallbackBuilder: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text(
                              'Don\'t have an account?',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            buildTextButton(
                              function: () {
                                navigateAndFinish(context, RegisterScreen());
                              },
                              label: 'Register',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
