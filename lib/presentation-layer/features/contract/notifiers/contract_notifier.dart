import 'package:emekteb/core/base/notifier/base_change_notifier.dart';

class ContractNotifier extends BaseChangeNotifier {
  List<Map<String, String>> contractItems = [];
  List<Map<String, String>> customerItems = [];
  List<Map<String, String>> studentItems = [];
  bool isMainDataLoading = true;
  int activeIndex = 0;

  reset() {
    contractItems = [];
    customerItems = [];
    studentItems = [];
    isMainDataLoading = true;
    activeIndex = 0;
  }

  changeContractItems(List<Map<String, String>> contractItems) {
    this.contractItems = contractItems;
    notifyListeners();
  }

  changeCustomerItems(List<Map<String, String>> customerItems) {
    this.customerItems = customerItems;
    notifyListeners();
  }

  changeStudentItems(List<Map<String, String>> studentItems) {
    this.studentItems = studentItems;
    notifyListeners();
  }

  changeIsMainDataLoading(bool isMainDataLoading) {
    this.isMainDataLoading = isMainDataLoading;
    notifyListeners();
  }

  changeActiveIndex(int activeIndex) {
    this.activeIndex = activeIndex;
    notifyListeners();
  }
}
