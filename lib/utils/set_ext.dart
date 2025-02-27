part of 'utils.dart';
extension SetExtension<E> on Set<E> {


  /// 深copy
  Set<E> deepCopy(){
    final newSet = Set.of(this);
    forEach(newSet.add);
    return newSet;
  }
}