class MachineModel {
  final int? id;
  final String machineName;
  final String serialNumber;
  final int manufacturerId;
  final String model;
  final int year;
  final int type;
  final int locationId;

  MachineModel({
    this.id,
    required this.machineName,
    required this.serialNumber,
    required this.manufacturerId,
    required this.model,
    required this.year,
    required this.type,
    required this.locationId,
  });

  factory MachineModel.fromJson(Map<String, dynamic> json) {
    return MachineModel(
      id: json['id'],
      machineName: json['machineName'],
      serialNumber: json['machineSerialNumber'],
      manufacturerId: json['machineManufacturerId'],
      model: json['machineModel'],
      year: json['yearOfManufacture'],
      type: json['typeOfMachine'],
      locationId: json['locationId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "machineName": machineName,
      "machineSerialNumber": serialNumber,
      "machineManufacturerId": manufacturerId,
      "machineModel": model,
      "yearOfManufacture": year,
      "typeOfMachine": type,
      "locationId": locationId,
    };
  }
}