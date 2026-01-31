import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ntcc_dashboard/app.dart';

class MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) => _MockHttpClient();
}

class _MockHttpClient extends Fake implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) =>
      Future.value(_MockHttpClientRequest());
}

class _MockHttpClientRequest extends Fake implements HttpClientRequest {
  @override
  Future<HttpClientResponse> close() => Future.value(_MockHttpClientResponse());
}

class _MockHttpClientResponse extends Fake implements HttpClientResponse {
  @override
  int get statusCode => 200;
  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;
  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream<List<int>>.fromIterable([[]]).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}

void main() {
  HttpOverrides.global = MockHttpOverrides();

  testWidgets('App loads and shows National Overview', (
    WidgetTester tester,
  ) async {
    // Swallow network image errors
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      if (details.exception is NetworkImageLoadException) {
        return;
      }
      originalOnError?.call(details);
    };

    // Set a larger surface size for dashboard testing
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;

    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: NTCCDashboardApp()));

    // Wait for simulated loading timers (e.g., in StatsCard)
    await tester.pump(const Duration(seconds: 2));

    // Verify that the title is present
    expect(find.text('National Dashboard Overview'), findsOneWidget);

    // Restore original error handler
    FlutterError.onError = originalOnError;
  });
}
