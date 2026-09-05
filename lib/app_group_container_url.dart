import 'app_group_container_url_platform_interface.dart';

class AppGroupContainerUrl {
  Future<String?> getUrl(String appGroupID, [String? subDir]) {
    return AppGroupContainerUrlPlatform.instance.getUrl(appGroupID, subDir);
  }

  Future<String?> getPath(String appGroupID, [String? subDir]) {
    return AppGroupContainerUrlPlatform.instance.getPath(appGroupID, subDir);
  }

  Future<bool> delete(String appGroupID, String subDir) {
    return AppGroupContainerUrlPlatform.instance.delete(appGroupID, subDir);
  }
}
