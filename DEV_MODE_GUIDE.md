# Developer Mode - Quick Reference

## 🚀 Overview

Developer Mode speeds up testing by bypassing validation and unlocking all levels.

---

## 📁 Configuration File

**Location:** `lib/config/dev_config.dart`

```dart
class DevConfig {
  static const bool devMode = true;        // Enable/disable dev mode
  static const bool verboseLogging = true; // Extra debug info
  static const bool autoComplete = true;   // Auto-fill and skip validation
}
```

---

## ⚙️ Features

### 1. **All Levels Unlocked** 🔓
- Every level is clickable regardless of progress
- Test any lesson/challenge instantly
- No need to complete previous levels

**Implementation:** [level_card.dart](lib/widgets/level_card.dart)
```dart
final isUnlocked = DevConfig.devMode ? true : levelUnlocked;
```

### 2. **Skip Validation** ⏭️
- Click Submit → Instant success
- Go straight to Result Screen
- Award full XP (no mistakes, no hints)

**Implementation:** [challenge_screen_enhanced.dart](lib/screens/challenge_screen_enhanced.dart)
```dart
if (DevConfig.devMode && DevConfig.autoComplete) {
  // Skip to results immediately
}
```

### 3. **Auto-Fill Code** 📝
- Challenge screen loads with correct answer pre-filled
- No typing required
- Just click Submit to complete

**Implementation:** [challenge_screen_enhanced.dart](lib/screens/challenge_screen_enhanced.dart)
```dart
_codeController.text = widget.level.expectedCode;
```

### 4. **Console Warnings** ⚠️
- App startup shows dev mode banner
- Challenge screen shows dev mode active
- Clear visual indication when testing

**Output:**
```
==================================================
⚠️  DEV MODE ENABLED
==================================================
🔓 All levels unlocked
⏭️  Validation skipped
📝 Auto-fill code enabled
💡 Fast testing mode active
==================================================
```

---

## 🎯 Usage

### **Enable Developer Mode** (Current Setting)
```dart
// lib/config/dev_config.dart
static const bool devMode = true;  // ✅ ENABLED
```

### **Disable for Production**
```dart
// lib/config/dev_config.dart
static const bool devMode = false; // ❌ DISABLED
```

---

## 🧪 Testing Workflow

### Fast Testing Mode (devMode = true)
1. Run app
2. Click any level (all unlocked)
3. Challenge screen auto-fills code
4. Click Submit
5. Instantly see Result Screen
6. Repeat for next level

**Time per level:** ~5 seconds ⚡

### Normal Testing Mode (devMode = false)
1. Run app
2. Complete Level 1 to unlock Level 2
3. Type code manually
4. Submit and validate
5. View results
6. Go back and repeat

**Time per level:** ~2-3 minutes 🐌

---

## 🛠️ Modified Files

1. **`lib/config/dev_config.dart`** (NEW)
   - Configuration constants

2. **`lib/main.dart`**
   - Added dev mode warning at startup
   - Import DevConfig

3. **`lib/screens/challenge_screen_enhanced.dart`**
   - Skip validation in dev mode
   - Auto-fill expected code
   - Show dev mode indicators

4. **`lib/widgets/level_card.dart`**
   - Unlock all levels in dev mode
   - Import DevConfig

---

## 🔄 Quick Toggle

### Turn Dev Mode ON
```dart
// lib/config/dev_config.dart
static const bool devMode = true;
```
Save → Hot Reload → All levels unlocked!

### Turn Dev Mode OFF
```dart
// lib/config/dev_config.dart
static const bool devMode = false;
```
Save → Hot Reload → Normal behavior restored

---

## ⚠️ Important Notes

### Before Production Release:
1. ✅ Set `devMode = false`
2. ✅ Test with normal validation
3. ✅ Verify level locking works
4. ✅ Check all challenges validate correctly

### During Development:
- ✅ Use `devMode = true` for fast iteration
- ✅ Test all lessons quickly
- ✅ Verify navigation flows
- ✅ Check UI layouts

---

## 🐛 Troubleshooting

### Issue: Dev mode not working
**Solution:** Make sure you've hot reloaded or restarted the app after changing `devMode`

### Issue: Levels still locked
**Check:**
```dart
// In level_card.dart
final isUnlocked = DevConfig.devMode ? true : levelUnlocked;
```

### Issue: Validation still running
**Check:**
```dart
// In challenge_screen_enhanced.dart
if (DevConfig.devMode && DevConfig.autoComplete) {
  // This should skip validation
}
```

### Issue: Code not auto-filling
**Check:**
```dart
// In initState of challenge_screen_enhanced.dart
if (DevConfig.devMode && DevConfig.autoComplete) {
  _codeController.text = widget.level.expectedCode;
}
```

---

## 📊 Console Output Examples

### App Startup (Dev Mode ON)
```
==================================================
⚠️  DEV MODE ENABLED
==================================================
🔓 All levels unlocked
⏭️  Validation skipped
📝 Auto-fill code enabled
💡 Fast testing mode active
==================================================
```

### Challenge Screen Load
```
========================================
ACTIVE SCREEN: challenge_screen_enhanced.dart
========================================

⚠️  DEV MODE ENABLED - All levels unlocked, validation skipped
🛠️ DEV MODE: Auto-filled with expected code
```

### Submitting Answer
```
==================== SUBMIT ANSWER ====================
🛠️ DEV MODE: Skipping validation
```

---

## ✨ Benefits

✅ **10x Faster Testing**
- Skip manual typing
- Instant validation bypass
- Jump to any level

✅ **Better Iteration**
- Test UI changes quickly
- Verify navigation flows
- Check all screens rapidly

✅ **Easy Toggle**
- One line to enable/disable
- No code changes needed
- Hot reload compatible

✅ **Clear Indicators**
- Console warnings visible
- Know when dev mode is on
- Prevent accidental production use

---

## 🎓 Example Session

```bash
# Start app with dev mode
$ flutter run -d chrome

# Console shows:
⚠️  DEV MODE ENABLED
🔓 All levels unlocked

# Navigate to any level
# → All levels are clickable

# Open challenge
# → Code is pre-filled

# Click Submit
# → Instant Result Screen

# Repeat for all levels
# → Complete testing in minutes!
```

---

**Remember:** Always set `devMode = false` before production! 🚨
