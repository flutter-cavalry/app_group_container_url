# app_group_container_url

[![pub package](https://img.shields.io/pub/v/app_group_container_url.svg)](https://pub.dev/packages/app_group_container_url)

Flutter plugin for resolving and managing subdirectories in an Apple App Group
container on iOS and macOS.

## Supported platforms

iOS and macOS.

## Setup

Enable the App Groups capability for the iOS or macOS target in Xcode, then add
the group identifier used by your app, such as `group.com.yourcompany.yourapp`.
The identifier passed to this plugin must match that entitlement.

## Usage

```dart
import 'package:app_group_container_url/app_group_container_url.dart';

final appGroup = AppGroupContainerUrl();
const appGroupID = 'group.com.yourcompany.yourapp';
const subDir = 'shared-cache';

final containerPath = await appGroup.getPath(appGroupID);
final url = await appGroup.getUrl(appGroupID, subDir);
final path = await appGroup.getPath(appGroupID, subDir);
final deleted = await appGroup.delete(appGroupID, subDir);
```

## API

`getUrl(appGroupID, [subDir])` returns the App Group container or its
subdirectory as a file URL string, or `null` when the container cannot be
resolved or `subDir` is invalid.

`getPath(appGroupID, [subDir])` returns the App Group container or its
subdirectory's filesystem path, or `null` under the same conditions.

`delete(appGroupID, subDir)` deletes the requested subdirectory and its
contents. It returns `true` when deletion succeeds, including when the
subdirectory does not exist, and throws a `PlatformException` when the deletion
fails.

When omitted or `null`, `subDir` resolves to the App Group container itself.
For `delete`, `subDir` must be non-empty. Paths that attempt to escape the
container, such as `../other-directory`, are rejected.

