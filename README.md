# defer_pointer

An alternative to overlay which allows you to easily hit test a widget outside it's parent bounds.

Works by deferring hit-testing and rendering (optionally) to an ancestor widget that is further up the tree.

## 🔨 Installation
```yaml
dependencies:
  defer_pointer: ^0.0.1
```

### ⚙ Import

```dart
import 'package:defer_pointer/defer_pointer.dart';
```

## 🕹️ Usage

1. Wrap a `DeferredPointerHandler` somewhere above the widget(s) that you need to hit-test.
2. Wrap `DeferPointer` around any widgets that need to hit test outside their parent bounds.
```dart
Widget build(BuildContext context) {
    return DeferredPointerHandler(
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Offset this button outside it's parent stack
            Positioned(
              bottom: -30,
              child: DeferPointer(
                child: TextButton(
                  onPressed: () => debugPrint('tap!'),
                  child: const Text('Click Me!'),
                ),
              ),
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
```

In addition to deferring the hit-test, you can defer the painting as well.

This cases the widget to render inside the `DeferredPointerHandler` instead of it's current parent, which will place it on top of any sibling widgets.
```
return DeferPointer(
    paintOnTop: true,
    child: TextButton(
        onPressed: () => debugPrint('tap!'),
        child: const Text('Click Me!'),
    ));
```

This is very useful for drop-down menus, providing a similar effect to the Overlay widget.


### Manual Linking
By default a `DeferPointer` widget will look up the closest `DeferredPointerHandler` using it's current context. For more complicated use cases you can manually assign a link to bind a pointer to a handler:
```dart
final _deferredPointerLink = DeferredPointerHandlerLink();
...
Widget build(){
    return DeferredPointerHandler(
      link: _deferredPointerLink,
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: DeferPointer(
            link: _deferredPointerLink,
            child: ...,
          )),
    );
}
```
## 🐞 Bugs/Requests

If you encounter any problems please open an issue. If you feel the library is missing a feature, please raise a ticket on Github and we'll look into it. Pull request are welcome.

## 📃 License

MIT License
