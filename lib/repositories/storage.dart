abstract class Storage<T>{
  Future<List<T>> load();
  save(List<T> data);
  wipeStorage();
}