// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
//
// class WriteScreen extends StatefulWidget {
//   const WriteScreen({super.key});
//
//   @override
//   State<WriteScreen> createState() => _WriteScreenState();
// }
//
// class _WriteScreenState extends State<WriteScreen> {
//   TextEditingController? _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController()..text = 'Type your text here';
//   }
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Write'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.save),
//             onPressed: () {
//               // Implement save functionality
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: RichTextEditor(
//                 key: GlobalKey(),
//                 controller: _controller,
//                 editorOptions: EditorOptions(
//                   hintText: 'Type your text here',
//                   defaultStyle: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// }
//
