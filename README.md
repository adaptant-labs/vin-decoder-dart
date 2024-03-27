vin-decoder-dart
================

[![Build Status](https://travis-ci.com/adaptant-labs/vin-decoder-dart.svg?branch=master)](https://app.travis-ci.com/github/adaptant-labs/vin-decoder-dart)
[![Pub](https://img.shields.io/pub/v/vin_decoder.svg)](https://pub.dartlang.org/packages/vin_decoder)

A VIN decoding, validation, and generation library for Dart.

`vin_decoder` provides a simple decoding and validation library for Vehicle Identification Numbers (VINs) based on
ISO 3779:2009 and World Manufacturer Identifiers (WMIs) based on ISO 3780:2009. It further supports generation of
synthetic VINs derived from valid WMIs.

The decoder can be used standalone in an offline mode (the default behaviour, as per earlier versions of the API), or
can be further enriched by querying additional VIN information from the [NHTSA Vehicle API][nhtsa], such as the precise
make, model, and vehicle type in extended mode. Note that synthetic VINs will fail lookup in the NHTSA API, and should
only be used for experimentation.

[nhtsa]: https://vpic.nhtsa.dot.gov/api/Home
  
## Usage

A simple usage example:

```dart
import 'package:vin_decoder/vin_decoder.dart';

void main() async {
  var vin = VIN(number: 'WP0ZZZ99ZTS392124', extended: true);

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

  // The following calls are to the NHTSA DB, and are carried out asynchronously
  var make = await vin.getMakeAsync();
  print("Make is ${make}");

  var model = await vin.getModelAsync();
  print("Model is ${model}");

  var type = await vin.getVehicleTypeAsync();
  print("Type is ${type}");

  var generated = VINGenerator().generate();
  print('Randomly Generated VIN is ${generated}');
}
```

which produces the following:

```shell script
WMI: WP0
VDS: ZZZ99Z
VIS: TS392124
Model year is T
Serial number is 92124
Assembly plant is S
Manufacturer is Porsche
Year is 1996
Region is EU
VIN string is WP0ZZZ99ZTS392124
Make is Porsche
Model is 911
Type is Passenger Car
Randomly Generated VIN is NM4BW3NK0WA418856
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/adaptant-labs/vin-decoder-dart/issues

## License

Licensed under the terms of the Apache 2.0 license, the full version of which can be found in the
[LICENSE](https://raw.githubusercontent.com/adaptant-labs/vin-decoder-dart/master/LICENSE)
file included in the distribution.
