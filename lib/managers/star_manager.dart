class StarManager {
  static int calculateStars(int hintsUsed) {
    if (hintsUsed <= 0) {
      return 3;
    }

    if (hintsUsed == 1) {
      return 2;
    }

    return 1;
  }
}
