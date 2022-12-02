## 0.2.0

- Expose helpers for querying NHTSA DB and accessing extended vehicle information (requested by @ride4sun, issue #8)

## 0.1.4+1

- Revert null-safety changes from stable release to satisfy SDK constraints

## 0.1.4

- Support VINs with 2-character manufacturer IDs in their WMI (reported by @huangkaichang, issue #7)
- Fix Uri parsing for NHTSA DB REST API
## 0.2.1-nullsafety

- Support VINs with 2-character manufacturer IDs in their WMI (reported by @huangkaichang, issue #7)

## 0.2.0-nullsafety

- Migrate for null safety

## 0.1.3

- Update dependencies
- Switch from 'final' to 'const' for static map initializers

## 0.1.2

- Add support for VIN generation

## 0.1.1

- Fix up manufacturer lookup for unknown WMIs

## 0.1.0

- Extend decoder to optionally query the `NHTSA Vehicle API` to provide make, model,
  and vehicle type information.
- Elaborate `dartdoc` comments and documentation

## 0.0.1+1

- Restrict the `meta` package version to 1.1.6 to match the Flutter SDK limitations.

## 0.0.1

- Initial version
