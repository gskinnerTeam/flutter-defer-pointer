import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';

/// This is based on the demo here: https://api.flutter.dev/flutter/widgets/Flow-class.html
/// Adds a [DeferredPointerHandler] to the root of the view, and wraps each flowMenuItem in a [DeferPointer].
/// Also requires that the Flow() widget itself be wrapped in a [DeferPointer] with paintOnTop=true
/// todo(sb): figure out why we need to use 2 [DeferPointer] widgets here
class FlowMenuExample extends StatelessWidget {
  const FlowMenuExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: DeferredPointerHandler(
          child: Column(children: [
            Row(
              children: const [
                FlowMenu(),
                Text('I am a title!', style: TextStyle(fontSize: 32)),
              ],
            ),
            const Expanded(child: Placeholder())
          ]),
        ),
      ),
    );
  }
}

class FlowMenu extends StatefulWidget {
  const FlowMenu({Key? key}) : super(key: key);

  @override
  State<FlowMenu> createState() => _FlowMenuState();
}

class _FlowMenuState extends State<FlowMenu> with SingleTickerProviderStateMixin {
  late AnimationController menuAnimation =
      AnimationController(duration: const Duration(milliseconds: 250), vsync: this);
  IconData lastTapped = Icons.notifications;
  final List<IconData> menuItems = <IconData>[
    Icons.home,
    Icons.new_releases,
    Icons.notifications,
    Icons.settings,
    Icons.menu,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _btnSize,
      height: _btnSize,
      child: DeferPointer(
        paintOnTop: true,
        child: Flow(
          clipBehavior: Clip.none,
          delegate: FlowMenuDelegate(menuAnimation: menuAnimation),
          children: menuItems.map<Widget>((IconData icon) {
            return DeferPointer(child: _buildFlowMenuItem(icon));
          }).toList(),
        ),
      ),
    );
  }

  void _updateMenu(IconData icon) {
    if (icon != Icons.menu) {
      setState(() => lastTapped = icon);
    }
  }

  final double _btnSize = 60;
  Widget _buildFlowMenuItem(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: RawMaterialButton(
        fillColor: lastTapped == icon ? Colors.amber[700] : Colors.blue,
        splashColor: Colors.amber[100],
        shape: const CircleBorder(),
        constraints: BoxConstraints.tight(Size(_btnSize, _btnSize)),
        onPressed: () {
          _updateMenu(icon);
          menuAnimation.status == AnimationStatus.completed ? menuAnimation.reverse() : menuAnimation.forward();
        },
        child: Icon(icon, color: Colors.white, size: 12),
      ),
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  FlowMenuDelegate({required this.menuAnimation}) : super(repaint: menuAnimation);

  final Animation<double> menuAnimation;

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) {
    return menuAnimation != oldDelegate.menuAnimation;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    double dx = 0.0;
    for (int i = 0; i < context.childCount; ++i) {
      dx = context.getChildSize(i)!.width * i;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(dx * menuAnimation.value, 0, 0),
      );
    }
  }
}
