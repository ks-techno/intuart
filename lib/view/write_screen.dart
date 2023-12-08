import 'package:flutter/material.dart';

class WriteScreen extends StatefulWidget {
  @override
  _WriteScreenState createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  TextEditingController _textEditingController = TextEditingController();
  FontWeight _fontWeight = FontWeight.normal;
  FontStyle _fontStyle = FontStyle.normal;
  double _fontSize = 16.0;
  TextAlign _textAlign = TextAlign.left;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Type your text here',
              ),
            ),
            SizedBox(height: 16.0),
            Text('Font Weight:'),
            Row(
              children: [
                buildFontWeightButton('Normal', FontWeight.normal),
                buildFontWeightButton('Bold', FontWeight.bold),
              ],
            ),
            SizedBox(height: 16.0),
            Text('Font Style:'),
            Row(
              children: [
                buildFontStyleButton('Normal', FontStyle.normal),
                buildFontStyleButton('Italic', FontStyle.italic),
              ],
            ),
            SizedBox(height: 16.0),
            Text('Font Size:'),
            DropdownButton<double>(
              value: _fontSize,
              items: [12.0, 16.0, 20.0, 24.0, 28.0]
                  .map<DropdownMenuItem<double>>((double value) {
                return DropdownMenuItem<double>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: ( newValue) {
                setState(() {
                  _fontSize = newValue!;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text('Text Alignment:'),
            Row(
              children: [
                buildTextAlignmentButton('Left', TextAlign.left),
                buildTextAlignmentButton('Center', TextAlign.center),
                buildTextAlignmentButton('Right', TextAlign.right),
              ],
            ),
            SizedBox(height: 16.0),
            Text('Preview:'),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Text(
                _textEditingController.text,
                style: TextStyle(
                  fontSize: _fontSize,
                  fontWeight: _fontWeight,
                  fontStyle: _fontStyle,
                ),
                textAlign: _textAlign,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildFontWeightButton(String label, FontWeight fontWeight) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _fontWeight = fontWeight;
        });
      },
      style: ElevatedButton.styleFrom(
        primary: _fontWeight == fontWeight ? Colors.blue : null,
      ),
      child: Text(label),
    );
  }

  ElevatedButton buildFontStyleButton(String label, FontStyle fontStyle) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _fontStyle = fontStyle;
        });
      },
      style: ElevatedButton.styleFrom(
        primary: _fontStyle == fontStyle ? Colors.blue : null,
      ),
      child: Text(label),
    );
  }

  ElevatedButton buildTextAlignmentButton(String label, TextAlign textAlign) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _textAlign = textAlign;
        });
      },
      style: ElevatedButton.styleFrom(
        primary: _textAlign == textAlign ? Colors.blue : null,
      ),
      child: Text(label),
    );
  }
}

// class WriteScreen extends StatefulWidget {
//   const WriteScreen({super.key});
//
//   @override
//   State<WriteScreen> createState() => _WriteScreenState();
// }
//
// class _WriteScreenState extends State<WriteScreen> {
//   final TextEditingController _textEditingController = TextEditingController();
//   FontWeight _fontWeight = FontWeight.normal;
//   FontStyle _fontStyle = FontStyle.normal;
//   double _fontSize = 16.0;
//   TextAlign _textAlignment = TextAlign.left;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Write'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _textEditingController,
//               maxLines: null,
//               textAlign: _textAlignment,
//               style: TextStyle(
//                 fontSize: _fontSize,
//                 fontWeight: _fontWeight,
//                 fontStyle: _fontStyle,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 DropdownButton<String>(
//                   value: _fontSize.toString(),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       _fontSize = double.parse(newValue!);
//                     });
//                   },
//                   items: ['12.0', '16.0', '20.0', '24.0', '28.0']
//                       .map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.format_bold),
//                   onPressed: () {
//                     setState(() {
//                       _fontWeight =
//                       _fontWeight == FontWeight.bold ? FontWeight.normal : FontWeight.bold;
//                     });
//                   },
//                   color: _fontWeight == FontWeight.bold ? Colors.blue : null,
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.format_italic),
//                   onPressed: () {
//                     setState(() {
//                       _fontStyle =
//                       _fontStyle == FontStyle.italic ? FontStyle.normal : FontStyle.italic;
//                     });
//                   },
//                   color: _fontStyle == FontStyle.italic ? Colors.blue : null,
//                 ),
//                 DropdownButton<TextAlign>(
//                   value: _textAlignment,
//                   onChanged: (TextAlign? newValue) {
//                     setState(() {
//                       _textAlignment = newValue!;
//                     });
//                   },
//                   items: TextAlign.values
//                       .map<DropdownMenuItem<TextAlign>>((TextAlign value) {
//                     return DropdownMenuItem<TextAlign>(
//                       value: value,
//                       child: Text(_textAlignmentToString(value)),
//                     );
//                   }).toList(),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   String _textAlignmentToString(TextAlign alignment) {
//     switch (alignment) {
//       case TextAlign.left:
//         return 'Left';
//       case TextAlign.center:
//         return 'Center';
//       case TextAlign.right:
//         return 'Right';
//       case TextAlign.justify:
//         return 'Justify';
//       default:
//         return '';
//     }
//   }
// }