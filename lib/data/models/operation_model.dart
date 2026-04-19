// class OperationModel {
//   bool? success;
//   int? total;
//   int? page;
//   int? limit;
//   List<Operation>? data;

//   OperationModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     total = json['total'];
//     page = json['page'];
//     limit = json['limit'];

//     data = (json['data'] as List?)?.map((e) => Operation.fromJson(e)).toList();
//   }
// }

// class Operation {
//   String? id;
//   String? operationCode;
//   String? operationName;
//   String? operationDescription;
//   int? operationType;

//   // ✅ SAFE STRING IDS (handles null + object/string both cases)
//   String? machineId;
//   String? machineName;

//   String? componentId;
//   String? componentName;

//   Operation.fromJson(Map<String, dynamic> json) {
//     id = json['_id']?.toString();
//     operationCode = json['operationCode']?.toString();
//     operationName = json['operationName']?.toString();
//     operationDescription = json['operationDescription']?.toString();

//     operationType = (json['operationType'] is int)
//         ? json['operationType']
//         : int.tryParse(json['operationType']?.toString() ?? '');

//     // ✅ IMPORTANT FIX (handles both string OR object API)
//     machineId = json['machineId'] is Map
//         ? json['machineId']['_id']?.toString()
//         : json['machineId']?.toString();

//     componentId = json['componentId'] is Map
//         ? json['componentId']['_id']?.toString()
//         : json['componentId']?.toString();
//   }
// }
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

  // IDs
  String? machineId;
  String? componentId;

  // DISPLAY NAMES (IMPORTANT FIX)
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

    // ================= MACHINE =================
    if (json['machineId'] is Map) {
      machineId = json['machineId']['_id']?.toString();
      machineName = json['machineId']['machineName']?.toString();
    } else {
      machineId = json['machineId']?.toString();
      machineName = null;
    }

    // ================= COMPONENT =================
    if (json['componentId'] is Map) {
      componentId = json['componentId']['_id']?.toString();
      componentName = json['componentId']['componentName']?.toString();
    } else {
      componentId = json['componentId']?.toString();
      componentName = null;
    }
  }
}