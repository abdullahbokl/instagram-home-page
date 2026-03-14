import 'package:flutter/material.dart';

class AppErrorState extends StatelessWidget {
  const AppErrorState({
    required this.title,
    required this.actionLabel,
    required this.onActionPressed,
    this.icon = Icons.wifi_off_rounded,
    this.topPadding = 0,
    super.key,
  });

  final String title;
  final String actionLabel;
  final VoidCallback onActionPressed;
  final IconData icon;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 38),
              const SizedBox(height: 14),
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextButton(onPressed: onActionPressed, child: Text(actionLabel)),
            ],
          ),
        ),
      ),
    );
  }
}
