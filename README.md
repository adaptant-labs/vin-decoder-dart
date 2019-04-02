vin-decoder-dart
================

[![Build Status](https://travis-ci.com/adaptant-labs/vin-decoder-dart.svg?branch=master)](https://travis-ci.com/adaptant-labs/vin-decoder-dart#)
[![Pub](https://img.shields.io/pub/v/vin_decoder.svg)](https://pub.dartlang.org/packages/vin_decoder)

A VIN decoding and validation library for Dart.

`vin_decoder` provides a simple decoding and validation library for Vehicle Identification Numbers (VINs) based on
ISO 3779:2009 and World Manufacturer Identifiers (WMIs) based on ISO 3780:2009.
  
## Usage

A simple usage example:

```dart
import 'package:vin_decoder/vin_decoder.dart';

main() {
  VIN vin = VIN(number: 'WP0ZZZ99ZTS392124');
  
   print('WMI: ${vin.wmi}');
   print('VDS: ${vin.vds}');
   print('VIS: ${vin.vis}');
  
   print("Model year is " + vin.modelYear());
   print("Serial number is " + vin.serialNumber());
   print("Assembly plant is " + vin.assemblyPlant());
   print("Manufacturer is " + vin.getManufacturer());
   print("Year is " + vin.getYear().toString());
   print("Region is " + vin.getRegion());
   print("VIN string is " + vin.toString());
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/adaptant-labs/vin-decoder-dart/issues

## License

Licensed under the terms of the Apache 2.0 license, the full version of which can be found in the
[LICENSE](https://raw.githubusercontent.com/adaptant-labs/vin-decoder-dart/master/LICENSE)
file included in the distribution.
