import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../view/drawing_canvas/models/drawing_mode.dart';

class ColorDialog extends StatefulWidget {
  const ColorDialog({Key? key}) : super(key: key);

  @override
  State<ColorDialog> createState() => _ColorDialogState();
}

class _ColorDialogState extends State<ColorDialog> {
  // final ValueNotifier<DrawingMode> drawingMode = ValueNotifier(DrawingMode.eraser);

  @override
  Widget build(BuildContext context) {
    Rx<DrawingMode> drawingMode = Rx<DrawingMode>(DrawingMode.eraser);

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 5,
            runSpacing: 5,
            children: [
              _IconBox(
                iconData: FontAwesomeIcons.pencil,
                selected: drawingMode.value == DrawingMode.pencil,
                onTap: () {
                  drawingMode.value = DrawingMode.pencil;
                   setState(() {
                    
                  });
                  print(drawingMode.value);
                },
                tooltip: 'Pencil',
              ),
              _IconBox(
                selected: drawingMode.value == DrawingMode.line,
                onTap: () {
                  
                  drawingMode.value = DrawingMode.line;
                 
                   print(drawingMode.value);
                },
                tooltip: 'Line',
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 22,
                      height: 2,
                      color: drawingMode.value == DrawingMode.line
                          ? Colors.white
                          : Colors.white54,
                          // ? Colors.grey[900]
                          // : Colors.grey,
                    ),
                  ],
                ),
              ),
              _IconBox(
                iconData: Icons.hexagon_outlined,
                selected: drawingMode.value == DrawingMode.polygon,
                onTap: () {
                  drawingMode.value = DrawingMode.polygon;
                   setState(() {
                    
                  });
                },
                tooltip: 'Polygon',
              ),
              _IconBox(
                iconData: FontAwesomeIcons.eraser,
                selected: drawingMode.value == DrawingMode.eraser,
                onTap: () {
                  drawingMode.value = DrawingMode.eraser;
                   setState(() {
                    
                  });
                },
                tooltip: 'Eraser',
              ),
              _IconBox(
                iconData: FontAwesomeIcons.square,
                selected: drawingMode.value == DrawingMode.square,
                onTap: () {
                  drawingMode.value = DrawingMode.square;
                   setState(() {
                    
                  });
                },
                tooltip: 'Square',
              ),
              _IconBox(
                iconData: FontAwesomeIcons.circle,
                selected: drawingMode.value == DrawingMode.circle,
                onTap: () {
                  drawingMode.value = DrawingMode.circle;
                   setState(() {
                    
                  });
                },
                tooltip: 'Circle',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  final IconData? iconData;
  final Widget? child;
  final bool selected;
  final VoidCallback onTap;
  final String? tooltip;

  const _IconBox({
    Key? key,
    this.iconData,
    this.child,
    this.tooltip,
    required this.selected,
    required this.onTap,
  }) : assert(child != null || iconData != null),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            border: Border.all(
              color: selected ? Colors.grey[900]! : Colors.grey,
              width: 1.5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Tooltip(
            message: tooltip,
            preferBelow: false,
            child: child ??
                Icon(
                  iconData,
                  color: selected ? Colors.grey[900] : Colors.grey,
                  size: 20,
                ),
          ),
        ),
      ),
    );
  }
}
