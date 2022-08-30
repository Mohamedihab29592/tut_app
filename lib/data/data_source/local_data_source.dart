import '../network/error_handler.dart';
import '../response/responses.dart';

const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CACHE_HOME_INTERVAL = 60 * 1000; // 1 minute cache in millis
const CACHE_STORE_DETAILS_KEY = "CACHE_STORE_DETAILS_KEY";
const CACHE_STORE_DETAILS_INTERVAL = 60 * 1000;

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();
  Future<StoreDetailsResponse> getStoreData();

  Future<void> saveHomeToCache(HomeResponse homeResponse);
  Future<void> saveStoreToCache(StoreDetailsResponse storeResponse);

  void clearCache();

  void removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  // run time cache
  Map<String, CachedItem> cacheMap = Map();

  @override
  Future<HomeResponse> getHomeData() async{
    CachedItem? cachedItem = cacheMap[CACHE_HOME_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)) {
      // return the response from cache
      return cachedItem.data;
    } else {
      // return an error that cache is not there or its not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CachedItem(homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);  }

  @override
  Future<StoreDetailsResponse> getStoreData()async  {
    CachedItem? cachedItem = cacheMap[CACHE_STORE_DETAILS_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_STORE_DETAILS_INTERVAL)) {
      // return the response from cache
      return cachedItem.data;
    } else {
      // return an error that cache is not there or its not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveStoreToCache(StoreDetailsResponse storeResponse) async {
    cacheMap[CACHE_STORE_DETAILS_KEY] = CachedItem(storeResponse);
  }
}

class CachedItem {
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTimeInMillis) {
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;

    bool isValid = currentTimeInMillis - cacheTime <= expirationTimeInMillis;
    // expirationTimeInMillis -> 60 sec
    // currentTimeInMillis -> 1:00:00
    // cacheTime -> 12:59:30
    // valid -> till 1:00:30
    return isValid;
  }
}