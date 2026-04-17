class Manufacturer {
  final String id;
  final String name;

  Manufacturer({
    required this.id,
    required this.name,
  });

  factory Manufacturer.fromJson(Map<String, dynamic> json) {
    return Manufacturer(
      id: json['_id'],
      name: json['name'] ?? '',
    );
  }
}