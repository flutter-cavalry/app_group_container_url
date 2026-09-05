import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'app_group_container_url_method_channel.dart';

abstract class AppGroupContainerUrlPlatform extends PlatformInterface {
  /// Constructs a AppGroupContainerUrlPlatform.
  AppGroupContainerUrlPlatform() : super(token: _token);

  static final Object _token = Object();

  static AppGroupContainerUrlPlatform _instance =
      MethodChannelAppGroupContainerUrl();

  /// The default instance of [AppGroupContainerUrlPlatform] to use.
  ///
  /// Defaults to [MethodChannelAppGroupContainerUrl].
  static AppGroupContainerUrlPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AppGroupContainerUrlPlatform] when
  /// they register themselves.
  static set instance(AppGroupContainerUrlPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> getUrl(String appGroupID, String subDir) {
    throw UnimplementedError('getUrl() has not been implemented.');
  }

  Future<String?> getPath(String appGroupID, String subDir) {
    throw UnimplementedError('getPath() has not been implemented.');
  }

  Future<bool> delete(String appGroupID, String subDir) {
    throw UnimplementedError('delete() has not been implemented.');
  }
}
