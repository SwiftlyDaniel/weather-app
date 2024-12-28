# 4. Implement testing libraries

Date: 2024-12-28

## Status

Accepted

## Context

A comprehensive testing strategy is required to ensure the reliability and stability of the Flutter application. This includes unit, widget, golden and integration tests.

## Decision

I have chosen to implement integration tests using the `integration_test` package. For unit and widget tests, I used the official `flutter_test` package and `mocktail` for mocking instead of `mockito` because it simplifies the process of creating the test as I don't need to generate mocks and so on. Additionally, I used `bloc_test` to test Bloc state management. I have also implemented golden testing using the `golden_toolkit` package to ensure visual consistency across different screen sizes and orientations.

## Consequences

The application will have robust test coverage, ensuring major features are verified through integration tests, while unit and widget tests validate individual components and logic. Golden tests will help catch unintended UI changes, providing an extra layer of confidence. This approach streamlines development and reduces the risk of regressions.
