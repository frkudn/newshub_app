import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newshub/consts/shared_prefences.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomNavDrawer extends ConsumerWidget {
  const CustomNavDrawer({super.key});



  @override
  Widget build(BuildContext context, ref) {


    void toggleDarkMode(bool newValue) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(SharedPrefConsts.darkModeValue, newValue);
      ref.read(darkModeStateProvider.notifier).state = newValue;
      print("Darkmode is : $newValue");
    }



    final darkMode = ref.watch(darkModeStateProvider);
    return SizedBox(
      height: 10.h,
      child: Drawer(
        backgroundColor: darkMode?Colors.black:Colors.white,
        width: 50.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            
            ///DarkMode
            ListTile(
              minLeadingWidth: 40.w,
              titleTextStyle:  GoogleFonts.robotoCondensed(fontSize: 16.1.sp, color: darkMode?Colors.white:Colors.black),
              title: const Text(
                "Dark Mode",
              ),
              trailing: Switch.adaptive(
                thumbColor: MaterialStateProperty.all(Colors.pink),
                trackColor: MaterialStateProperty.all(darkMode?Colors.grey:Colors.white),
                value: darkMode,

                ///Changed the DarkMode
                onChanged: (value) {
                  ref.read(darkModeStateProvider.notifier).state =
                      !ref.read(darkModeStateProvider.notifier).state;
                  toggleDarkMode(value);
                },
              ),
            ),
            
           


            Center(child: Text("Made with 💙 by Furqan Uddin", style: TextStyle(fontSize: 13.5.sp),)),
            SizedBox(height: 1.h,)
          ],
        ),
      ),
    );
  }
}

final darkModeStateProvider = StateProvider((ref) => false);
