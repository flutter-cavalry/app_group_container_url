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
            case 'getPlatformVersion':
              return '42';
            case 'getUrl':
              expect(methodCall.arguments, {
                'appGroupID': 'group.example.app',
                'subDir': 'cache',
              });
              return 'file:///group/cache';
            case 'getPath':
              expect(methodCall.arguments, {
                'appGroupID': 'group.example.app',
                'subDir': 'cache',
              });
              return '/group/cache';
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

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });

  test('getUrl', () async {
    expect(
      await platform.getUrl('group.example.app', 'cache'),
      'file:///group/cache',
    );
  });

  test('getPath', () async {
    expect(
      await platform.getPath('group.example.app', 'cache'),
      '/group/cache',
    );
  });

  test('delete', () async {
    expect(await platform.delete('group.example.app', 'cache'), isTrue);
  });
}
