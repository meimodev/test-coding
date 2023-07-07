class Club {
  final String name;

  @override
  String toString() {
    return 'Club{name: $name, city: $city}';
  }

  final String city;

  Club({required this.name, required this.city});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Club &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          city == other.city;

  @override
  int get hashCode => name.hashCode ^ city.hashCode;
}
