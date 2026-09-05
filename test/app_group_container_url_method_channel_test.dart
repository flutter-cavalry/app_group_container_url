import 'package:app_group_container_url/app_group_container_url_method_channel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelAppGroupContainerUrl platform =
      MethodChannelAppGroupContainerUrl();
  const MethodChannel channel = MethodChannel('app_group_container_url');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          switch (methodCall.method) {
            case 'getUrl':
              final arguments = methodCall.arguments as Map<Object?, Object?>;
              expect(arguments['appGroupID'], 'group.example.app');
              return arguments['subDir'] == null
                  ? 'file:///group'
                  : 'file:///group/cache';
            case 'getPath':
              final arguments = methodCall.arguments as Map<Object?, Object?>;
              expect(arguments['appGroupID'], 'group.example.app');
              return arguments['subDir'] == null ? '/group' : '/group/cache';
            case 'delete':
              expect(methodCall.arguments, {
                'appGroupID': 'group.example.app',
                'subDir': 'cache',
              });
              return true;
          }
          return null;
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getUrl', () async {
    expect(
      await platform.getUrl('group.example.app', 'cache'),
      'file:///group/cache',
    );
  });

  test('getUrl returns the container URL without a subdirectory', () async {
    expect(await platform.getUrl('group.example.app', null), 'file:///group');
  });

  test('getPath', () async {
    expect(
      await platform.getPath('group.example.app', 'cache'),
      '/group/cache',
    );
  });

  test('getPath returns the container path without a subdirectory', () async {
    expect(await platform.getPath('group.example.app', null), '/group');
  });

  test('delete', () async {
    expect(await platform.delete('group.example.app', 'cache'), isTrue);
  });
}
