import 'package:flutter/material.dart';

class AppShimmerScaffold extends StatelessWidget {
  const AppShimmerScaffold({required this.slivers, super.key});

  final List<Widget> slivers;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: slivers,
    );
  }
}
