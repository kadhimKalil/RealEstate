import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/moduls/login/login.dart';
import 'package:flutter_app/moduls/regester/regester.dart';
import 'package:flutter_app/shared/style/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defualtFormField({
  @required TextEditingController? controller,
  @required IconData? prefixIcon,
  @required String? hintText,
  @required TextInputType? keyboardType,
  @required String? Function(String?)? validator,
  void Function()? onTap,
  void Function(String)? onChanged,
  void Function(String)? onFieldSubmitted,
  void Function()? isPressSuffix,
  bool obscureText = false,
  IconData? suffixIcon,
  int? maxLines,
}) {
  return TextFormField(
    maxLines: maxLines,
    controller: controller,
    onTap: onTap,
    onChanged: onChanged,
    keyboardType: keyboardType,
    obscureText: obscureText,
    validator: validator,
    onFieldSubmitted: onFieldSubmitted,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon , color: defualtColor,),
      suffixIcon: suffixIcon != null
          ? IconButton(icon: Icon(suffixIcon), onPressed: isPressSuffix)
          : null,
      filled: true,
      fillColor: Colors.grey[100],
      border: InputBorder.none,
      hintText: hintText,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: defualtColor),
        borderRadius: BorderRadius.circular(10.0),
      ),
      contentPadding:
          const EdgeInsets.only(left: 16.0, bottom: 20.0, top: 20.0),
    ),
  );
}

Widget defualtBottton({
  @required void Function()? onPressed,
  @required String? text,
}) =>
    MaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      minWidth: double.infinity,
      onPressed: onPressed,
      color: defualtColor,
      child: Text(
        text!.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );

dynamic navigatorTo({
  @required context,
  required Widget screen,
}) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}

void navigatorPushAndRemoveUntil({
  required BuildContext context,
  required Widget widget,
}) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => widget), (rout) {
    return false;
  });
}

void showToast({
  required String text,
  required ToastState state,
}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(toastState: state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor({
  required ToastState toastState,
}) {
  Color color;

  switch (toastState) {
    case ToastState.SUCCESS:
      color = Colors.greenAccent;
      break;
    case ToastState.ERROR:
      color = Colors.redAccent;
      break;
    case ToastState.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}

Container defaultAccountButton({
  required context,
  required IconData? icon,
  required String? lable,
}) =>
    Container(
      height: 56.0,
      width: double.infinity,
      padding: const EdgeInsetsDirectional.only(start: 8.0),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadiusDirectional.circular(8.0)),
      child: Row(
        children: [
          Icon(
            icon,
            color: defualtColor,
          ),
          const SizedBox(
            width: 8.0,
          ),
          Center(
              child: Text(
            lable!,
            style: Theme.of(context).textTheme.bodyText1,
          )),
        ],
      ),
    );

void signOut(context) {
  FirebaseAuth.instance.signOut();
  navigatorPushAndRemoveUntil(context: context, widget: LoginScreen());
}

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
