import 'package:meta/meta.dart';

@immutable
abstract class StorageEvent {}

class StoreEvent extends StorageEvent{}
class LoadEvent extends StorageEvent{}
