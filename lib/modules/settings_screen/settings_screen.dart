import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop/shared/cubit/shop_cubit/shop_states.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var sCubit = ShopCubit.get(context);
        print(sCubit.userModel.data!.name);
        print(sCubit.userModel.data!.email);
        print(sCubit.userModel.data!.phone);
        nameController.text = sCubit.userModel.data!.name;
        emailController.text = sCubit.userModel.data!.email;
        phoneController.text = sCubit.userModel.data!.phone;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    'Update your information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  if (state is ShopLoadingUpdateUserState)
                    const LinearProgressIndicator(),
                  const SizedBox(height: 5.0),
                  defaultTextFormFiled(
                    controller: nameController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Name must not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: Icons.person,
                    inputType: TextInputType.name,
                  ),
                  const SizedBox(height: 15.0),
                  defaultTextFormFiled(
                    controller: emailController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Email must not be empty';
                      }
                      return null;
                    },
                    label: 'Email Address',
                    prefix: Icons.email,
                    inputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 15.0),
                  defaultTextFormFiled(
                      controller: phoneController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Phone number must not be empty';
                        }
                        return null;
                      },
                      label: 'Phone Number',
                      prefix: Icons.phone_android_outlined,
                      inputType: TextInputType.phone),
                  const SizedBox(height: 15.0),
                  buildElevatedButton(
                    context: context,
                    label: 'Update',
                    function: () {
                      if (formKey.currentState!.validate()) {
                        sCubit.updateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5.0),
                  const Text(
                    'Or',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 5.0),
                  buildElevatedButton(
                    context: context,
                    label: 'Log Out',
                    function: () {
                      logOut(context);
                    },
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
