
class OperationModel {
  bool? success;
  int? total;
  int? page;
  int? limit;
  List<Operation>? data;

  OperationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    total = json['total'];
    page = json['page'];
    limit = json['limit'];

    data = (json['data'] as List?)
        ?.map((e) => Operation.fromJson(e))
        .toList();
  }
}

class Operation {
  String? id;
  String? operationCode;
  String? operationName;
  String? operationDescription;
  int? operationType;

  
  String? machineId;
  String? componentId;

  String? machineName;
  String? componentName;

  Operation.fromJson(Map<String, dynamic> json) {
    id = json['_id']?.toString();
    operationCode = json['operationCode']?.toString();
    operationName = json['operationName']?.toString();
    operationDescription = json['operationDescription']?.toString();

    operationType = json['operationType'] is int
        ? json['operationType']
        : int.tryParse(json['operationType']?.toString() ?? '');

    if (json['machineId'] is Map) {
      machineId = json['machineId']['_id']?.toString();
      machineName = json['machineId']['machineName']?.toString();
    } else {
      machineId = json['machineId']?.toString();
      machineName = null;
    }

    if (json['componentId'] is Map) {
      componentId = json['componentId']['_id']?.toString();
      componentName = json['componentId']['componentName']?.toString();
    } else {
      componentId = json['componentId']?.toString();
      componentName = null;
    }
  }
}