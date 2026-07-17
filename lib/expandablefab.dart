import 'package:ervadi/dargas.dart';
import 'package:ervadi/family.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpandableFAB extends StatelessWidget {
  final bool? isDarkTheme; // Optional parameter

  const ExpandableFAB({Key? key, this.isDarkTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Use the passed isDarkTheme parameter, or detect from current theme brightness
    final isDarkTheme =
        this.isDarkTheme ?? (theme.brightness == Brightness.dark);

    // Define colors based on your theme
    final fabBackgroundColor = isDarkTheme
        ? const Color(
            0xFF282828) // Dark theme color (matching ThemeProvider dark primaryColor)
        : const Color(
            0xff074425); // Light theme color (matching ThemeProvider light primaryColor)

    final iconColor = isDarkTheme
        ? Colors.amber // Amber for dark theme
        : Colors.white; // White for light theme

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Button 1 - Nearest Dargas
        FloatingActionButton.extended(
          heroTag: "btn1",
          onPressed: () => Get.to(NearestDargas()),
          backgroundColor: fabBackgroundColor,
          elevation: 8,
          icon: Icon(
            Icons.location_city,
            color: iconColor,
            size: 20,
          ),
          label: Text(
            "Nearest Dargas",
            style: TextStyle(
              color: iconColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(width: 12),

        // Button 2 - Family
        FloatingActionButton.extended(
          heroTag: "btn2",
          onPressed: () => Get.to(ErvadiShaheeedFamilyTree()),
          backgroundColor: fabBackgroundColor,
          elevation: 8,
          icon: Icon(
            Icons.people,
            color: iconColor,
            size: 20,
          ),
          label: Text(
            "Family",
            style: TextStyle(
              color: iconColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
