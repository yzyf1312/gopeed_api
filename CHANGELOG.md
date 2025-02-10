## 1.0.5

- Fixed a crash caused by non - iterable objects. The exception was as follows:
  - **Exception Message** : `Unhandled exception: type 'bool' is not a subtype of type 'Iterable<dynamic>'`

## 1.0.4

- Fixed a bug where Function `createAHttpTask` and Function `createABtTask` were unable to accept rid as the value of the `ridOrFileUrl` parameter. Now, developers can pass `true` to the `useRid` parameter to use rid as the value of the `ridOrFileUrl` parameter.

## 1.0.3

- Trying to fix a bug that prevented request headers from being constructed correctly.

## 1.0.2

- Added comments that comply with dart doc conventions.
- Translated Chinese content in `CHANGELOG.md` to English.

## 1.0.1

- Addressed an issue where the library could not be used due to incorrect file paths.

## 1.0.0

- New beginning, good luck 🎉