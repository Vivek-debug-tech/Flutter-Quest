# 🛠️ Developer Debug Panel - Quick Guide

## 📍 Access

**Hidden Access:** Long-press the **XP Bar** on HomeScreen

<img src="docs/long-press-xp-bar.png" width="300" alt="Long-press XP bar" />

> ⚠️ Only works when `DevConfig.devMode = true`

---

## 🎮 Features

### 1️⃣ Unlock All Levels 🔓
**What it does:**
- Unlocks Worlds 1-10
- Marks Lessons 1-5 as completed
- Full game access instantly

**Use when:**
- Testing late-game content
- Verifying all worlds are working
- Checking level navigation

**Technical:**
```dart
// Unlocks all worlds
for (int i = 1; i <= 10; i++) {
  await progressService.unlockWorld('world_$i');
}

// Completes first 5 lessons
completedLevels = ['w1-l1', 'w1-l2', 'w1-l3', 'w1-l4', 'w1-l5'];
```

---

### 2️⃣ Reset Progress 🔄
**What it does:**
- Clears ALL game data
- Resets to Level 1
- Only World 1 unlocked
- Total XP = 0

**Use when:**
- Testing onboarding flow
- Verifying first-time user experience
- Reproducing beginner bugs

**Technical:**
```dart
await progressService.resetProgress();
// Calls storageService.clearAllData()
// Clears both Hive and SharedPreferences
```

**⚠️ Warning:** Shows confirmation dialog (destructive action)

---

### 3️⃣ Add 500 XP ⚡
**What it does:**
- Adds 500 XP to current total
- May trigger level-up
- Updates title (e.g., "Flutter Beginner" → "Widget Explorer")

**Use when:**
- Testing level-up animations
- Checking XP bar UI at different levels
- Verifying title progression

**Technical:**
```dart
progressService.userProgress.addXP(500);
// Automatically handles level-up calculations
```

**XP Thresholds:**
- Level 1-3: Flutter Beginner
- Level 4-6: Widget Explorer
- Level 7-10: Layout Master
- Level 11-15: State Architect
- Level 16+: Flutter Pro

---

### 4️⃣ Complete Current Lesson ✅
**What it does:**
- Marks next incomplete lesson as done
- Awards 60 XP
- Unlocks next lesson

**Use when:**
- Testing lesson progression
- Verifying unlock logic
- Checking lesson completion UI

**Technical:**
```dart
final nextLessonNumber = completedCount + 1;
final nextLevelId = 'w1-l$nextLessonNumber';
progressService.userProgress.completedLevels.add(nextLevelId);
progressService.userProgress.addXP(60);
```

**Example Flow:**
- Start: 0 lessons completed
- Click once → Lesson 1 complete (+60 XP)
- Click again → Lesson 2 complete (+60 XP)
- Etc...

---

### 5️⃣ Jump to Lesson 5 ⏭️
**What it does:**
- Completes Lessons 1-4
- Awards 240 XP (60 × 4)
- Unlocks Lesson 5

**Use when:**
- Testing mid-game content
- Skipping early lessons
- Verifying lesson 5 specifically

**Technical:**
```dart
const lessons = ['w1-l1', 'w1-l2', 'w1-l3', 'w1-l4'];
for (var levelId in lessons) {
  progressService.userProgress.completedLevels.add(levelId);
}
progressService.userProgress.addXP(240);
```

---

## 🎯 Current Status Display

The panel shows real-time stats:

```
Level: 5
Total XP: 750
Title: Widget Explorer
Unlocked Worlds: 3
Completed Lessons: 8
Streak: 0 days
```

Updates immediately after each action! ⚡

---

## 🔐 Security Gates

### Dev Mode Check (Primary)
```dart
if (!DevConfig.devMode) {
  Navigator.pop(context);
  // Shows error and closes panel
}
```

### Long-Press Access
```dart
GestureDetector(
  onLongPress: () {
    if (DevConfig.devMode) {
      Navigator.push(context, DevPanelScreen());
    } else {
      // Shows "Developer Panel is disabled" message
    }
  }
)
```

**Result:**
- Production builds → Panel hidden (even if user finds long-press)
- Dev builds → Full access

---

## 🧪 Testing Workflows

### Workflow 1: Test Full Game
1. Open app
2. Long-press XP bar → Dev Panel opens
3. Click "Unlock All Levels"
4. ✅ All worlds unlocked, lessons 1-5 done
5. Navigate to any world/lesson
6. Test gameplay

**Time saved:** 15+ minutes → 10 seconds

---

### Workflow 2: Test Onboarding
1. Long-press XP bar → Dev Panel
2. Click "Reset Progress"
3. Confirm dialog
4. ✅ Back to clean slate
5. Go through tutorial/first lesson
6. Verify new user experience

**Use case:** Testing first-time user flow

---

### Workflow 3: Test Level-Up
1. Dev Panel → "Add 500 XP"
2. Observe level-up animation
3. Check title change
4. Repeat multiple times
5. Test UI at high levels

**Use case:** UI testing at various levels

---

### Workflow 4: Test Lesson Progression
1. Dev Panel → "Reset Progress"
2. Complete lesson 1 manually
3. Click "Complete Current Lesson" (completes lesson 2)
4. Verify lesson 3 is now unlocked
5. Test unlock chain

**Use case:** Verifying progression logic

---

### Workflow 5: Jump to Specific Content
1. Dev Panel → "Jump to Lesson 5"
2. ✅ Lessons 1-4 completed instantly
3. Open Lesson 5
4. Test that specific lesson
5. Use "Complete Current Lesson" to continue

**Use case:** Testing specific lesson without replays

---

## 🐛 Troubleshooting

### Panel won't open
**Problem:** Long-press does nothing

**Solutions:**
1. Check `DevConfig.devMode = true`
2. Hot reload app
3. Try longer press (~2 seconds)
4. Check console for "🛠️ Opening Developer Panel"

---

### "Developer Panel disabled" message
**Problem:** Panel closes immediately or shows error

**Cause:** `DevConfig.devMode = false`

**Solution:**
```dart
// lib/config/dev_config.dart
static const bool devMode = true; // ✅ Enable
```

---

### Buttons don't work
**Problem:** Click button → nothing happens

**Check:**
1. Console logs (should show ✅ or ❌ messages)
2. ProgressService is provided (Provider setup)
3. No Hive initialization errors

**Debug:**
```dart
// Check console for:
✅ Unlocked all 10 worlds + completed lessons 1-5
✅ Added 500 XP (Level: X, Total XP: Y)
❌ Error: [error message]
```

---

### Changes don't persist
**Problem:** Close app → progress resets

**Cause:** Hive save issue

**Check:**
```dart
await progressService.userProgress.save();
// Should be called after modifications
```

---

## 📊 Comparison: Debug Panel vs Auto Dev Mode

### Developer Debug Panel (NEW)
✅ Manual control over progress  
✅ Test partial states (e.g., only 500 XP)  
✅ Reset progress to test onboarding  
✅ Granular testing (complete specific lessons)  
✅ Hidden access (long-press)  

**Best for:** Simulating different player states

---

### Auto Dev Mode (EXISTING)
✅ Instant challenge completion  
✅ All levels auto-unlocked  
✅ Skip validation entirely  
✅ Auto-fill code  
✅ Fastest testing  

**Best for:** Rapid content testing

---

### Use Both Together! 🎉

**Example Workflow:**
1. **Debug Panel** → Jump to Lesson 5
2. **Auto Dev Mode** → Complete lesson instantly (auto-fill + skip validation)
3. **Debug Panel** → Add 500 XP to test level-up
4. **Auto Dev Mode** → Test next lessons rapidly

**Result:** Ultimate testing flexibility! ⚡

---

## 🎥 Console Output

### Opening Panel
```
🛠️ Opening Developer Panel (long-press detected)
🛠️ Developer Panel Opened
```

### Unlock All
```
✅ Unlocked all 10 worlds + completed lessons 1-5
```

### Add XP
```
✅ Added 500 XP (Level: 5, Total XP: 750)
```

### Complete Lesson
```
✅ Completed lesson 3 (w1-l3) + 60 XP
```

### Jump to Lesson
```
✅ Jumped to Lesson 5 (completed 1-4) + 240 XP
```

### Reset Progress
```
✅ Progress reset complete
```

---

## ⚠️ Production Deployment

### Before Release:
1. **Set devMode = false**
   ```dart
   // lib/config/dev_config.dart
   static const bool devMode = false;
   ```

2. **Verify panel is inaccessible:**
   - Long-press XP bar → Shows "🔒 Developer Panel is disabled"
   - No way to open panel

3. **Test in release mode:**
   ```bash
   flutter run --release -d chrome
   ```

4. **Confirm:**
   - No dev panel access
   - No console logs (🛠️ messages)
   - Normal game behavior

---

## 📈 Benefits

### ⏱️ Time Savings
- Manual progression: ~20 minutes to reach lesson 5
- Debug panel: ~5 seconds
- **97.5% time saved**

### 🧪 Better Testing
- Test all game states quickly
- Reproduce specific scenarios
- Verify progression logic
- Check UI at all levels

### 🔄 Easy Reset
- Clear progress anytime
- Test onboarding repeatedly
- No database manual edits

### 🎯 Precise Control
- Exact XP amounts
- Specific lesson completion
- Controlled world unlocking
- Targeted testing

---

## 🚀 Quick Reference

| Action | Button | Effect | Time Saved |
|--------|--------|--------|------------|
| Unlock all | 🔓 Unlock All Levels | Worlds 1-10 + Lessons 1-5 | 15+ min |
| Clean slate | 🔄 Reset Progress | Back to Level 1 | Manual DB edit |
| Level up | ⚡ Add 500 XP | Boost XP + level | 5+ lessons |
| Next lesson | ✅ Complete Current | Next lesson done | 2-3 min |
| Jump ahead | ⏭️ Jump to Lesson 5 | Lessons 1-4 done | 10+ min |

---

## 💡 Pro Tips

1. **Quick Reset:** Reset → Unlock All → Full game access in 2 clicks

2. **Test Levels:** Jump to Lesson 5 → Use auto dev mode to test lessons 5-10 rapidly

3. **XP Testing:** Add 500 XP multiple times to reach high levels quickly

4. **Onboarding:** Reset Progress before testing tutorial/new user flow

5. **Combined Power:** Use with auto dev mode for maximum efficiency

6. **Console Logs:** Watch console for detailed operation feedback

---

**Created:** Phase 2 Development  
**Purpose:** Speed up testing & development  
**Access:** Long-press XP Bar (dev mode only)  
**Status:** ✅ Production-ready (gated by DevConfig)
