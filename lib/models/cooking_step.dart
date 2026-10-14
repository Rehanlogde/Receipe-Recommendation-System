class CookingStep {
  const CookingStep({
    required this.order,
    required this.instruction,
    this.durationMinutes,
  });

  final int order;
  final String instruction;
  final int? durationMinutes;

  factory CookingStep.fromJson(Map<String, dynamic> json) {
    return CookingStep(
      order: json['order'] as int,
      instruction: json['instruction'] as String,
      durationMinutes: json['durationMinutes'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order': order,
      'instruction': instruction,
      'durationMinutes': durationMinutes,
    };
  }
}
