/// Represents a world (collection of levels) in the Flutter learning game
/// A world is a themed group of related levels
class WorldModel {
  final String id;
  final String title;
  final String description;
  final String icon; // Emoji or asset path
  final String theme; // e.g., 'Basics', 'Widgets', 'State Management'
  
  // Level IDs in this world (levels loaded separately for scalability)
  final List<String> levelIds;
  
  // Metadata
  final int worldNumber;
  final int requiredStarsToUnlock;
  final bool isLocked;
  final String? imageUrl; // World banner image
  
  // Progress tracking
  final int totalXP; // Total possible XP across all levels
  final Duration? estimatedDuration; // Total time for all levels
  
  // Learning path
  final List<String>? prerequisites; // Previous worlds needed
  final String? nextWorldId;

  const WorldModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.theme,
    required this.levelIds,
    required this.worldNumber,
    this.requiredStarsToUnlock = 0,
    this.isLocked = false,
    this.imageUrl,
    this.totalXP = 0,
    this.estimatedDuration,
    this.prerequisites,
    this.nextWorldId,
  });

  /// Get total number of levels in this world
  int get levelCount => levelIds.length;

  /// Check if world has any prerequisites
  bool get hasPrerequisites => 
      prerequisites != null && prerequisites!.isNotEmpty;

  WorldModel copyWith({
    String? id,
    String? title,
    String? description,
    String? icon,
    String? theme,
    List<String>? levelIds,
    int? worldNumber,
    int? requiredStarsToUnlock,
    bool? isLocked,
    String? imageUrl,
    int? totalXP,
    Duration? estimatedDuration,
    List<String>? prerequisites,
    String? nextWorldId,
  }) {
    return WorldModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      theme: theme ?? this.theme,
      levelIds: levelIds ?? this.levelIds,
      worldNumber: worldNumber ?? this.worldNumber,
      requiredStarsToUnlock: requiredStarsToUnlock ?? this.requiredStarsToUnlock,
      isLocked: isLocked ?? this.isLocked,
      imageUrl: imageUrl ?? this.imageUrl,
      totalXP: totalXP ?? this.totalXP,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      prerequisites: prerequisites ?? this.prerequisites,
      nextWorldId: nextWorldId ?? this.nextWorldId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'theme': theme,
      'levelIds': levelIds,
      'worldNumber': worldNumber,
      'requiredStarsToUnlock': requiredStarsToUnlock,
      'isLocked': isLocked,
      'imageUrl': imageUrl,
      'totalXP': totalXP,
      'estimatedDuration': estimatedDuration?.inMinutes,
      'prerequisites': prerequisites,
      'nextWorldId': nextWorldId,
    };
  }

  factory WorldModel.fromJson(Map<String, dynamic> json) {
    return WorldModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      theme: json['theme'] as String,
      levelIds: List<String>.from(json['levelIds'] as List),
      worldNumber: json['worldNumber'] as int,
      requiredStarsToUnlock: json['requiredStarsToUnlock'] as int? ?? 0,
      isLocked: json['isLocked'] as bool? ?? false,
      imageUrl: json['imageUrl'] as String?,
      totalXP: json['totalXP'] as int? ?? 0,
      estimatedDuration: json['estimatedDuration'] != null
          ? Duration(minutes: json['estimatedDuration'] as int)
          : null,
      prerequisites: json['prerequisites'] != null
          ? List<String>.from(json['prerequisites'] as List)
          : null,
      nextWorldId: json['nextWorldId'] as String?,
    );
  }
}
