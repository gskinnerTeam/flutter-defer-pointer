An alternative to Overlay which allows you to easily render and hit test a widget outside its parent bounds.
_Based on the original idea by @shrouxm here: https://github.com/flutter/flutter/issues/75747#issuecomment-907755810_

Typically in Flutter, if you offset a widget outside of it's parent bounds hit-testing will break. `DeferPointer` works around this issue by handing off hit-testing and (optionally) rendering to an `DeferredPointerHandler` widget further up the tree.

While `Overlay` can solve this issue to some degree, using `DeferPointer` offers some benefits:
* just works: no error prone and tedious layer management
* more granular: you can set the bounds to be any ancestor widget you choose
* more flexible: you can choose to paint the child on top, or not
* easier to align/pin to a widget in the tree as that is the default expectation

This is useful for larger UI components like dropdown menus and sliding panels, as well as just small general styling tweaks.

## 🔨 Installation
```yaml
dependencies:
  defer_pointer: ^0.0.2
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
       child: SizedBox(
           width: 100,
           height: 100,
           child: Stack(clipBehavior: Clip.none, children: [
             // Hang button off the bottom of the content
             Positioned(
               bottom: -30,
               child: DeferPointer(child: _SomeBtn(false)),
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
```

Enable `paintOnTop` if you need the child Widget painted on top of it's siblings. This will defer painting to the currently linked `DeferredPointerHandler`.
```dart
return DeferPointer(
    paintOnTop: true,
    child: TextButton(...));
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
