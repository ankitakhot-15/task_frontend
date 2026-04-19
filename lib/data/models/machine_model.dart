class MachineModel {
  bool? success;
  int? total;
  int? page;
  int? limit;
  List<Machine>? data;

  MachineModel({
    this.success,
    this.total,
    this.page,
    this.limit,
    this.data,
  });

  MachineModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    total = json['total'];
    page = json['page'];
    limit = json['limit'];

    data = (json['data'] as List?)
        ?.map((e) => Machine.fromJson(e))
        .toList();
  }
}

class Machine {
  String? id;
  String? machineName;
  String? serialNumber;
  String? model;
  int? year;

  Machine.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    machineName = json['machineName'];
    serialNumber = json['serialNumber'];
    model = json['model'];
    year = json['year'];
  }
}