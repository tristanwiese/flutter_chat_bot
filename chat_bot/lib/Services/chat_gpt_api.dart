import 'dart:convert';
import 'dart:developer';

import 'package:chat_bot/Models/chat_gpt_response.dart';
import "package:http/http.dart" as http;

// ignore: non_constant_identifier_names
Map MODELS = {
  "Davinci":"text-davinci-003",
  "Babbage":"text-babbage-001",
  "Curie":"text-curie-001",
  "Ada":"text-ada-001"
} ;

class GPTCompletion{
  GPTCompletion({
    required this.prompt,
    required this.model
  });
  // user provided prompt
  final String prompt;
  // 
  final String model;
  //details to use the api
  final String _ulr = "https://api.openai.com/v1/completions";
  

  

 Future<GptResopnse> completePrompt() async{

  // headers for POST request
  final Map<String, String> headers = {

    "Authorization": "Bearer",
    "Content-Type": "application/json"

  };
  // body for POST request
  final body = jsonEncode({
    
    "model": model,
    "prompt": prompt,
    "max_tokens": 200

  });
    // parse the api url
    final  uri = Uri.parse(_ulr);
    // POST api with headers and body
    final response = await http.post(
      uri,
      headers: headers,
      body: body
      );
    // get response from POST request
    final json = response.body;

    // pass response into custom class to use in application
    return gptResopnseFromJson(json);
  }

}