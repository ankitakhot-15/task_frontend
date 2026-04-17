class Location {
  final String id;
  final String name;
  final double latitude;
  final double longitude;

  Location({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['_id'],
      name: json['name'] ?? '',
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
    );
  }
}