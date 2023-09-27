import 'manufacturers.dart';
import 'nhtsa_model.dart';
import 'year_map.dart';

class VIN {
  /// The VIN that the class was instantiated with.
  final String number;

  /// The World Manufacturer Identifier (WMI) code for the specified [number].
  final String wmi;

  /// The Vehicle Descriptor Section (VDS) code for the specified [number].
  final String vds;

  /// The Vehicle Identifier Section (VIS) code for the specified [number].
  final String vis;

  /// Try to obtain extended information for the VIN from the NHTSA database.
  final bool extended;
  Map<String, dynamic> _vehicleInfo = {};

  /// Private named constructor. Creates a new VIN. 
  /// 
  /// [wmi], [vds], and [vis] are populated based on [number]. 
  VIN._({required this.number, required this.extended}) : 
    wmi = number.substring(0, 3),
    vds = number.substring(3, 9),
    vis = number.substring(9, 17);

  /// Creates a new VIN. 
  /// 
  /// This factory constructor makes sure the string is normallyed 
  factory VIN({required String vin, bool extended = false}){
    return VIN._(number: normalize(vin), extended: extended);
  }

  /// Carry out VIN validation. A valid [number] must be 17 characters long
  /// and contain only valid alphanumeric characters.
  /// 
  /// If a number is provided, validates that number. Otherwise, it validates the number this object was initialized with.
  bool valid([String? number]) {
    String value = normalize(number != null ? number : this.number);
    return RegExp(r"^[a-zA-Z0-9]+$").hasMatch(value) && value.length == 17;
  }

  /// Provide a normalized VIN string, regardless of the input format.
  static String normalize(String number) =>
      number.toUpperCase().replaceAll('-', '');

  /// Obtain the encoded manufacturing year in YYYY format.
  int getYear() {
    return yearMap[modelYear()] ?? 2001;
  }

  /// Obtain the 2-character region code for the manufacturing region.
  String getRegion() {
    if (RegExp(r"[A-H]", caseSensitive: false).hasMatch(this.number[0])) {
      return "AF";
    }
    if (RegExp(r"[J-R]", caseSensitive: false).hasMatch(this.number[0])) {
      return "AS";
    }
    if (RegExp(r"[S-Z]", caseSensitive: false).hasMatch(this.number[0])) {
      return "EU";
    }
    if (RegExp(r"[1-5]", caseSensitive: false).hasMatch(this.number[0])) {
      return "NA";
    }
    if (RegExp(r"[6-7]", caseSensitive: false).hasMatch(this.number[0])) {
      return "OC";
    }
    if (RegExp(r"[8-9]", caseSensitive: false).hasMatch(this.number[0])) {
      return "SA";
    }
    return "Unknown";
  }

  /// Get the full name of the vehicle manufacturer as defined by the [wmi].
  /// 
  /// If the full name cannot be found, returns null.
  String? getManufacturer() {
    // Check for the standard case - a 3 character WMI
    if (manufacturers.containsKey(this.wmi)) {
      return manufacturers[this.wmi];
    } else {
      // Some manufacturers only use the first 2 characters for manufacturer
      // identification, and the third for the class of vehicle.
      var id = this.wmi.substring(0, 2);
      if (manufacturers.containsKey(id)) {
        return manufacturers[id];
      } else {
        return null;
      }
    }
  }

  /// Returns the checksum for the VIN. Note that in the case of the EU region
  /// checksums are not implemented, so this becomes a no-op. More information
  /// is provided in ISO 3779:2009.
  /// 
  /// If the region is EU, returns null
  String? getChecksum() {
    return (getRegion() != "EU") ? this.number[8] : null;
  }

  /// Extract the single-character model year from the [number].
  String modelYear() => this.number[9];

  /// Extract the single-character assembly plant designator from the [number].
  String assemblyPlant() => this.number[10];

  /// Extract the serial number from the [number].
  String serialNumber() => this.number.substring(12, 17);

  /// Assigns the 
  Future<void> _fetchExtendedVehicleInfo() async {
    if (this._vehicleInfo.isEmpty && extended == true) {
      this._vehicleInfo = await NHTSA.decodeVinValues(this.number) ?? {};
    }
  }

  /// Get the Make of the vehicle from the NHTSA database if [extended] mode
  /// is enabled.
  Future<String> getMakeAsync() async {
    await _fetchExtendedVehicleInfo();
    return this._vehicleInfo['Make'] as String? ?? "";
  }

  /// Get the Make ID of a vehicle from the NHTSA database if the [extended] mode is enabled
  Future<int> getMakeIdAsync() async {
    await _fetchExtendedVehicleInfo();
    return this._vehicleInfo.keys.contains("MakeID") ? int.parse(this._vehicleInfo["MakeID"]): 0;
  }

  /// Get the Model of the vehicle from the NHTSA database if [extended] mode is enabled.
  Future<String> getModelAsync() async {
    await _fetchExtendedVehicleInfo();
    return (this._vehicleInfo.keys.contains("Model") ? this._vehicleInfo['Model'] as String? ?? "Unknown": "Unknown");
  }

  Future<String> getModelIdAsync() async {
    await _fetchExtendedVehicleInfo();
    return (this._vehicleInfo.keys.contains("ModelID") ? this._vehicleInfo['ModelID'] as String? ?? "Unknown": "Unknown");
  }

  /// Get the Vehicle Type from the NHTSA database if [extended] mode is enabled.
  Future<String> getVehicleTypeAsync() async {
    await _fetchExtendedVehicleInfo();
    return (this._vehicleInfo.keys.contains("VehicleType") ? this._vehicleInfo['VehicleType'] as String? ?? "0": "0");
  }

  @override
  String toString() => this.wmi + this.vds + this.vis;
}
