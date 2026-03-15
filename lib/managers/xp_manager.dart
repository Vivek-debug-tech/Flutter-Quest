class XPManager {
  static const int baseXP = 60;
  static const int minimumXP = 10;

  /// XP rules:
  /// Base XP = 60
  /// hint1 → -10
  /// hint2 → -20
  /// hint3 → -20
  /// Minimum XP = 10
  static int calculateXP(int hintsUsed) {
    int xp = baseXP;
    if (hintsUsed == 1) {
      xp -= 10;
    } else if (hintsUsed == 2) {
      xp -= 10 + 20;
    } else if (hintsUsed >= 3) {
      xp -= 10 + 20 + 20;
    }
    return xp < minimumXP ? minimumXP : xp;
  }
}
