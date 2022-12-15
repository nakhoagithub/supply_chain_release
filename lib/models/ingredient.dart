class Ingredient {
  final String? id;
  final String? name;
  final String? idHistory;
  Ingredient({
    required this.id,
    required this.name,
    required this.idHistory,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        id: json["id"],
        name: json["name"],
        idHistory: json['idHistory'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "idHistory": idHistory,
      };
}
