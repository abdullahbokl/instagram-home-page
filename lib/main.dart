import 'package:flutter/widgets.dart';

import 'app.dart';
import 'app/app_dependencies.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(InstagramApp.withDependencies(dependencies: AppDependencies.create()));
}
