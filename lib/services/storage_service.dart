import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_progress_model.dart';

class StorageService {
  static const String progressBoxName = 'userProgressBox';
  static const String userProgressKey = 'userProgress';
  
  // Hive box for structured data
  late Box<UserProgress> _progressBox;
  
  // SharedPreferences for quick access
  late SharedPreferences _prefs;

  // Initialize storage
  Future<void> init() async {
    // Initialize Hive
    await Hive.initFlutter();
    
    // Register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserProgressAdapter());
    }
    
    // Open boxes
    _progressBox = await Hive.openBox<UserProgress>(progressBoxName);
    
    // Initialize SharedPreferences
    _prefs = await SharedPreferences.getInstance();
    
    // Create default progress if none exists
    if (_progressBox.isEmpty) {
      final defaultProgress = UserProgress();
      await _progressBox.put(userProgressKey, defaultProgress);
    }
  }

  // Get user progress
  UserProgress getUserProgress() {
    return _progressBox.get(userProgressKey) ?? UserProgress();
  }

  // Save user progress
  Future<void> saveUserProgress(UserProgress progress) async {
    await _progressBox.put(userProgressKey, progress);
  }

  // Quick access methods using SharedPreferences
  Future<void> setLastCompletedLevel(String levelId) async {
    await _prefs.setString('lastCompletedLevel', levelId);
  }

  String? getLastCompletedLevel() {
    return _prefs.getString('lastCompletedLevel');
  }

  Future<void> setTotalXP(int xp) async {
    await _prefs.setInt('totalXP', xp);
  }

  int getTotalXP() {
    return _prefs.getInt('totalXP') ?? 0;
  }

  // Save level progress
  Future<void> saveLevelProgress(String levelId, Map<String, dynamic> progressData) async {
    final userProgress = getUserProgress();
    userProgress.levelProgressMap[levelId] = progressData;
    await saveUserProgress(userProgress);
  }

  // Get level progress
  Map<String, dynamic>? getLevelProgress(String levelId) {
    final userProgress = getUserProgress();
    final progressData = userProgress.levelProgressMap[levelId];
    if (progressData == null) return null;
    return Map<String, dynamic>.from(progressData as Map);
  }

  // Check if level is completed
  bool isLevelCompleted(String levelId) {
    final userProgress = getUserProgress();
    return userProgress.completedLevels.contains(levelId);
  }

  // Check if world is unlocked
  bool isWorldUnlocked(String worldId) {
    final userProgress = getUserProgress();
    return userProgress.unlockedWorlds.contains(worldId);
  }

  // Clear all data (for testing/reset)
  Future<void> clearAllData() async {
    await _progressBox.clear();
    await _prefs.clear();
    
    // Recreate default progress
    final defaultProgress = UserProgress();
    await _progressBox.put(userProgressKey, defaultProgress);
  }

  // Close storage
  Future<void> close() async {
    await _progressBox.close();
  }
}
