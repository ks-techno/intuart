import 'package:final_app/view/drawing_page.dart';
import 'package:flutter/cupertino.dart';

class LetsDraw extends StatefulWidget {
  const LetsDraw({super.key});

  @override
  State<LetsDraw> createState() => _LetsDrawState();
}

class _LetsDrawState extends State<LetsDraw> {
  @override
  Widget build(BuildContext context) {
    return DrawingPage();
  }
}
