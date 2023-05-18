import 'dart:developer';

import 'package:chat_bot/Utils/utils.dart';
import 'package:flutter/material.dart';

import '../Utils/theme.dart';

class Prompt extends StatefulWidget {
  const Prompt({super.key, required this.updateTheme});

  final VoidCallback updateTheme;

  @override
  State<Prompt> createState() => _PromptState();
}

class _PromptState extends State<Prompt> {
  final TextEditingController _controller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool displayPrompt = false;

  generate() {
    setState(() {
      displayPrompt = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: myFloatingActionButton(),
      body: myBody(context),
    );
  }

  FloatingActionButton myFloatingActionButton() => FloatingActionButton(
      onPressed: widget.updateTheme,
      child: (currentTheme == "dark")
          ? const Icon(Icons.light_mode_outlined)
          : const Icon(Icons.dark_mode_outlined));

  Widget myBody(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: ScreenSize(context: context).width / 2,
              height: ScreenSize(context: context).height / 1.5,
              decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset.fromDirection(2),
                      blurRadius: 3,
                    )
                  ]),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Enter Prompt Here",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "Prompt"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Cannot be empty";
                        }
                        return null;
                      },
                      controller: _controller,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          generate();
                        }
                      },
                      child: const Text("Generate"),
                    ),
                    const SizedBox(height: 20),
                    !displayPrompt
                        ? Container()
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.greenAccent[100],
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(_controller.text),
                              ),
                            ),
                          )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
