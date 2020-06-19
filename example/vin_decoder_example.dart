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
