import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';

class AutoCompleteExample extends StatelessWidget {
  const AutoCompleteExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DeferredPointerHandler(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _ExpandingSearchBox(),
              const Expanded(child: Center(child: Placeholder())),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpandingSearchBox extends StatelessWidget {
  _ExpandingSearchBox({Key? key}) : super(key: key);
  final ValueNotifier<String> _textNotifier = ValueNotifier("");

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _textNotifier,
      builder: (_, __) {
        double size = (context.findRenderObject() as RenderBox?)?.size.height ?? 1;
        String value = _textNotifier.value;
        return Stack(
          children: [
            // Search Box
            TextFormField(
                decoration: const InputDecoration(hintText: 'Enter search text'),
                onChanged: (value) => _textNotifier.value = value),
            // Search Suggestions Dropdown
            if (value != "")
              Positioned(
                top: size - 5,
                left: -1,
                right: -1,
                child: DeferPointer(
                  paintOnTop: true,
                  child: _SearchResults(query: value),
                ),
              )
          ],
        );
      },
    );
  }
}

class _SearchResults extends StatelessWidget {
  final String query;

  const _SearchResults({Key? key, required this.query}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade200,
      constraints: const BoxConstraints(maxHeight: 300),
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(
              query.length,
              (i) => TextButton(
                  child: const SizedBox(height: 30, width: double.infinity, child: Text("Some Suggestion... ")),
                  onPressed: () {})),
        ),
      ),
    );
  }
}
