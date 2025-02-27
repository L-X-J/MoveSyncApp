part of 'utils.dart';

extension ListExtension<E> on List<E> {
  E? get firstOrNull => isEmpty ? null : this[0];

  E? get lastOrNull => isEmpty ? null : this[length - 1];

  int? firstIndexWhereOrNull(bool Function(E e) where) {
    for (int i = 0; i < length; i++) {
      if (where.call(this[i])) {
        return i;
      }
    }
    return null;
  }
}
