import 'level_model.dart';

class World {
  final String id;
  final String title;
  final String description;
  final String icon;
  final List<Level> levels;
  final int requiredStars;
  final bool isLocked;

  World({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.levels,
    this.requiredStars = 0,
    this.isLocked = false,
  });

  World copyWith({
    String? id,
    String? title,
    String? description,
    String? icon,
    List<Level>? levels,
    int? requiredStars,
    bool? isLocked,
  }) {
    return World(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      levels: levels ?? this.levels,
      requiredStars: requiredStars ?? this.requiredStars,
      isLocked: isLocked ?? this.isLocked,
    );
  }
}
