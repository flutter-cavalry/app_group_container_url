
import 'app_group_container_url_platform_interface.dart';

class AppGroupContainerUrl {
  Future<String?> getPlatformVersion() {
    return AppGroupContainerUrlPlatform.instance.getPlatformVersion();
  }
}
