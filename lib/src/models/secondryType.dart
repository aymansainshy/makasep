class SecondryType {
  final int id;
  final String name;

  SecondryType({this.id, this.name});

  factory SecondryType.fromJson(Map<String, dynamic> json) {
    return SecondryType(
      id: json["id"],
      name: json["name"],
    );
  }
}
