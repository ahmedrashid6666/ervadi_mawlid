import 'package:ervadi/dargas.dart';
import 'package:ervadi/family.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpandableFAB extends StatefulWidget {
  final bool? isDarkTheme; // Optional parameter

  const ExpandableFAB({Key? key, this.isDarkTheme}) : super(key: key);

  @override
  _ExpandableFABState createState() => _ExpandableFABState();
}

class _ExpandableFABState extends State<ExpandableFAB>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleFAB() {
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Use the passed isDarkTheme parameter, or detect from current theme brightness
    final isDarkTheme =
        widget.isDarkTheme ?? (theme.brightness == Brightness.dark);

    // Define colors based on your theme
    final fabBackgroundColor = isDarkTheme
        ? const Color(
            0xFF282828) // Dark theme color (matching ThemeProvider dark primaryColor)
        : const Color(
            0xff074425); // Light theme color (matching ThemeProvider light primaryColor)

    final iconColor = isDarkTheme
        ? Colors.amber // Amber for dark theme
        : Colors.white; // White for light theme

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      reverse: true, // This makes it scroll from right to left
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Button 1 - Nearest Dargas
          ScaleTransition(
            scale: _animation,
            child: Container(
              margin: EdgeInsets.only(right: 8), // Reduced margin
              child: FloatingActionButton.extended(
                heroTag: "btn1",
                onPressed: isExpanded
                    ? () {
                        Get.to(NearestDargas());
                        _toggleFAB();
                      }
                    : null,
                backgroundColor:
                    isExpanded ? fabBackgroundColor : Colors.transparent,
                elevation: isExpanded ? 8 : 0,
                icon: Icon(
                  Icons.location_city,
                  color: iconColor,
                  size: 18, // Slightly smaller icon
                ),
                label: Text(
                  "Nearest Dargas",
                  style: TextStyle(
                    color: iconColor,
                    fontSize: 11, // Slightly smaller text
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          // Button 2 - Shopping
          ScaleTransition(
            scale: _animation,
            child: Container(
              margin: EdgeInsets.only(right: 8), // Reduced margin
              child: FloatingActionButton.extended(
                heroTag: "btn2",
                onPressed: isExpanded
                    ? () {
                        Get.to(ErvadiShaheeedFamilyTree());
                        _toggleFAB();
                      }
                    : null,
                backgroundColor:
                    isExpanded ? fabBackgroundColor : Colors.transparent,
                elevation: isExpanded ? 8 : 0,
                icon: Icon(
                  Icons.people,
                  color: iconColor,
                  size: 18, // Slightly smaller icon
                ),
                label: Text(
                  "Family",
                  style: TextStyle(
                    color: iconColor,
                    fontSize: 11, // Slightly smaller text
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          // Button 3 - Restaurants

          // Main FAB
          FloatingActionButton(
            heroTag: "main",
            onPressed: _toggleFAB,
            backgroundColor: fabBackgroundColor,
            elevation: 8,
            child: AnimatedRotation(
              turns: isExpanded ? 0.125 : 0,
              duration: Duration(milliseconds: 300),
              child: Icon(
                isExpanded ? Icons.close : Icons.add,
                color: iconColor,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
