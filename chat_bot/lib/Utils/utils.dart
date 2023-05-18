import 'package:flutter/cupertino.dart';

class ScreenSize{

  ScreenSize({
    required this.context
  });

  final BuildContext context;
  late final width = MediaQuery.of(context).size.width;
  late final height = MediaQuery.of(context).size.height;
}