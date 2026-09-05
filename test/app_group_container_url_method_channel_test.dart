import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_group_container_url/app_group_container_url_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelAppGroupContainerUrl platform = MethodChannelAppGroupContainerUrl();
  const MethodChannel channel = MethodChannel('app_group_container_url');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          return '42';
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
