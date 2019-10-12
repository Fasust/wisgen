///Generic Repository for read/write Storage device
abstract class Storage<T>{
  Future<T> load();
  save(T data);

  ///Wipe the Storage Medium
  wipeStorage();
}