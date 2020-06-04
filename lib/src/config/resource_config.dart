

import '../interface/i_resource_config.dart';

class ResourceConfig extends IResourceConfig {
  Map _localRes = Map();
  String _currentLanguageCode = "";
  String _defaultLanguageCode = "";

  @override
  Map getLocalRes() => _localRes;

  @override
  IResourceConfig setLocalRes(Map localRes) {
    _localRes = localRes;
    return this;
  }

  @override
  IResourceConfig setCurrentLanguageCode(String languageCode) {
    _currentLanguageCode = languageCode;
    return this;
  }

  @override
  IResourceConfig setDefaultLanguageCode(String languageCode) {
    _defaultLanguageCode = languageCode;
    return this;
  }

  @override
  String getCurrentLanguageCode() => _currentLanguageCode;

  @override
  String getDefaultLanguageCode() => _defaultLanguageCode;

}
