// Developer Configuration
// Controls developer mode features for testing
// When devMode is true:
// - All levels are unlocked
// - Validation is skipped
// - Starter code is auto-filled
// - Instant navigation to results
// ⚠️ SET TO FALSE BEFORE PRODUCTION RELEASE!

class DevConfig {
  /// Enable developer mode for testing
  /// 
  /// Set to true during development for fast testing
  /// Set to false for production builds
  static const bool devMode = true;
  
  /// Print debug information
  static const bool verboseLogging = true;
  
  /// Auto-complete challenges instantly
  /// 
  /// ⚠️ IMPORTANT: Set to FALSE to test error detection and smart hints!
  /// When true: Skips validation entirely
  /// When false: Runs normal validation (error detection works)
  static const bool autoComplete = false;  // Changed to false to test upgrades 3 & 4
}
