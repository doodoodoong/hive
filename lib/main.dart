import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('themeData');
  runApp(const DarkModeDemo());
}

class DarkModeDemo extends StatelessWidget {
  const DarkModeDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box('themeData').listenable(keys: ['darkMode']),
      builder: (context, box, child) {
        var darkMode = box.get('darkMode', defaultValue: false);
        return MaterialApp(
          themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Hive Dark Mode Demo'),
            ),
            body: Center(
              child: Column(
                children: [
                  Switch(
                    value: darkMode,
                    onChanged: (value) {
                      box.put('darkMode', value);
                    },
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Card Color'),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
