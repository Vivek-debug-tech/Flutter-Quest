# 🚀 FlutterQuest - Quick Start Guide

## Installation & Setup

### Step 1: Install Dependencies
```bash
cd "c:\Users\VIVEK\OneDrive\Desktop\FLUTTER GAME\flutter_game"
flutter pub get
```

### Step 2: Generate Hive Adapters
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Step 3: Run the App

**Option A: Chrome (Recommended for testing)**
```bash
flutter run -d chrome
```

**Option B: Android Emulator**
```bash
flutter run -d android
```

**Option C: Windows (Requires Visual Studio)**
```bash
flutter run -d windows
```

## 🎮 How to Use the App

### Home Screen
- View your XP progress bar at the top
- See your current level and title
- Track your daily streak (🔥)
- Browse available worlds
- Tap "Achievements" to see your badges

### World Selection
- **World 1 (🚀)** - Flutter Basics - Always unlocked
- **World 2 (📐)** - Layout Mastery - Requires 2 stars from World 1
- **World 3 (🎨)** - UI & Styling - Requires 2 stars from World 2

### Level Screen  
- See all levels in the selected world
- Levels unlock sequentially
- View difficulty and XP rewards
- Track your stars on completed levels

### Challenge Screen
- Read the learning objective
- Understand the challenge description
- Choose your answer (multiple choice) or write code
- Use hints if needed (costs XP)
- Submit your answer

### Result Screen
- See your earned XP and stars
- Review what you learned
- See the correct solution
- Check your performance stats

## 📊 Progression System

### XP Earning
- **Base XP**: 50-75 depending on challenge type
- **Accuracy Bonus**: +10 XP (no mistakes)
- **Hint Penalty**: -5 XP per hint
- **Daily Login**: +10 XP
- **Streak Bonus**: Up to +50 XP for 7+ day streaks

### Star Rating
- ⭐⭐⭐ **3 Stars**: Perfect! (No hints, no mistakes)
- ⭐⭐ **2 Stars**: Good! (1-2 mistakes or 1 hint)
- ⭐ **1 Star**: Completed! (Multiple mistakes/hints)

### Level Progression
- Complete levels to earn XP
- Gain enough XP to level up
- Unlock new titles as you progress:
  - Level 1-3: Flutter Beginner 🌱
  - Level 4-6: Widget Explorer 🔍
  - Level 7-10: Layout Master 📐
  - Level 11-15: State Architect 🏗️
  - Level 16+: Flutter Pro 🚀

### World Unlocking
- World 1: Always unlocked
- World 2: Average 2 stars in World 1
- World 3: Average 2 stars in World 2

## 🏆 Achievements

### Available Badges
- **Scaffold Starter** 🏗️ - Complete all World 1 levels
- **Layout Ninja** 🥷 - Get 3 stars in all Layout levels
- **Bug Fixer** 🐛 - Fix 10 broken UIs
- **No Hint Hero** 🦸 - Complete 5 levels without hints
- **Streak Master** 🔥 - Maintain 7-day login streak
- **UI Artist** 🎨 - Complete all UI & Styling levels
- **Perfectionist** ⭐ - Get 3 stars on 10 levels

## 💡 Tips for Success

1. **Read Carefully**: Always read the learning objective first
2. **Use Hints Wisely**: They reduce XP, so try on your own first
3. **Daily Practice**: Login daily to build your streak
4. **Aim for 3 Stars**: Perfect completion gives maximum XP
5. **Review Explanations**: Always read what you learned
6. **Progress Steadily**: Don't rush - understanding is key

## 🔧 Troubleshooting

### App won't start on Windows
- Install Visual Studio with C++ development tools
- Or use Chrome: `flutter run -d chrome`

### Hive errors
- Run: `flutter pub run build_runner build --delete-conflicting-outputs`

### UI looks broken
- Restart the app
- Check your Flutter version: `flutter --version`

### Progress not saving
- Check Hive initialization completed
- Look for errors in console

## 📱 File Structure

```
lib/
├── main.dart                    # Entry point
├── screens/                     # All screens
│   ├── home_screen.dart
│   ├── level_screen.dart
│   ├── challenge_screen.dart
│   └── result_screen.dart
├── models/                      # Data models
├── services/                    # Business logic
├── widgets/                     # Reusable UI
└── data/                        # Game content
```

## 🎯 Learning Path

### Beginner Path (World 1)
1. Hello Flutter - Learn about main.dart
2. Scaffold Basics - Create basic screens
3. StatelessWidget - Build custom widgets
4. AppBar Styling - Customize app bars
5. Center Widget - Understand alignment

### Intermediate Path (World 2)
1. Column Basics - Vertical layouts
2. Row Basics - Horizontal layouts
3. MainAxisAlignment - Control spacing
4. Expanded Widget - Flexible layouts
5. Padding Widget - Add spacing

### Advanced Path (World 3)
1. Container Basics - Styling and layout
2. BoxDecoration - Advanced styling
3. BorderRadius - Rounded corners
4. Text Styling - Beautiful typography
5. FloatingActionButton - Action buttons

## 🎓 Next Steps

After completing all 3 worlds:
1. Review concepts that were challenging
2. Replay levels to get 3 stars on all
3. Unlock all achievements
4. Build your own Flutter apps!

## 📞 Support

For issues or questions:
- Check the README.md for detailed documentation
- Review the code comments for explanations
- Experiment with the code to learn more

---

**Happy Learning! 🚀**

*Remember: The goal is not just to complete levels, but to understand Flutter deeply!*
