import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'app_group_container_url_platform_interface.dart';

/// An implementation of [AppGroupContainerUrlPlatform] that uses method channels.
class MethodChannelAppGroupContainerUrl extends AppGroupContainerUrlPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('app_group_container_url');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }
}
