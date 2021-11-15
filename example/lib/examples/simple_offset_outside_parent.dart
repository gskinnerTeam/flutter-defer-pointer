import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';

class SimpleOffsetExample extends StatelessWidget {
  const SimpleOffsetExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DeferredPointerHandler(
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: -30,
              child: DeferPointer(child: _SomeBtn()),
            ),
            Positioned(
              top: -30,
              child: DeferPointer(paintOnTop: true, child: _SomeBtn()),
            ),
            Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(color: Colors.green, boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(1), blurRadius: 4, spreadRadius: 4),
                ])),
          ],
        ),
      ),
    );
  }

  Container _SomeBtn() {
    return Container(
        color: Colors.grey[300],
        child: TextButton(
          onPressed: () => debugPrint('tap!'),
          child: const Text('Click Me!'),
        ));
  }
}
