## 3.0.0-preview.1

### Breaking Changes

- Upgrade dio to 5.0.0

> Note: To use this package with dio 4.0.0, use version 2.x.x

### Refactors

- Use string interpolation instead of string concatenation

### Chores

- Use `lints` in favor of `pedantic`
- Update dependencies
    - logger (1.0.0 --> 1.2.0)
    - dio (4.0.0 --> 5.0.0)
- Include Dio version map in README

## 2.1.1

- fix: Avoid replacing `extra` property of options (#6)

## 2.1.0

- feat: Ability to print query parameters (Enabled by default: `includeRequestQueryParams` )
- docs: Added example of query parameters print output

## 2.0.1

- Fixed parsing request/response to String
- Fixed handling of JSON response if List

## 2.0.0

- Fully migrated to Null Safety

## 2.0.0-nullsafety.0

- Migration to Null Safety

## 1.0.3

- Added validation for empty body  ([#1](https://github.com/assemmarwan/dio_http_formatter/pull/1))

## 1.0.2

- Include option to filter logging using a function
- Update README and pubspec

## 1.0.0

- Initial version
