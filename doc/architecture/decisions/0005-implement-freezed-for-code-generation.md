# 5. Implement freezed for code generation

Date: 2024-12-28

## Status

Accepted

## Context

The app needs models for the weather and forecast. Creating these models is usually repetitive and can lead to errors when a developer must create them by hand as we have to implement many things that are common for every model such as a toString method.

## Decision

I have chosen to integrate the `freezed` package to generate boilerplate code automatically. This decision is influenced by the Flutter team's recommendations, see [Architecture recommendations | Flutter](https://docs.flutter.dev/app-architecture/recommendations).

## Consequences

Using `freezed` simplifies the creation of data models, reducing boilerplate and ensuring consistency. This leads to more maintainable code and accelerates development by automating the model creation.
