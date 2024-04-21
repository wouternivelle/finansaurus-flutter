class CacheClient {
  CacheClient._internal();

  factory CacheClient() {
    return _instance;
  }

  static final CacheClient _instance = new CacheClient._internal();

  final Map<String, Object> _cache = <String, Object>{};

  void write<T extends Object>({required String key, required T value}) {
    _cache[key] = value;
  }

  T? read<T extends Object>({required String key}) {
    final value = _cache[key];
    if (value is T) return value;
    return null;
  }
}
