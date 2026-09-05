import 'package:app_group_container_url/app_group_container_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const _appGroupID = 'group.com.yourcompany.yourapp';

  String _containerPath = 'Unknown';
  final _appGroupContainerUrlPlugin = AppGroupContainerUrl();

  @override
  void initState() {
    super.initState();
    _loadContainerPath();
  }

  Future<void> _loadContainerPath() async {
    String containerPath;
    try {
      containerPath =
          await _appGroupContainerUrlPlugin.getPath(_appGroupID) ??
          'Container unavailable';
    } on PlatformException {
      containerPath = 'Failed to get container path.';
    }

    if (!mounted) return;

    setState(() {
      _containerPath = containerPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(child: Text('App Group container: $_containerPath\n')),
      ),
    );
  }
}
