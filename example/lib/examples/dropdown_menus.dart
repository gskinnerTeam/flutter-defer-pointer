import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:defer_pointer/defer_pointer.dart';

class DropdownMenusExample extends StatelessWidget {
  const DropdownMenusExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Add a [DeferredPointerHandler] handler at the top of the page
    return DeferredPointerHandler(
      child: Column(
        children: [
          Row(children: const [
            RollOverMenuButton(label: 'Menu1', menu: _PlaceholderMenu()),
            RollOverMenuButton(label: 'Menu2', menu: _PlaceholderMenu()),
          ]),
          const Expanded(child: Placeholder())
        ],
      ),
    );
  }
}

class RollOverMenuButton extends StatefulWidget {
  const RollOverMenuButton({Key? key, required this.menu, required this.label}) : super(key: key);
  final String label;
  final Widget menu;

  @override
  State<RollOverMenuButton> createState() => _RollOverMenuButtonState();
}

class _RollOverMenuButtonState extends State<RollOverMenuButton> {
  bool _isMouseOverBtn = false;
  bool _isMouseOverDropdown = false;
  @override
  Widget build(BuildContext context) {
    // Get the intrinsic height of this widget, positioned items will not count against it.
    int height = (context.findRenderObject() as RenderBox?)?.size.height.toInt() ?? 1;
    return MouseRegion(
      onEnter: (_) => setState(() => _isMouseOverBtn = true),
      onExit: (_) => setState(() => _isMouseOverBtn = false),
      child: Stack(
        children: [
          /// Button
          CupertinoButton(child: Text(widget.label), onPressed: () {}),

          /// Dropdown Menu
          if (_isMouseOverBtn || _isMouseOverDropdown)
            Positioned(
              top: height - 2,
              // wrap the entire menu in [DeferPointer] all of the menus child buttons will be deferred
              child: DeferPointer(
                paintOnTop: true,
                child: MouseRegion(
                  onEnter: (_) => setState(() => _isMouseOverDropdown = true),
                  onExit: (_) => setState(() => _isMouseOverDropdown = false),
                  child: widget.menu,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Just a column of buttons, nothing interesting here.
class _PlaceholderMenu extends StatelessWidget {
  const _PlaceholderMenu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        _buildTextButton('Btn 1'),
        _buildTextButton('Btn 2'),
        _buildTextButton('Btn 3'),
        _buildTextButton('Btn 4'),
        _buildTextButton('Btn 5'),
        _buildTextButton('Btn 6'),
        _buildTextButton('Btn 7'),
        _buildTextButton('Btn 8'),
      ]),
    );
  }

  TextButton _buildTextButton(String lbl) {
    return TextButton(
        onPressed: () {},
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 200, minHeight: 40),
          child: Text(lbl),
        ));
  }
}
