import 'package:flutter/material.dart';

import 'app/app_dependencies.dart';
import 'app/app_view.dart';
import 'features/feed/data/repositories/post_repository.dart';

class InstagramApp extends StatelessWidget {
  InstagramApp({required PostRepository repository, super.key})
    : dependencies = AppDependencies.fromRepository(repository);

  const InstagramApp.withDependencies({
    required this.dependencies,
    super.key,
  });

  final AppDependencies dependencies;

  @override
  Widget build(BuildContext context) {
    return InstagramAppView(dependencies: dependencies);
  }
}
