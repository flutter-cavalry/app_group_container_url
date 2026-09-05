// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://flutter.dev/to/integration-testing

import 'package:app_group_container_url/app_group_container_url.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('getPath returns null for an unavailable App Group', (
    WidgetTester tester,
  ) async {
    final AppGroupContainerUrl plugin = AppGroupContainerUrl();
    final String? path = await plugin.getPath('group.invalid.app-group');

    expect(path, isNull);
  });
}
