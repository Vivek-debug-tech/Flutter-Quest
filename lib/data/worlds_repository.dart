import '../models/world_model_v2.dart';

/// Repository for World data
/// Contains all world definitions
/// Can be extended to load from API/database in the future
class WorldsRepository {
  /// Load all worlds in the game
  List<WorldModel> loadWorlds() {
    return [
      _world1_FlutterBasics(),
      _world2_Widgets(),
      _world3_StateManagement(),
      _world4_Navigation(),
      _world5_Advanced(),
    ];
  }

 // ============================================
  // WORLD 1: Flutter Basics
  // ============================================
  
  WorldModel _world1_FlutterBasics() {
    return const WorldModel(
      id: 'world_1',
      worldNumber: 1,
      title: 'Flutter Basics',
      description: 'Master the fundamentals of Flutter development',
      icon: '🚀',
      theme: 'Fundamentals',
      levelIds: [
        'w1_l1', // Hello Flutter (main & runApp)
        'w1_l2', // StatelessWidget basics
        'w1_l3', // StatefulWidget introduction
        'w1_l4', // Widget tree concept
        'w1_l5', // Hot reload & hot restart
      ],
      requiredStarsToUnlock: 0,
      isLocked: false,
      totalXP: 500,
      estimatedDuration: Duration(minutes: 60),
      nextWorldId: 'world_2',
    );
  }

  // ============================================
  // WORLD 2: Widgets
  // ============================================
  
  WorldModel _world2_Widgets() {
    return const WorldModel(
      id: 'world_2',
      worldNumber: 2,
      title: 'Widgets Mastery',
      description: 'Learn to build beautiful UIs with Flutter widgets',
      icon: '🎨',
      theme: 'UI Development',
      levelIds: [
        'w2_l1', // Container & padding
        'w2_l2', // Row & Column
        'w2_l3', // Text & styling
        'w2_l4', // Image widget
        'w2_l5', // Button widgets
        'w2_l6', // ListView
        'w2_l7', // GridView
        'w2_l8', // Stack & Positioned
      ],
      requiredStarsToUnlock: 10,
      isLocked: true,
      totalXP: 800,
      estimatedDuration: Duration(minutes: 90),
      prerequisites: ['world_1'],
      nextWorldId: 'world_3',
    );
  }

  // ============================================
  // WORLD 3: State Management
  // ============================================
  
  WorldModel _world3_StateManagement() {
    return const WorldModel(
      id: 'world_3',
      worldNumber: 3,
      title: 'State Management',
      description: 'Master state and make your apps interactive',
      icon: '⚡',
      theme: 'Interactivity',
      levelIds: [
        'w3_l1', // setState basics
        'w3_l2', // StatefulWidget lifecycle
        'w3_l3', // Form & TextEditingController
        'w3_l4', // InheritedWidget
        'w3_l5', // Provider basics
        'w3_l6', // ChangeNotifier
      ],
      requiredStarsToUnlock: 20,
      isLocked: true,
      totalXP: 900,
      estimatedDuration: Duration(minutes: 120),
      prerequisites: ['world_1', 'world_2'],
      nextWorldId: 'world_4',
    );
  }

  // ============================================
  // WORLD 4: Navigation
  // ============================================
  
  WorldModel _world4_Navigation() {
    return const WorldModel(
      id: 'world_4',
      worldNumber: 4,
      title: 'Navigation & Routes',
      description: 'Build multi-screen apps with smooth navigation',
      icon: '🧭',
      theme: 'Multi-Screen Apps',
      levelIds: [
        'w4_l1', // Navigator basics
        'w4_l2', // Named routes
        'w4_l3', // Passing data between screens
        'w4_l4', // Bottom navigation
        'w4_l5', // Drawer navigation
        'w4_l6', // Tabs
      ],
      requiredStarsToUnlock: 35,
      isLocked: true,
      totalXP: 750,
      estimatedDuration: Duration(minutes: 100),
      prerequisites: ['world_2', 'world_3'],
      nextWorldId: 'world_5',
    );
  }

  // ============================================
  // WORLD 5: Advanced Topics
  // ============================================
  
  WorldModel _world5_Advanced() {
    return const WorldModel(
      id: 'world_5',
      worldNumber: 5,
      title: 'Advanced Flutter',
      description: 'Level up with advanced techniques and best practices',
      icon: '🏆',
      theme: 'Professional Development',
      levelIds: [
        'w5_l1', // Async & Future
        'w5_l2', // Stream basics
        'w5_l3', // HTTP requests
        'w5_l4', // JSON parsing
        'w5_l5', // Local storage
        'w5_l6', // Animations basics
        'w5_l7', // Custom widgets
        'w5_l8', // Performance optimization
      ],
      requiredStarsToUnlock: 50,
      isLocked: true,
      totalXP: 1200,
      estimatedDuration: Duration(minutes: 150),
      prerequisites: ['world_3', 'world_4'],
    );
  }
}
