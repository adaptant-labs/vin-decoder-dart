import 'package:vin_decoder/vin_decoder.dart';

main() {
  var vin = VIN(number: 'WP0ZZZ99ZTS392124');

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
