// ignore: unused_import
import 'dart:developer';

import 'package:chat_bot/Models/chatGPTresponse.dart';
import 'package:chat_bot/Services/chatGPTApi.dart';
import 'package:chat_bot/Utils/favorites.dart';
import 'package:chat_bot/Utils/utils.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';


class Prompt extends StatefulWidget {
  const Prompt({super.key});

  @override
  State<Prompt> createState() => _PromptState();
}

class _PromptState extends State<Prompt> {

  

  final TextEditingController _controller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String chatModel = "Ada";

  bool displayPrompt = false;

  bool showFav = false;

  GptResopnse? resopnse;

  generate() async {
    setState(() {
      resopnse = null;
      displayPrompt = true;
    });
    resopnse = await GPTCompletion(
            prompt: _controller.text.trim(), model: MODELS[chatModel])
        .completePrompt();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    // String currentTheme = context.watch<BrightnesMode>().currentTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: myFloatingActionButton("dark"),
      body: myBody(context),
    );
  }

  Widget myFloatingActionButton(String currentTheme) =>
      FabCircularMenu(
        ringDiameter: 400, 
        ringColor: Colors.blue[100],
        children: [
        IconButton(
            onPressed: () {
              if (currentTheme == "dark"){
                // context.read<BrightnesMode>().changeTheme("light");
              }else{
                // context.read<BrightnesMode>().changeTheme("dark");
              }
            },
            iconSize: 40,
            icon: currentTheme == "dark"
                ? const Icon(Icons.light_mode)
                : const Icon(Icons.dark_mode_outlined)),
        showFav
            ? IconButton(
                onPressed: () {
                  showFav = false;
                  setState(() {});
                },
                icon: const Icon(Icons.home),
                iconSize: 40,
              )
            : IconButton(
                onPressed: () {
                  showFav = true;
                  setState(() {});
                },
                icon: const Icon(Icons.favorite),
                iconSize: 40,
              )
      ]);

  Widget myBody(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: ScreenSize(context: context).width / 1.2,
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
                padding: const EdgeInsets.all(10),
                child: showFav
                    ? Center(
                        child: favorites.isEmpty
                            ? const Text("No favorites")
                            : ListView.builder(
                                itemCount: favorites.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${favorites[index]["prompt"]}: ${favorites[index]["model"]}",
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              IconButton(
                                            onPressed: () {
                                              favorites.removeAt(index);
                                              setState(() {});
                                            },
                                            icon: const Icon(Icons.delete),
                                            color: Colors.red,
                                          )
                                            ],
                                          ),
                                          Text(
                                            favorites[index]["response"]
                                                .toString(),
                                            overflow: TextOverflow.clip,
                                          )
                                        ],
                                      ));
                                },
                              ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Enter Prompt Here",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Prompt"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Cannot be empty";
                              }
                              return null;
                            },
                            controller: _controller,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                              const SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: () {
                                  if (resopnse != null) {
                                    favorites.add({
                                      "prompt": _controller.text.trim(),
                                      "response":
                                          resopnse!.choices[0].text.trim(),
                                          "model":chatModel
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(100, 50),
                                    backgroundColor: Colors.red),
                                child: const Icon(Icons.favorite),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          !displayPrompt
                              ? Container()
                              : Container(
                                  padding: const EdgeInsets.all(10),
                                  constraints: const BoxConstraints(
                                      minHeight: 10, maxHeight: 230),
                                  decoration: BoxDecoration(
                                      color: Colors.greenAccent[100],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: SingleChildScrollView(
                                    child: Center(
                                      child: resopnse == null
                                          ? const CircularProgressIndicator()
                                          : Text(
                                              resopnse!.choices[0].text.trim()),
                                    ),
                                  ),
                                ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(70, 40)
                            ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => pickModel(),
                                );
                              },
                              child: Text(chatModel))
                        ],
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  pickModel() {
    Text title = const Text("Pick Chat Model");

    final content = SizedBox(
      height: ScreenSize(context: context).height / 1.5,
      child: Column(
        children: [
          ListTile(
            title: const Text("Davinci"),
            subtitle: const Text("Powerful but slow"),
            onTap: () {
              chatModel = "Davinci";
              setState(() {});
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: const Text("Curie"),
            subtitle: const Text("Very capable, but faster"),
            onTap: () {
              chatModel = "Curie";
              setState(() {});
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: const Text("Babbage"),
            subtitle: const Text("Capable of straightforward tasks, very fast"),
            onTap: () {
              chatModel = "Babbage";
              setState(() {});
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: const Text("Ada"),
            subtitle: const Text("Fastest of all the models"),
            onTap: () {
              chatModel = "Ada";
              setState(() {});
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );

    return AlertDialog(
      title: title,
      content: content,
    );
  }
}
