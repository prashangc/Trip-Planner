import 'dart:io';

class NavigatorPopModel {
  int? id;
  String? name;
  String? type;
  String? dropDownState;
  File? file;
  double? latitude;
  double? longitude;
  NavigatorPopModel(
      {this.id,
      this.name,
      this.file,
      this.type,
      this.dropDownState,
      this.latitude,
      this.longitude});
}
