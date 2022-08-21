import 'package:emekteb/core/base/view-models/base_view_model.dart';
import 'package:emekteb/presentation-layer/features/contract/notifiers/contract_details_notifier.dart';
import 'package:emekteb/presentation-layer/features/contract/notifiers/contract_notifier.dart';
import 'package:provider/provider.dart';

class ContractDetailsViewModel with BaseViewModel {
  late ContractDetailsNotifier contractDetailsNotifier;
  late ContractNotifier contractNotifier;

  @override
  void init(context) {
    super.init(context);
    contractNotifier = Provider.of<ContractNotifier>(context);
    contractDetailsNotifier = Provider.of<ContractDetailsNotifier>(context);
  }
}