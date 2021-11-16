import 'package:example/examples/auto_complete.dart';
import 'package:example/examples/flow_menu.dart';
import 'package:flutter/material.dart';

import 'examples/dropdown_menus.dart';
import 'examples/simple_offset.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late TabController tabs = TabController(length: tabBuilders.length, vsync: this);
  List<Widget Function()> tabBuilders = [
    () => const SimpleOffsetExample(),
    () => const DropdownMenusExample(),
    () => const FlowMenuExample(),
    () => const AutoCompleteExample(),
  ];

  @override
  void initState() {
    tabs.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pages = tabBuilders.map((e) => e.call()).toList();
    return MaterialApp(
      home: Scaffold(
        body: Column(children: [
          Expanded(
            //child: IndexedStack(index: tabs.index, children: pages),
            child: TabBarView(controller: tabs, children: pages),
          ),
          TabBar(
            controller: tabs,
            tabs: [
              TextButton(onPressed: () => tabs.index = 0, child: const Text('Offset Buttons')),
              TextButton(onPressed: () => tabs.index = 1, child: const Text('Dropdown Menu')),
              TextButton(onPressed: () => tabs.index = 2, child: const Text('Flow Menu')),
              TextButton(onPressed: () => tabs.index = 3, child: const Text('Auto Complete')),
            ],
          ),
        ]),
      ),
    );
  }
}
