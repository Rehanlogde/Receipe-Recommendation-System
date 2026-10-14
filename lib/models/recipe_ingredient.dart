class RecipeIngredient {
  const RecipeIngredient({
    required this.ingredientId,
    required this.name,
    required this.quantity,
    this.unit,
  });

  final String ingredientId;
  final String name;
  final String quantity;
  final String? unit;

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) {
    return RecipeIngredient(
      ingredientId: json['ingredientId'] as String,
      name: json['name'] as String,
      quantity: json['quantity'] as String,
      unit: json['unit'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ingredientId': ingredientId,
      'name': name,
      'quantity': quantity,
      'unit': unit,
    };
  }

  String get displayQuantity {
    if (unit == null || unit!.isEmpty) return quantity;
    return '$quantity $unit';
  }
}
