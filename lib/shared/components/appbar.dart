import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Assuming you're using this for responsive sizing

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackPressed; // Function for back button
  final VoidCallback onActionPressed; // Function for action button
  final bool isChangeSize; // State to determine which icon to show
  final double sizeAdkarTextCH; // Pass the size as a parameter

  const CustomAppBar({
    super.key,
    required this.title,
    required this.onBackPressed,
    required this.onActionPressed,
    required this.isChangeSize,
    required this.sizeAdkarTextCH,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: onBackPressed,
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white, // White icon
        ),
      ),
      actions: [
        IconButton(
          onPressed: onActionPressed,
          icon: Icon(
            isChangeSize ? Icons.done_all : Icons.text_fields,
            color: Colors.white, // White icon
          ),
        )
      ],
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.sp, // White text with responsive size
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
