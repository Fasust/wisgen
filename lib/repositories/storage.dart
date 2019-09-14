///Interface for a Generic List Provider
abstract class Storage<T>{
  Future<List<T>> load();
  save(List<T> data);

  ///Wipe the Storage Medium
  wipeStorage();
}