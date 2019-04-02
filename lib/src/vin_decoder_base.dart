import 'dart:collection';
import 'manufacturers.dart';

class VIN {
  final String number;

  final String wmi;
  final String vds;
  final String vis;

  VIN({@required this.number})
      : wmi = normalize(number).substring(0, 3),
        vds = normalize(number).substring(3, 9),
        vis = normalize(number).substring(9, 17);

  /// Carry out VIN validation. A valid [number] must be 17 characters long
  /// and contain only valid alphanumeric characters.
  bool valid([String number]) {
    String value = normalize(number != null ? number : this.number);
    return RegExp(r"^[a-zA-Z0-9]+$").hasMatch(value) && value.length == 17;
  }

  static String normalize(String number) =>
      number.toUpperCase().replaceAll('-', '');

  int getYear() {
    Map<String, int> map = HashMap<String, int>();

    map['N'] = 1992;
    map['P'] = 1993;
    map['R'] = 1994;
    map['S'] = 1995;
    map['T'] = 1996;
    map['V'] = 1997;
    map['W'] = 1998;
    map['X'] = 1999;
    map['Y'] = 2000;
    map['1'] = 2001;
    map['2'] = 2002;
    map['3'] = 2003;
    map['4'] = 2004;
    map['5'] = 2005;
    map['6'] = 2006;
    map['7'] = 2007;
    map['8'] = 2008;
    map['9'] = 2009;
    map['A'] = 2010;
    map['B'] = 2011;
    map['C'] = 2012;
    map['D'] = 2013;
    map['E'] = 2014;
    map['F'] = 2015;
    map['G'] = 2016;
    map['H'] = 2017;
    map['J'] = 2018;
    map['K'] = 2019;
    map['L'] = 2020;
    map['M'] = 2021;

    return map[modelYear()];
  }

  String getRegion() {
    if (RegExp(r"[A-H]", caseSensitive: false).hasMatch(this.number[0]))
      return "AF";
    if (RegExp(r"[J-R]", caseSensitive: false).hasMatch(this.number[0]))
      return "AS";
    if (RegExp(r"[S-Z]", caseSensitive: false).hasMatch(this.number[0]))
      return "EU";
    if (RegExp(r"[1-5]", caseSensitive: false).hasMatch(this.number[0]))
      return "NA";
    if (RegExp(r"[6-7]", caseSensitive: false).hasMatch(this.number[0]))
      return "OC";
    if (RegExp(r"[8-9]", caseSensitive: false).hasMatch(this.number[0]))
      return "SA";
    return "Unknown";
  }

  String getManufacturer() {
    return manufacturers[this.wmi];
  }

  /// Returns the checksum for the VIN. Note that in the case of the EU region
  /// checksums are not implemented, so this becomes a no-op. More information
  /// is provided in ISO 3779:2009.
  String getChecksum() {
    return (getRegion() != "EU") ? normalize(this.number)[8] : null;
  }

  String modelYear() => normalize(this.number)[9];
  String assemblyPlant() => normalize(this.number)[10];
  String serialNumber() => normalize(this.number).substring(12, 17);

  @override
  String toString() => this.wmi + this.vds + this.vis;
}
