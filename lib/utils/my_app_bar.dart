import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const MyAppBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
      ),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      leading: IconButton(
        padding: const EdgeInsets.only(left: 10),
        icon: const Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: Color.fromARGB(255, 85, 74, 240),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
