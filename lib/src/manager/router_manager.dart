class RouterManager {
  String _currentPage = '\\';

  String getCurrentPage() {
    return _currentPage;
  }

  void setCurrentPage(String page) {
    _currentPage = page;
  }

}
