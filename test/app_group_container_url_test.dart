import 'package:app_group_container_url/app_group_container_url.dart';
import 'package:app_group_container_url/app_group_container_url_method_channel.dart';
import 'package:app_group_container_url/app_group_container_url_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAppGroupContainerUrlPlatform
    with MockPlatformInterfaceMixin
    implements AppGroupContainerUrlPlatform {
  @override
  Future<String?> getUrl(String appGroupID, String? subDir) =>
      Future.value('file:///group/cache');

  @override
  Future<String?> getPath(String appGroupID, String? subDir) =>
      Future.value('/group/cache');

  @override
  Future<bool> delete(String appGroupID, String? subDir) => Future.value(true);
}

void main() {
  final AppGroupContainerUrlPlatform initialPlatform =
      AppGroupContainerUrlPlatform.instance;

  test('$MethodChannelAppGroupContainerUrl is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAppGroupContainerUrl>());
  });

  test('container methods', () async {
    AppGroupContainerUrlPlatform.instance = MockAppGroupContainerUrlPlatform();
    final plugin = AppGroupContainerUrl();

    expect(
      await plugin.getUrl('group.example.app', 'cache'),
      'file:///group/cache',
    );
    expect(await plugin.getPath('group.example.app', 'cache'), '/group/cache');
    expect(await plugin.delete('group.example.app', 'cache'), isTrue);
  });
}
