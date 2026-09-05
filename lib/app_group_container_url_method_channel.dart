import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'app_group_container_url_platform_interface.dart';

/// An implementation of [AppGroupContainerUrlPlatform] that uses method channels.
class MethodChannelAppGroupContainerUrl extends AppGroupContainerUrlPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('app_group_container_url');

  @override
  Future<String?> getUrl(String appGroupID, String? subDir) {
    return methodChannel.invokeMethod<String>('getUrl', {
      'appGroupID': appGroupID,
      'subDir': subDir,
    });
  }

  @override
  Future<String?> getPath(String appGroupID, String? subDir) {
    return methodChannel.invokeMethod<String>('getPath', {
      'appGroupID': appGroupID,
      'subDir': subDir,
    });
  }

  @override
  Future<bool> delete(String appGroupID, String subDir) async {
    return await methodChannel.invokeMethod<bool>('delete', {
          'appGroupID': appGroupID,
          'subDir': subDir,
        }) ??
        false;
  }
}
