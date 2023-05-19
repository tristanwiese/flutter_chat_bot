// ignore: unused_import
import 'dart:developer';

import 'package:chat_bot/Utils/theme.dart';
import 'package:chat_bot/check_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

// main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => BrightnesMode() )
//       ],
//       child: const Main(),
//       )
//     );
// }

main(){
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  final darkMode = ThemeData.dark();
  final ligthMode = ThemeData.light();

  late var deviceThemeMode;

  bool isDarkMode = false;

  @override
  void initState() {
    deviceThemeMode =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;

    // context.read<BrightnesMode>().initiateTheme(deviceThemeMode);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: isDarkMode ? darkMode : ligthMode,
      home: const CheckNetwork(),
    );
  }

}