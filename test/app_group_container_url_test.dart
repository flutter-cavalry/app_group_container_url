import 'package:flutter_test/flutter_test.dart';
import 'package:app_group_container_url/app_group_container_url.dart';
import 'package:app_group_container_url/app_group_container_url_platform_interface.dart';
import 'package:app_group_container_url/app_group_container_url_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAppGroupContainerUrlPlatform
    with MockPlatformInterfaceMixin
    implements AppGroupContainerUrlPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AppGroupContainerUrlPlatform initialPlatform = AppGroupContainerUrlPlatform.instance;

  test('$MethodChannelAppGroupContainerUrl is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAppGroupContainerUrl>());
  });

  test('getPlatformVersion', () async {
    AppGroupContainerUrl appGroupContainerUrlPlugin = AppGroupContainerUrl();
    MockAppGroupContainerUrlPlatform fakePlatform = MockAppGroupContainerUrlPlatform();
    AppGroupContainerUrlPlatform.instance = fakePlatform;

    expect(await appGroupContainerUrlPlugin.getPlatformVersion(), '42');
  });
}
