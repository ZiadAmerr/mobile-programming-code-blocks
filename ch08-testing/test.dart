// Add dependency
/** flutter pub add dev:test */

// Import
import 'package:flutter_test/flutter_test.dart';

// Single test
  int add(int a, int b) => a + b;

  void main() {
    test('Add function test', () {
        expect(add(2, 3), 5);
    });
  }

---
---

// Group
  // (assume Counter is initialized in its own file)
  void main() {
    group('Test start, increment, decrement', () {
        test('value should start at 0', () {
          expect(Counter().value, 0);
        });
        test('value should be incremented', () {
          final counter = Counter();
          counter.increment();
          expect(counter.value, 1);
        });
        test('value should be decremented', () {
          final counter = Counter();
          counter.decrement();
          expect(counter.value, -1);
        });
    });
  }

---
---

// Mockito
  // Create new fetchAlbum function that takes a client
    // fetchAlbum now takes a client parameter that is used to make the HTTP request.
    // This modification allows you to pass a mock client to fetchAlbum in your tests.
    Future<Album> fetchAlbum(http.Client client) async {
      final response = await client.get(Uri.parse(LINK_URL));
      if (response.statusCode == 200) { // Success
        return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else { // Failure
        throw Exception('Failed to load album');
      }
    }
  
  // Create a mock client
    @GenerateMocks([http.Client])  // Create a mock client
    void main() {
      // Tests will go here later
    }
  
  // Get the mocks
    >$ dart run build_runner build // Generate the mocks
    // The build_runner generates the mocks in a
    // new file called fetch_album_test.mocks.dart

  // Use the mocks
    final client = MockClient();
    when(client.get(Uri.parse(LINK_URL))) // Mock the client
        .thenAnswer((_) async => // Answer the request
        http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200)); // Provide a response
    expect(await fetchAlbum(client), isA<Album>()); // Test the function


---
---

// WidgetTesting
  void main() {
    // Assuming the widget is already defined in the running app

    testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
      await tester.pumpWidget(MyWidget(title: 'T', message: 'M')); // Build the widget
      expect(find.text('T'), findsOneWidget); // Find the title
      expect(find.text('M'), findsOneWidget); // Find the message
    });
  }

---
---

// Integration Test
  void main() {
    // Initialize the integration test framework.
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
    group('end-to-end test', () {
      testWidgets('tap on the floating action button, verify counter', (tester) async {
        // Load the app widget.
        await tester.pumpWidget(const MyApp());
  
        // Verify the counter starts at 0.
        expect(find.text('0'), findsOneWidget);
  
        // Find the floating action button using a ValueKey.
        final fab = find.byKey(const ValueKey('increment'));
  
        // Simulate a tap on the floating action button.
        await tester.tap(fab);
  
        // Wait for the UI to update.
        await tester.pumpAndSettle();
  
        // Verify the counter increments to 1.
        expect(find.text('1'), findsOneWidget);
      });
    });
  }
