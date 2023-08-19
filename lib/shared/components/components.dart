import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultForm(
        {required TextEditingController controller,
        bool obscureText = false,
        bool readOnly = false,
        required TextInputAction textInputAction,
        Widget? suffixIcon,
        Widget? suffix,
        Icon? prefixIcon,
        String? label,
        String? hintText,
        int? maxLength,
        int maxLines = 1,
        TextInputType? type,
        required Function? validator,
        Function()? onTap,
        Function(dynamic)? onFieldSubmitted}) =>
    TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      maxLength: maxLength,
      maxLines: maxLines,
      keyboardType: type,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText,
      textInputAction: textInputAction,
      decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          suffix: suffix,
          prefixIcon: prefixIcon,
          border: const OutlineInputBorder(),
          labelText: label),
      controller: controller,
      validator: (String? value) {
        if (value!.isEmpty) {
          return validator!(value);
        }
        return null;
      },
    );
Widget defaultSubmit1(
        {formKey,
        Function()? onPressed,
        bool isothericon = false,
        Color background = Colors.blue,
        Widget? icon}) =>
    FloatingActionButton(
      backgroundColor: background,
      // onPressed: () {
      //   if (formKey.currentState!.validate()) {}
      // },
      onPressed: onPressed,
      child: !isothericon ? const Icon(Icons.arrow_forward_ios) : icon,
    );
Widget defaultSubmit2({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  Function()? onPressed,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        color: background,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

void showToast({required String msg, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: choseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { success, error, warning }

Color choseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;

    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}

void navigatAndReturn({required context, required page}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));

void navigatAndFinish({required context, required page}) =>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => page), (route) => false);

PreferredSizeWidget defaultAppBar(
        {
        // String? title,
        List<Widget>? actions,
        bool canreturn = true,
        Widget? title,
        Widget? leading,
        // Function()? whenBack,
        Function()? onPressed}) =>
    AppBar(
        titleSpacing: 0,
        leading: canreturn
            ? IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ))
            : leading,
        title: title,
        actions: actions);
