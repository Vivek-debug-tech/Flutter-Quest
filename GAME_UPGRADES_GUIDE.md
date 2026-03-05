# FlutterQuest Game System Upgrades

## 🎮 Overview

FlutterQuest has been upgraded from a simple quiz app to an interactive learning game with advanced features similar to Duolingo.

---

## ✨ NEW FEATURES

### 1. Enhanced Challenge Types ✅

**Updated Enum:** `ChallengeType`

```dart
enum ChallengeType {
  multipleChoice,  // Select correct option
  fillInBlank,     // Type missing word
  fixTheBug,       // Fix incorrect code (previously fixCode)
  buildWidget,     // Build a widget (existing)
  arrangeCode,     // ⭐ NEW: Arrange code pieces in order
}
```

**Location:** `lib/models/challenge_models.dart`

---

### 2. Explanation System ✅

Every challenge now includes explanations shown after answering:

```dart
ChallengeStep(
  question: 'What launches a Flutter app?',
  explanation: 'runApp() launches your widget tree and displays it on screen.',
)
```

**Features:**
- ✅ Shows feedback for correct answers
- ✅ Explains why wrong answers are incorrect
- ✅ Helps players learn from mistakes

---

### 3. Hint System ✅

Progressive hints that guide players:

```dart
hints: [
  'This function launches widgets.',       // Gentle
  'It is called inside main().',          // More specific
  'The answer is: runApp',                // Clear answer
]
```

**XP Penalty:** Each hint reduces XP by 3 points

---

### 4. XP Reward Engine ✅

**New Service:** `XPCalculator`

**Location:** `lib/services/xp_calculator.dart`

**Formula:**
```
finalXP = baseXP - (mistakes × 5) - (hintsUsed × 3) + bonuses
Minimum XP = 10
```

**Example:**
```dart
final xp = XPCalculator.calculateXP(
  baseXP: 50,
  mistakes: 2,      // -10 XP
  hintsUsed: 1,     // -3 XP
);
// Result: 37 XP
```

**Bonuses:**
- 🌟 Perfect completion (no mistakes, no hints): +20 XP
- ⚡ Speed bonus (faster than expected): +5 to +15 XP
- 🔥 Streak bonus: +10 to +50 XP

---

### 5. Player Progress Model ✅

**New Model:** `PlayerProgress`

**Location:** `lib/models/player_progress.dart`

**Fields:**
```dart
PlayerProgress(
  currentXP: 150,
  currentLevelId: 'w1_l3',
  completedLevels: ['w1_l1', 'w1_l2'],
  levelStars: {'w1_l1': 3, 'w1_l2': 2},
  starsEarned: 5,
  dailyStreak: 7,
  totalMistakes: 12,
  totalHintsUsed: 8,
  lastPlayedDate: DateTime.now(),
  levelStatistics: {...},
)
```

**Calculated Properties:**
- `playerLevel` - Level based on XP (100 XP per level)
- `xpForNextLevel` - XP needed for next level
- `levelProgress` - Progress percentage (0-100)

---

### 6. Hive Progress Service ✅

**New Service:** `HiveProgressService`

**Location:** `lib/services/hive_progress_service.dart`

**Setup in main.dart:**
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await HiveProgressService.initialize();
  runApp(MyApp());
}
```

**Functions:**

| Function | Purpose |
|----------|---------|
| `loadProgress()` | Load saved progress |
| `saveProgress()` | Save progress to disk |
| `addXP(xp)` | Add XP to player |
| `markLevelCompleted()` | Save level completion |
| `setCurrentLevel()` | Update current level |
| `getLevelStats()` | Get stats for a level |
| `resetProgress()` | Reset all progress |

**Example Usage:**
```dart
// Load progress
final progress = await HiveProgressService.loadProgress();
print('Current XP: ${progress.currentXP}');

// Complete a level
await HiveProgressService.markLevelCompleted(
  levelId: 'w1_l1',
  stars: 3,
  xpEarned: 50,
  mistakes: 0,
  hintsUsed: 0,
);
```

---

### 7. Star System ✅

**Stars Calculation:**

| Stars | Criteria |
|-------|----------|
| ⭐⭐⭐ 3 Stars | Perfect (0 mistakes, no hints) |
| ⭐⭐ 2 Stars | Good (1-2 mistakes OR 1-2 hints) |
| ⭐ 1 Star | Completed (any mistakes/hints) |

**Implemented in:** `XPCalculator.calculateStars()`

```dart
final stars = XPCalculator.calculateStars(
  mistakes: 0,
  hintsUsed: 0,
);
// Result: 3 stars ⭐⭐⭐
```

---

### 8. Arrange Code Challenge (NEW) ✅

**Type:** `ChallengeType.arrangeCode`

Players drag code pieces into correct order:

```dart
ChallengeStep(
  type: ChallengeType.arrangeCode,
  question: 'Arrange these code pieces:',
  codePieces: [
    'runApp(MyApp());',
    'void main() {',
    '}',
  ],
  correctOrder: [
    'void main() {',
    '  runApp(MyApp());',
    '}',
  ],
)
```

**Updated:** `ChallengeStep` model now includes:
- `codePieces` - List of code lines to arrange
- `correctOrder` - Expected correct sequence

---

## 📁 FILE STRUCTURE

```
lib/
├── models/
│   ├── challenge_models.dart        ⭐ UPDATED: Added arrangeCode
│   ├── player_progress.dart         ⭐ NEW
│   └── level_model_v2.dart         (Existing)
│
├── services/
│   ├── xp_calculator.dart          ⭐ NEW
│   ├── hive_progress_service.dart  ⭐ NEW
│   ├── game_data_service.dart      (Existing)
│   └── progress_service.dart       (Existing - old version)
│
└── examples/
    └── upgraded_challenges_example.dart  ⭐ NEW
```

---

## 🎯 USAGE EXAMPLES

### Example 1: Creating a Challenge with All Features

```dart
ChallengeStep(
  id: 'w1_l1_step1',
  stepNumber: 1,
  type: ChallengeType.multipleChoice,
  question: 'What launches a Flutter app?',
  options: [
    OptionModel(text: 'runApp()', isCorrect: true),
    OptionModel(text: 'main()', isCorrect: false),
  ],
  xpReward: 20,
  hints: [
    'This function launches widgets',
    'It\'s called inside main()',
    'The answer is runApp',
  ],
  explanation: 'runApp() launches your widget tree!',
)
```

### Example 2: Calculating XP After Level Completion

```dart
// User completed level with 2 mistakes and used 1 hint
final xpBreakdown = XPCalculator.getXPBreakdown(
  baseXP: 50,
  mistakes: 2,
  hintsUsed: 1,
);

print('Base XP: ${xpBreakdown.baseXP}');          // 50
print('Mistakes: ${xpBreakdown.mistakePenalty}'); // -10
print('Hints: ${xpBreakdown.hintPenalty}');       // -3
print('Final XP: ${xpBreakdown.finalXP}');        // 37
```

### Example 3: Saving Progress After Level

```dart
void onLevelComplete() async {
  // Calculate stars
  final stars = XPCalculator.calculateStars(
    mistakes: _mistakes,
    hintsUsed: _hintsUsed,
  );

  // Calculate XP
  final xp = XPCalculator.calculateXP(
    baseXP: level.baseXP,
    mistakes: _mistakes,
    hintsUsed: _hintsUsed,
  );

  // Save to Hive
  final progress = await HiveProgressService.markLevelCompleted(
    levelId: level.id,
    stars: stars,
    xpEarned: xp,
    mistakes: _mistakes,
    hintsUsed: _hintsUsed,
  );

  // Show results
  showResultScreen(
    stars: stars,
    xp: xp,
    message: XPCalculator.getPerformanceMessage(stars),
  );
}
```

---

## 🚀 INTEGRATION STEPS

### 1. Add Hive Dependency

Add to `pubspec.yaml`:
```yaml
dependencies:
  hive: ^2.2.3
  hive_flutter: ^1.1.0
```

Run: `flutter pub get`

### 2. Initialize in main.dart

```dart
import 'package:hive_flutter/hive_flutter.dart';
import 'services/hive_progress_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await HiveProgressService.initialize();
  runApp(MyApp());
}
```

### 3. Update Challenge Screen

Add hint and mistake tracking:

```dart
class _ChallengeScreenState extends State<ChallengeScreen> {
  int _hintsUsed = 0;
  int _mistakes = 0;
  
  void _showHint() {
    if (_currentHintIndex < hints.length) {
      setState(() {
        _hintsUsed++;
        _currentHintIndex++;
      });
      // Show hint dialog
    }
  }
  
  void _checkAnswer(String answer) {
    if (answer != correctAnswer) {
      setState(() {
        _mistakes++;
      });
      // Show incorrect feedback
    }
  }
}
```

### 4. Show XP Breakdown

```dart
void _showResults() {
  final breakdown = XPCalculator.getXPBreakdown(
    baseXP: level.baseXP,
    mistakes: _mistakes,
    hintsUsed: _hintsUsed,
  );

  showDialog(
    context: context,
    builder: (context) => XPBreakdownDialog(breakdown: breakdown),
  );
}
```

---

## 📊 PERFORMANCE METRICS

### Before Upgrade
- ❌ Only multiple choice questions
- ❌ No hints
- ❌ No XP penalties
- ❌ No progress tracking

### After Upgrade
- ✅ 5 challenge types (including arrangeCode)
- ✅ Progressive hint system (3 hints per challenge)
- ✅ XP calculation with penalties and bonuses
- ✅ Star rating system (1-3 stars)
- ✅ Persistent progress with Hive
- ✅ Daily streak tracking
- ✅ Detailed level statistics

---

## 🎨 UI RECOMMENDATIONS

### Hint Button
```dart
ElevatedButton.icon(
  onPressed: _hintsUsed < hints.length ? _showHint : null,
  icon: Icon(Icons.lightbulb),
  label: Text('Hint ($_hintsUsed/${hints.length})'),
)
```

### XP Animation
```dart
AnimatedXPBar(
  from: oldXP,
  to: newXP,
  duration: Duration(seconds: 2),
)
```

### Star Display
```dart
Row(
  children: List.generate(3, (i) =>
    Icon(
      i < stars ? Icons.star : Icons.star_border,
      color: Colors.amber,
    ),
  ),
)
```

---

## 📦 PACKAGE REQUIREMENTS

**Required:**
- `hive: ^2.2.3`
- `hive_flutter: ^1.1.0`

**Optional (for syntax highlighting):**
- `flutter_highlight: ^0.7.0`

---

## ✅ TESTING CHECKLIST

- [ ] Hive initializes properly
- [ ] Progress saves and loads correctly
- [ ] XP calculation matches formula
- [ ] Star calculation works (1-3 stars)
- [ ] Hints reduce XP by 3 each
- [ ] Mistakes reduce XP by 5 each
- [ ] Minimum XP is never below 10
- [ ] Daily streak updates correctly
- [ ] arrangeCode challenges work in UI

---

## 🎉 SUMMARY

**Files Created:**
1. ✅ `models/player_progress.dart`
2. ✅ `services/xp_calculator.dart`
3. ✅ `services/hive_progress_service.dart`
4. ✅ `examples/upgraded_challenges_example.dart`

**Files Updated:**
1. ✅ `models/challenge_models.dart` (added arrangeCode)

**Features Delivered:**
- ✅ 5 challenge types (including new arrangeCode)
- ✅ Hint system with progressive guidance
- ✅ Explanation system for learning from mistakes
- ✅ XP calculation engine with penalties/bonuses
- ✅ Star rating system (1-3 stars)
- ✅ Player progress tracking with Hive
- ✅ Daily streak system
- ✅ Level statistics
- ✅ Example challenges demonstrating all features

**Ready to play! 🚀**
