class CustomerModel {
  bool? success;
  int? total;
  int? page;
  int? limit;
  List<Customer>? data;

  CustomerModel({
    this.success,
    this.total,
    this.page,
    this.limit,
    this.data,
  });

  CustomerModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    total = json['total'];
    page = json['page'];
    limit = json['limit'];

    if (json['data'] != null) {
      data = List<Customer>.from(
        json['data'].map((x) => Customer.fromJson(x)),
      );
    }
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

class Customer {
  String? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? version;

  Customer({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    version = json['__v'];
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "__v": version,
    };
  }
}