import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newshub/consts/images.dart';
import 'package:newshub/consts/shared_prefences.dart';
import 'package:newshub/features/home/ui/home_page.dart';
import 'package:newshub/features/home/widgets/custom_navigation_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  Future<void> getDarkModeValue() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    bool? value = sharedPref.getBool(SharedPrefConsts.darkModeValue);
    if (value != null) {
      ref.read(darkModeStateProvider.notifier).state = value;
      if (kDebugMode) {
        print('Dark Mode Value: $value');
      }
    } else {
      if (kDebugMode) {
        print('Dark Mode Value not found in SharedPreferences');
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDarkModeValue();
    Future.delayed(const Duration(seconds: 3),() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(),)),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset(AppImages.appLogo)],
        ),
      ),
    );
  }
}
