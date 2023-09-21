import 'package:flutter/material.dart';
import 'package:newshub/features/home/widgets/custom_navigation_drawer.dart';
import 'package:newshub/features/splash/ui/splash_page.dart';
import 'package:newshub/theme/app_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'features/home/ui/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final darkMode = ref.watch(darkModeStateProvider);
    return ResponsiveSizer(
        builder: (context, orientation, screenType)
    {
      return  MaterialApp(
        debugShowCheckedModeBanner: false,
      title: "NewsHub",
      theme: darkMode?AppTheme.darkMode:AppTheme.light,
      home: const SplashPage(),
    );
    }
    );
  }
}
