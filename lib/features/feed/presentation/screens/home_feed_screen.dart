import 'package:flutter/material.dart';

import '../widgets/instagram_bottom_nav_bar.dart';
import '../widgets/feed_screen_content.dart';

class HomeFeedScreen extends StatelessWidget {
  const HomeFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const InstagramBottomNavBar(),
      body: const FeedScreenContent(),
    );
  }
}
