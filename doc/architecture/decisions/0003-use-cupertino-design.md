# 3. Use Cupertino design

Date: 2024-12-28

## Status

Accepted

## Context

A Flutter application will be developed as part of a coding challenge. Flutter offers multiple design approaches, including Material Design (primarily for Android) and Cupertino Design (native to iOS).

## Decision

I chose to implement Cupertino's widgets and theme simply because I like it better (being used to Apple's design system) and it does not really matter in this case. This choice also simplifies development by limiting the available widget, icons and styles.

## Consequences

All screens will use widgets from the Cupertino library, and the app will adopt the CupertinoTheme. This decision may make the app less intuitive for Android users, as it will not follow Android design guidelines. However, iOS users will experience a more familiar and cohesive interface. Ultimately, this approach accelerates development by allowing me to focus on app logic while relying on Apple's established design patterns. If testing would be implemented further, it should take this into account.
