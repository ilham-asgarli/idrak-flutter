import 'package:emekteb/utils/app/chat/view-models/chat_init_view_model.dart';
import 'package:emekteb/presentation/features/contract/notifiers/contract_notifier.dart';
import 'package:emekteb/presentation/features/contract/notifiers/contract_payments_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../presentation/features/contract/notifiers/contract_payments_graphic_view_page_item_notifier.dart';
import '../../../presentation/features/contract/notifiers/contract_payments_graphic_view_page_notifier.dart';
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
      create: (_) => ThemeNotifier(),
    ),
    //Provider.value(value: NavigationService.instance),
  ];

  List<SingleChildWidget> uiChangesItems = [
    ChangeNotifierProvider(
      create: (_) => ContractNotifier(),
    ),
    ChangeNotifierProvider(
      create: (_) => ContractPaymentsGraphicViewPageNotifier(),
    ),
    ChangeNotifierProvider(
      create: (_) => ContractPaymentsGraphicViewPageItemNotifier(),
    ),
    ChangeNotifierProvider(
      create: (_) => ContractPaymentsNotifier(),
    ),
    ChangeNotifierProvider(
      create: (_) => ChatInitViewModel(_),
    ),
  ];
}
