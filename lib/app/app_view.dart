import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/theme/app_theme.dart';
import '../features/feed/presentation/bloc/feed_bloc.dart';
import '../features/feed/presentation/screens/home_feed_screen.dart';
import 'app_dependencies.dart';

class InstagramAppView extends StatelessWidget {
  const InstagramAppView({required this.dependencies, super.key});

  final AppDependencies dependencies;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: dependencies.postRepository),
        RepositoryProvider.value(value: dependencies.loadFeedPageUseCase),
        RepositoryProvider.value(value: dependencies.togglePostLikeUseCase),
        RepositoryProvider.value(value: dependencies.togglePostSaveUseCase),
      ],
      child: BlocProvider(
        create: (context) => FeedBloc(
          loadFeedPageUseCase: dependencies.loadFeedPageUseCase,
          togglePostLikeUseCase: dependencies.togglePostLikeUseCase,
          togglePostSaveUseCase: dependencies.togglePostSaveUseCase,
        )..add(const FeedStarted()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Instagram Feed Replica',
          theme: AppTheme.buildTheme(Brightness.light),
          darkTheme: AppTheme.buildTheme(Brightness.dark),
          themeMode: ThemeMode.system,
          home: const HomeFeedScreen(),
        ),
      ),
    );
  }
}
