import 'package:veloce_task_frontend/data/models/customer_model.dart';

class ComponentModel {
  bool? success;
  int? total;
  int? page;
  int? limit;
  List<Component>? data;

  ComponentModel({
    this.success,
    this.total,
    this.page,
    this.limit,
    this.data,
  });

  factory ComponentModel.fromJson(Map<String, dynamic> json) {
    return ComponentModel(
      success: json['success'],
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      data: json['data'] == null
          ? []
          : List<Component>.from(
              json['data'].map((x) => Component.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "total": total,
      "page": page,
      "limit": limit,
      "data": data?.map((x) => x.toJson()).toList(),
    };
  }
}

class Component {
  String? id;
  String? componentName;
  String? partNo;
  String? ecn;

  Customer? customer;

  String? createdAt;
  String? updatedAt;

  Component({
    this.id,
    this.componentName,
    this.partNo,
    this.ecn,
    this.customer,
    this.createdAt,
    this.updatedAt,
  });

  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(
      id: json['_id']?.toString(),
      componentName: json['componentName'],
      partNo: json['partNo'],
      ecn: json['ecn'],

      // ✅ API gives customerId object
      customer: json['customerId'] != null
          ? Customer.fromJson(json['customerId'])
          : null,

      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "componentName": componentName,
      "partNo": partNo,
      "ecn": ecn,

      // ✅ IMPORTANT: send only ID to backend
      "customerId": customer?.id,
    };
  }
}