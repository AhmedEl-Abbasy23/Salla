import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/modules/login_screen/login_screen.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/styles/colors.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Widget buildElevatedButton({
  required String label,
  required Function function,
  context,
  bool isUpperCase = true,
  Color color = defaultColor,
}) =>
    SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        onPressed: () => function(),
        child: Text(isUpperCase ? label.toUpperCase() : label),
        style: ElevatedButton.styleFrom(
          primary: color,
          textStyle: Theme.of(context).textTheme.headline6,
        ),
      ),
    );

Widget? logOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    navigateAndFinish(context, LoginScreen());
  });
  return null;
}

Widget buildTextButton({
  required Function function,
  required String label,
}) =>
    TextButton(
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () => function(),
    );

Widget defaultTextFormFiled({
  required TextEditingController controller,
  required String? Function(String?) validate,
  required String label,
  required IconData prefix,
  onSubmit,
  onSuffixPressed,
  IconData? suffix,
  bool isObscure = false,
  TextInputType inputType = TextInputType.text,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: inputType,
      validator: validate,
      onFieldSubmitted: onSubmit,
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(onPressed: onSuffixPressed, icon: Icon(suffix))
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: defaultColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );

Widget myDivider() => const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Divider(color: Colors.grey),
    );

Future<bool?> showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: changeColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

// ignore: constant_identifier_names
enum ToastStates { SUCCESS, ERROR, WARNING }

Color changeColor(ToastStates state) {
  late Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget buildEmpty({
  required IconData icon,
  required String text,
  bool isSearch = false,
}) => Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    // ignore: prefer_const_literals_to_create_immutables
    children: [
      Icon(
        icon,
        size: 60,
        color: Colors.grey,
      ),
      Text(
        isSearch ?
        '$text here for all products':
        '$text list is empty, try add some products.',
        style: const TextStyle(color: Colors.grey),
      ),
    ],
  ),
);