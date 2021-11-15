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

1. Wrap a `DeferredPointerHandler` somewhere above the buttons that you wish to hit-test.
2. Wrap `DeferPointer` around the buttons themselves.
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

In addition to deferring the hit-test, you can defer the painting as well. This causes the child of `DeferHit` to render inside the `DeferredPointerHandler` instead of its current parent, which will place it on top of any sibling widgets.
```dart
return DeferPointer(
    paintOnTop: true,
    child: TextButton(
        onPressed: () => debugPrint('tap!'),
        child: const Text('Click Me!'),
    ));
```


### Examples
There are 4 examples in this repo:

1. A simple example of offsetting 2 buttons outside their stack:
https://github.com/gskinnerTeam/flutter-defer-pointer/blob/master/example/lib/examples/simple_offset_outside_parent.dart

2. A classic desktop/web style dropdown menu:
https://github.com/gskinnerTeam/flutter-defer-pointer/blob/master/example/lib/examples/dropdown_menus.dart

3. A animated menu based on the `Flow` widget: 
https://github.com/gskinnerTeam/flutter-defer-pointer/blob/master/example/lib/examples/flow_menu.dart

4. A auto-complete search field:
https://github.com/gskinnerTeam/flutter-defer-pointer/blob/master/example/lib/examples/auto_complete.dart

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
