library universal_ui;

// import 'package:flutter_quill/flutter_quill.dart';
// import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

// import '../widgets/responsive_widget.dart';
// import 'fake_ui.dart' if (dart.library.html) 'real_ui.dart' as ui_instance;

// class PlatformViewRegistryFix {
//   void registerViewFactory(dynamic x, dynamic y) {
//     if (kIsWeb) {
//       ui_instance.PlatformViewRegistry.registerViewFactory(
//         x,
//         y,
//       );
//     }
//   }
// }

// class UniversalUI {
//   PlatformViewRegistryFix platformViewRegistry = PlatformViewRegistryFix();
// }

// var ui = UniversalUI();

// class ImageEmbedBuilderWeb extends EmbedBuilder {
//   @override
//   String get key => BlockEmbed.imageType;

//   @override
//   Widget build(
//     BuildContext context,
//     QuillController controller,
//     Embed node,
//     bool readOnly,
//     bool inline,
//     TextStyle textStyle,
//   ) {
//     final imageUrl = node.value.data;
//     if (isImageBase64(imageUrl)) {
//       // TODO: handle imageUrl of base64
//       return const SizedBox();
//     }
//     final size = MediaQuery.sizeOf(context);
//     UniversalUI().platformViewRegistry.registerViewFactory(imageUrl,
//(viewId) {
//       return html.ImageElement()
//         ..src = imageUrl
//         ..style.height = 'auto'
//         ..style.width = 'auto';
//     });
//     return Padding(
//       padding: EdgeInsets.only(
//         right: ResponsiveWidget.isMediumScreen(context)
//             ? size.width * 0.5
//             : (ResponsiveWidget.isLargeScreen(context))
//                 ? size.width * 0.75
//                 : size.width * 0.2,
//       ),
//       child: SizedBox(
//         height: size.height * 0.45,
//         child: HtmlElementView(
//           viewType: imageUrl,
//         ),
//       ),
//     );
//   }
// }

// class VideoEmbedBuilderWeb extends EmbedBuilder {
//   @override
//   String get key => BlockEmbed.videoType;

//   @override
//   Widget build(
//     BuildContext context,
//     QuillController controller,
//     Embed node,
//     bool readOnly,
//     bool inline,
//     TextStyle textStyle,
//   ) {
//     var videoUrl = node.value.data;
//     if (videoUrl.contains('youtube.com') || videoUrl.contains('youtu.be')) {
//       final youtubeID = YoutubePlayer.convertUrlToId(videoUrl);
//       if (youtubeID != null) {
//         videoUrl = 'https://www.youtube.com/embed/$youtubeID';
//       }
//     }

//     final size = MediaQuery.sizeOf(context);

//     UniversalUI().platformViewRegistry.registerViewFactory(
//           videoUrl,
//           (id) => html.IFrameElement()
//             ..width = size.width.toString()
//             ..height = size.height.toString()
//             ..src = videoUrl
//             ..style.border = 'none',
//         );

//     return SizedBox(
//       height: 500,
//       child: HtmlElementView(
//         viewType: videoUrl,
//       ),
//     );
//   }
// }

// List<EmbedBuilder> get defaultEmbedBuildersWeb => [
//       ...FlutterQuillEmbeds.editorsWebBuilders(),
//       // ImageEmbedBuilderWeb(),
//       // VideoEmbedBuilderWeb(),
//     ];
