// ignore: unused_import
import 'dart:developer';

import 'package:chat_bot/Utils/theme.dart';
import 'package:chat_bot/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'Views/prompt.dart';

main() {
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

    if (deviceThemeMode == Brightness.dark) {
      isDarkMode = true;
      currentTheme = "dark";
    } else {
      isDarkMode = false;
      currentTheme = "light";
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: isDarkMode ? darkMode : ligthMode,
        home: Prompt(updateTheme: updateTheme));
  }

  updateTheme() => setState(() {
        if (currentTheme == "light") {
          currentTheme = "dark";
          isDarkMode = true;
        } else {
          currentTheme = "light";
          isDarkMode = false;
        }
      });
}

class Provider extends StatefulWidget {
  const Provider({super.key, required this.updateTheme});

  final VoidCallback updateTheme;

  @override
  State<Provider> createState() => _ProviderState();
}

class _ProviderState extends State<Provider> {
  List<String> strings = ["Strings"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: myFloatingActionButton(),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blue[100],
              // border: Border.all(),
              borderRadius: BorderRadius.circular(20)),
          height: ScreenSize(context: context).height / 1.5,
          width: ScreenSize(context: context).width / 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                child: strings.isNotEmpty?
                ListView.builder(
                  itemCount: strings.length,
                  itemBuilder: (context, i) {
                    return Center(child: Text(strings[i]));
                  },
                )
                :
                const Center(
                  child: Text("No Data..."),
                )
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      addString();
                    },
                    icon: const Icon(Icons.add),
                  ),
                  IconButton(
                    onPressed: () {
                      if (strings.length != 0){
                      removeString();
                      }
                    },
                    icon: const Icon(Icons.remove),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton myFloatingActionButton() => FloatingActionButton(
      onPressed: widget.updateTheme,
      child: (currentTheme == "dark")
          ? const Icon(Icons.light_mode_outlined)
          : const Icon(Icons.dark_mode_outlined));
          
            void addString() {
              strings.add("Strings");
              setState(() {
                
              });
            }
            
              void removeString() {
                strings.removeLast();
                setState(() {
                  
                });
              }
}
