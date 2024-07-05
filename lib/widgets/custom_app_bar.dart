import 'package:flutter/material.dart';

PreferredSizeWidget CustomAppBar({
  Key? key,
  String? title,
}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(title!,
        style: TextStyle(
            color: Colors.black, fontSize: 34, fontWeight: FontWeight.bold)),
    iconTheme: IconThemeData(color: Colors.black),
  );
}

@override
Size get preferredSize => Size.fromHeight(50);
