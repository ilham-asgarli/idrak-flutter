import 'package:emekteb/presentation-layer/features/contract/notifiers/contract_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../presentation-layer/features/contract/notifiers/contract_details_notifier.dart';
import '../../../presentation-layer/features/contract/notifiers/contract_payments_graphic_view_page_item_notifier.dart';
import '../../../presentation-layer/features/contract/notifiers/contract_payments_graphic_view_page_notifier.dart';
import '../navigation/navigation_service.dart';
import 'theme_notifier.dart';

class ApplicationProvider {
  static ApplicationProvider? _instance;

  static ApplicationProvider get instance {
    _instance ??= ApplicationProvider._init();
    return _instance!;
  }

  ApplicationProvider._init();

  List<SingleChildWidget> singleItems = [];
  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
    ),
    ChangeNotifierProvider(
      create: (_) => ContractDetailsNotifier(),
    ),
    ChangeNotifierProvider(
      create: (_) => ContractNotifier(),
    ),
    ChangeNotifierProvider(
      create: (_) => ContractPaymentsGraphicViewPageNotifier(),
    ),
    ChangeNotifierProvider(
      create: (_) => ContractPaymentsGraphicViewPageItemNotifier(),
    ),
    //Provider.value(value: NavigationService.instance),
  ];
  List<SingleChildWidget> uiChangesItems = [];
}
