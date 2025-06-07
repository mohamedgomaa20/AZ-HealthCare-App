import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../cubit/cubit.dart';


Widget defaultButton({
  Color color = Colors.blue,
  double width = double.infinity,
  double height = 60,
  required String text,
  double radius = 0.0,
  required VoidCallback onPressed,
  bool isUpperCase = false,
  double fontSize = 16,
}) {
  return SizedBox(
    width: width,
    child: MaterialButton(
      height: height,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      onPressed: onPressed,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: TextStyle(fontSize: fontSize, color: Colors.white),
      ),
    ),
  );
}

Widget defaultTextButton({
  required Function() onPressed,
  required String text,
  Color textColor = Colors.white,
}) {
  return TextButton(
      style: ElevatedButton.styleFrom(
        // padding: EdgeInsets.all(15)
      ),
      onPressed: onPressed, child: Text(text ,

      style: TextStyle(
          fontSize: 24,
          color: textColor)));
}

TextFormField buildTextFormField({
  required String label,
  required TextEditingController controller,
  TextInputType? keyboardType,
  required IconData prefixIcon,
  String? hintText,
  VoidCallback? onTap,
  ValueSetter? onChanged,
  ValueSetter? onSubmitted,
  int? maxLines = 1,
  required FormFieldValidator<String>? validator,
  double radius = 0.0,
  IconData? suffixIcon,
  VoidCallback? suffixPressed,
  bool isPassword = false,
  bool showKeyboard = false,
}) {
  return TextFormField(
    onTap: onTap,
    maxLines: maxLines,
    controller: controller,
    onChanged: onChanged,
    keyboardType: keyboardType,
    onFieldSubmitted: onSubmitted,
    validator: validator,
    obscureText: isPassword,
    readOnly: showKeyboard,

    // onTapAlwaysCalled: true,
    // style: TextStyle(color: defaultColor),
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
      prefixIcon: Icon(prefixIcon),
      suffixIcon:
          suffixIcon != null
              ? IconButton(icon: Icon(suffixIcon), onPressed: suffixPressed)
              : null,
      label: Text(label),
      hintText: hintText,
    ),
  );
}

Widget buildTaskItem(Map task, context) {
  return Dismissible(
    background: Container(
      color: Colors.red[400],
      child: Icon(Icons.delete, color: Colors.white),
    ),
    onDismissed: (direction) {
      AppCubit.get(context).deleteData(id: task['id']);
    },
    key: Key(task['id'].toString()),
    child: Card(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(radius: 40, child: Text('${task['time']}')),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${task['title']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  '${task['date']}',
                  style: TextStyle(
                    fontSize: 17,
                    height: 1.3,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context).updateData(status: 'done', id: task['id']);
            },
            icon: Icon(Icons.check_box),
            color: Colors.green,
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(
                context,
              ).updateData(status: 'archived', id: task['id']);
            },
            icon: Icon(Icons.archive),
            color: Colors.black45,
          ),
        ],
      ),
    ),
  );
}




Widget myDivider() {
  return Container(
    // margin: EdgeInsets.only(left: 20),
    height: 1,
    width: double.infinity,
    decoration: BoxDecoration(color: Colors.grey),
  );
}

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateAndReplacement(context, widget) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (route) => false,
  );
}
