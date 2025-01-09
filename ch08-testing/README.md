# Notes from Lecture Slides
- **Unit Test** `test`: Single function/method/class
  - Verify correctness of a unit of logic
  - Do not read/write to disk
  - Do not render to screen
  - Do not receive user action
- **Widget Test** `flutter_test`: Single widget (or called "Component Test")
- **Integration Test** `integration_test`: Whole or large part of app

---

**Continuous Integration**: run tests automatically on VCS, provide timely feedback

---

Flaky tests are tests that fail if an external source return unexpected results.
To avoid flaky tests, "mock" the dependencies.

---

- `WidgetTester` allows building/interacting with widgets
- `testWidgets()` creates a `WidgetTester` for each testcase, used in place of normal `test()` function.
- `Finder` allows searching for widgets
- Widget-specific `Matcher` constants help verify whether a `Finder` locates a widget or more.

---

* `matchesGoldenFile` matches a widget to a bitmap file (_golden file_ testing)

---

**Best Practices for Integration Tests**
- Focus on core user hourneys
- Use realistic test data
- Isolate external dependencies
- Test on real devices
- Keep tests maintainable