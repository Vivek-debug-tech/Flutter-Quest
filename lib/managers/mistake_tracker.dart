import '../models/mistake_record.dart';
import '../services/storage_service.dart';

class MistakeTracker {
  final StorageService _storageService;

  MistakeTracker(this._storageService);

  Future<void> recordMistake(String errorType) async {
    final counts = _storageService.getMistakeCounts();
    counts.update(errorType, (count) => count + 1, ifAbsent: () => 1);
    await _storageService.setMistakeCounts(counts);
  }

  List<MistakeRecord> getMostCommonMistakes() {
    final records = _storageService
        .getMistakeCounts()
        .entries
        .map(
          (entry) => MistakeRecord(
            errorType: entry.key,
            count: entry.value,
          ),
        )
        .toList();

    records.sort((a, b) => b.count.compareTo(a.count));
    return records;
  }

  int getMistakeCount(String errorType) {
    return _storageService.getMistakeCounts()[errorType] ?? 0;
  }
}
