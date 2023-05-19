import 'package:chat_bot/Views/prompt.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class CheckNetwork extends StatefulWidget {
  const CheckNetwork({
    required this.updateTheme,
    super.key
    });

    final VoidCallback updateTheme;

  @override
  State<CheckNetwork> createState() => _CheckNetworkState();
}

class _CheckNetworkState extends State<CheckNetwork> {

  bool connected = false;

  bool noInternet = false;

  @override
  void initState() {

    checkNetwork();

    super.initState();
  }

  updateThemeFun()=> widget.updateTheme;

  checkNetwork() async{
    setState(() {
      connected = false;
    });
    try {
  final result = await InternetAddress.lookup('google.com');
  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    print('connected');
  setState(() {
    connected = true;
    noInternet = false;
  });
  }
} on SocketException catch (_) {
  print('not connected');
  setState(() {
    noInternet = true;
  });
  
}
  }

  @override
  Widget build(BuildContext context) {
    return noInternet?

    Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off_sharp,
            size: 50,
            ),
            const Text("Not Connected!"),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(
                ),
                minimumSize: Size(50,50)
              ),
              onPressed: () => checkNetwork(), 
              child: const Icon(Icons.replay_outlined)
              )
          ],
        ),
      ),
    )
    :
    connected?

    Prompt(updateTheme: updateThemeFun)
    :
    const CircularProgressIndicator();
  }
}