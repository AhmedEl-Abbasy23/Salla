import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop/layouts/shop_layuot/shop_layout.dart';
import 'package:shop/modules/login_screen/login_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/cubit/register_cubit/register_cubit.dart';
import 'package:shop/shared/cubit/register_cubit/register_states.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (contex, state) {
          if (state is RegisterSuccessState) {
            if (state.registerModel.status) {
              // ignore: avoid_print
              print(state.registerModel.message);
              // ignore: avoid_print
              print(state.registerModel.data!.token);
              CacheHelper.saveData(
                      key: 'token', value: state.registerModel.data!.token)
                  .then((value) {
                token = state.registerModel.data!.token;
                navigateAndFinish(context, ShopLayout());
              });
            }else {
              // ignore: avoid_print
              print(state.registerModel.message);
              showToast(
                  text: state.registerModel.message, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          RegisterCubit regCubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text('REGISTER', style: TextStyle(fontSize: 34)),
                        const Text('Register now to browse our hot offers',
                            style: TextStyle(fontSize: 18, color: Colors.grey)),
                        const SizedBox(height: 30.0),
                        defaultTextFormFiled(
                          controller: nameController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please type your name';
                            }
                            return null;
                          },
                          label: 'User Name',
                          prefix: Icons.person,
                          inputType: TextInputType.name,
                        ),
                        const SizedBox(height: 15.0),
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
                          isObscure: true,
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          // suffix: logCubit.suffix,
                          // isObscure: logCubit.isObscure,
                          inputType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(height: 15.0),
                        defaultTextFormFiled(
                          controller: phoneController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please type your phone number';
                            }
                            return null;
                          },
                          label: 'Phone Number',
                          prefix: Icons.phone_android_outlined,
                          inputType: TextInputType.phone,
                        ),
                        const SizedBox(height: 25.0),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (context) => state is! RegisterLoadingState,
                          widgetBuilder: (context) => buildElevatedButton(
                              context: context,
                              label: 'REGISTER',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  regCubit.userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text);
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
                              'Have an account already?',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            buildTextButton(
                              function: () {
                                navigateAndFinish(context, LoginScreen());
                              },
                              label: 'Login',
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
