class Manufacturer {
  String? id;
  String? name;

  Manufacturer({this.id, this.name});

  Manufacturer.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
    };
  }
}