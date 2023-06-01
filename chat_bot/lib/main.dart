// ignore: unused_import
import 'dart:developer';

import 'package:chat_bot/Utils/theme.dart';
import 'package:chat_bot/check_network.dart';
import 'package:flutter/material.dart';
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
 
 late Brightness deviceThemeMode;

  @override
  void initState() {
    
   

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BrightnesMode(),
      builder: (context, child) {
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: context.watch<BrightnesMode>().currentTheme,
        home: const CheckNetwork(),
      );
      },
    );
  }

}