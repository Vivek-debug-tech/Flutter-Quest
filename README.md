# 🎮 FlutterQuest - Learn Flutter by Building

**A gamified mobile learning application that teaches Flutter through interactive challenges.**

## 📱 Project Overview

FlutterQuest is an interactive learning platform designed to help Flutter beginners master the framework through a structured, game-based approach. The app features a world-based progression system with XP, stars, achievements, and daily streaks to keep learners engaged and motivated.

## ✨ Features

### 🌍 World-Based Learning System
- **World 1 - Flutter Basics**: Project structure, main.dart, StatelessWidget, Scaffold, AppBar
- **World 2 - Layout Mastery**: Row, Column, Expanded, Padding, Center, Stack
- **World 3 - UI & Styling**: Colors, BoxDecoration, BorderRadius, Icons, Text styling

### 🎯 Gamification Elements
- **XP System**: Earn experience points for completing challenges
- **Star Rating**: 1-3 stars based on performance
- **User Levels**: Progress from "Flutter Beginner" to "Flutter Pro"
- **Daily Streaks**: Bonus XP for consecutive daily logins
- **Badges & Achievements**: Unlock special rewards for milestones

### 🎓 Challenge Types
1. **Multiple Choice**: Test conceptual knowledge
2. **Fix Broken UI**: Debug and repair Flutter code
3. **Build From Scratch**: Create widgets from requirements
4. **Drag & Drop**: (Coming soon)

## 🚀 Getting Started

### Installation

1. **Install dependencies**
   ```bash
   flutter pub get
   ```

2. **Generate Hive adapters**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. **Run the app**
   ```bash
   flutter run -d chrome  # Web
   flutter run -d android # Android
   ```

## 📊 XP & Leveling System

- **Accuracy Bonus**: +10 XP (no mistakes)
- **Hint Penalty**: -5 XP per hint
- **Level Formula**: XP Required = 100 × (Level ^ 1.2)

## 🏆 Achievements

- Scaffold Starter, Layout Ninja, Bug Fixer, No Hint Hero, and more!

## 🎯 Learning Path

1. Complete World 1 (Flutter Basics)
2. Progress to World 2 (Layout Mastery)
3. Advance to World 3 (UI & Styling)
4. Aim for 3 stars on all levels

---

**Happy Learning! 🚀** *Master Flutter one challenge at a time.*
