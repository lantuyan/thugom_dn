class DataManager {
 // Singleton object
 static final DataManager _singleton = DataManager._internal();

 // Internal constructor
 DataManager._internal();

 // Factory constructor
 factory DataManager() {
  return _singleton;
 }

 Map<String, String> dataUser = {}; 

 void saveData(String key, String value) {
  dataUser[key] = value; 
 }

 // Get method
 String getData(String key) {
  return dataUser[key] ?? '';
 }
}
