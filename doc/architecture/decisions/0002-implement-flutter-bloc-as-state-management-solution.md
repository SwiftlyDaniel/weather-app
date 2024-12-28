# 2. Implement flutter_bloc as state management solution

Date: 2024-12-28

## Status

Accepted

## Context

State management is crucial for handling asynchronous data fetching and UI state transitions. Flutter provides multiple state management solutions. This app requires a predictable state management solution to handle loading indicators, errors, and data presentation.

## Decision

Bloc (`flutter_bloc`) is used as the state management solution because it aligns with Flutter's recommended architecture, which includes presentation, domain, and data layers. It separates concerns by dividing state, event, and bloc logic, which in turn facilitates testing and maintainability. Additionally, flutter_bloc is widely used and has strong community support.

## Consequences

The app's architecture is structured into blocs, models, repositories, and screens. Events trigger state transitions within the blocs, where loading, success, and error states are managed.
