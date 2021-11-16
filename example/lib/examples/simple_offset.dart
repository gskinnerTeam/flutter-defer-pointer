import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';

class SimpleOffsetExample extends StatelessWidget {
  const SimpleOffsetExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: DeferredPointerHandler(
            child: SizedBox(
                width: 100,
                height: 100,
                child: Stack(clipBehavior: Clip.none, children: [
                  Positioned(
                    bottom: -30,
                    child: DeferPointer(child: _SomeBtn(false)),
                  ),
                  Positioned(
                    top: -28,
                    child: DeferPointer(paintOnTop: true, child: _SomeBtn(true)),
                  ),
                  // Content
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(color: Colors.green, boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(1), blurRadius: 4, spreadRadius: 4),
                      ]),
                    ),
                  ),
                ]))));
  }

  Container _SomeBtn(bool showSpinner) {
    return Container(
        color: Colors.grey[300],
        child: TextButton(
          onPressed: () => debugPrint('tap!'),
          child: Row(
            children: [
              const Text('Click me!'),
              if (showSpinner) const SizedBox(width: 20, height: 20, child: CircularProgressIndicator()),
            ],
          ),
        ));
  }
}
