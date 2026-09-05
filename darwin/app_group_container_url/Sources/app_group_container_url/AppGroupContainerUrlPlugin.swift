// Import the correct Flutter module and UI framework for each platform
#if os(iOS)
  import Flutter
  import UIKit
#elseif os(macOS)
  import FlutterMacOS
  import Cocoa
#endif

public class AppGroupContainerUrlPlugin: NSObject, FlutterPlugin {
  private func subdirectoryURL(appGroupID: String, subDir: String) -> URL? {
    guard !subDir.isEmpty,
      let containerURL = FileManager.default.containerURL(
        forSecurityApplicationGroupIdentifier: appGroupID
      )
    else {
      return nil
    }

    let resolvedContainerURL = containerURL.standardizedFileURL
    let directoryURL =
      resolvedContainerURL
      .appendingPathComponent(subDir, isDirectory: true)
      .standardizedFileURL

    guard directoryURL.path.hasPrefix(resolvedContainerURL.path + "/") else {
      return nil
    }

    return directoryURL
  }

  public static func register(with registrar: FlutterPluginRegistrar) {
    // The registrar's `messenger` is a method on iOS and a property on macOS.
    // Use a compile-time condition to handle this difference.
    #if os(iOS)
      let messenger = registrar.messenger()
    #else
      let messenger = registrar.messenger
    #endif
    let channel = FlutterMethodChannel(name: "app_group_container_url", binaryMessenger: messenger)
    let instance = AppGroupContainerUrlPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      // Use compile-time conditions to return the correct OS version string.
      #if os(iOS)
        result("iOS " + UIDevice.current.systemVersion)
      #elseif os(macOS)
        result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
      #else
        // A fallback for any other Apple platform that might be supported in the future.
        result(FlutterMethodNotImplemented)
      #endif
    case "getUrl", "getPath", "delete":
      guard let arguments = call.arguments as? [String: Any],
        let appGroupID = arguments["appGroupID"] as? String,
        let subDir = arguments["subDir"] as? String,
        let directoryURL = subdirectoryURL(appGroupID: appGroupID, subDir: subDir)
      else {
        result(nil)
        return
      }

      switch call.method {
      case "getUrl":
        result(directoryURL.absoluteString)
      case "getPath":
        result(directoryURL.path)
      case "delete":
        do {
          if FileManager.default.fileExists(atPath: directoryURL.path) {
            try FileManager.default.removeItem(at: directoryURL)
          }
          result(true)
        } catch {
          result(
            FlutterError(
              code: "DELETE_FAILED",
              message: "Unable to delete the subdirectory.",
              details: error.localizedDescription
            ))
        }
      default:
        result(FlutterMethodNotImplemented)
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
