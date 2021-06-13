// Author: cxx
// Date: 2021-06-13
// GitHub: https://github.com/ccolorcat

import 'dart:collection';

typedef SizeOf<K, V> = int Function(K, V);

int defaultSizeOf(dynamic key, dynamic value) => 1;

class LruCache<K, V> {
  late LinkedHashMap<K, V> _cache;
  late int _maxSize;
  late SizeOf<K, V> _sizeOf;
  int _size = 0;

  int get size => _size;

  int get maxSize => _maxSize;

  int get length => _cache.length;

  LruCache(int maxSize, {SizeOf<K, V> sizeOf = defaultSizeOf}) {
    if (maxSize <= 0) {
      throw ArgumentError.value(maxSize, 'maxSize', 'maxSize must be positive');
    }
    _sizeOf = sizeOf;
    _maxSize = maxSize;
    _cache = LinkedHashMap();
  }

  /// Reset [maxSize] and trim until the [size] less than [maxSize].
  void resize(int maxSize) {
    if (maxSize <= 0) {
      throw ArgumentError.value(
        maxSize,
        'maxSize',
        'maxSize must be positive',
      );
    }
    _maxSize = maxSize;
    _trimToSize(_maxSize);
  }

  V? operator [](K key) => _get(key);

  void operator []=(K key, V value) => _put(key, value);

  V? remove(K key) => _remove(key);

  /// Returns the value associated with `key` if the value is not null,
  /// or else calls the `produce` function, cache its result and returns it.
  V getOrPut(K key, V produce()) {
    var value = _get(key);
    if (value == null) {
      value = produce();
      _put(key, value!);
    }
    return value;
  }

  /// Removes all entries from the cache.
  void evictAll() {
    _trimToSize(-1);
  }

  /// Returns an unmodifiable snapshot.
  Map<K, V> snapshot() {
    return Map.unmodifiable(_cache);
  }

  V? _get(K key) {
    final value = _cache.remove(key);
    if (value != null) {
      _cache[key] = value;
    }
    return value;
  }

  V _put(K key, V value) {
    var previous = _remove(key);
    _cache[key] = value;
    _size += _safeSizeOf(key, value);
    _trimToSize(_maxSize);
    return previous ?? value;
  }

  V? _remove(K key) {
    var previous = _cache.remove(key);
    if (previous != null) {
      _size -= _safeSizeOf(key, previous);
    }
    return previous;
  }

  void _trimToSize(int maxSize) {
    while (true) {
      _checkSize();
      if (_size <= maxSize || _cache.isEmpty) break;
      final toEvict = _cache.entries.first;
      final key = toEvict.key;
      final value = toEvict.value;
      _cache.remove(key);
      _size -= _safeSizeOf(key, value);
    }
  }

  int _safeSizeOf(K key, V value) {
    final result = _sizeOf(key, value);
    if (result < 0) {
      throw StateError('sizeOf($key, $value) returns a negative value');
    }
    return result;
  }

  void _checkSize() {
    if (_size < 0) {
      throw StateError('size is negative');
    }
    if (_cache.isEmpty && _size != 0) {
      throw StateError('cache is empty, but size not equal to 0');
    }
  }

  @override
  String toString() {
    return 'LruCache{cache: $_cache, maxSize: $_maxSize, size: $_size}';
  }
}
