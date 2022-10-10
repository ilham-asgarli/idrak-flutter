import 'package:emekteb/core/base/view-models/base_view_model.dart';
import 'package:emekteb/data-domain/security/services/security_service.dart';
import 'package:emekteb/presentation/features/chat/notifiers/chats_notifier.dart';
import 'package:provider/provider.dart';

import '../../../../utils/generics/chat/view-models/chat_init_view_model.dart';

class ChatsViewModel with BaseViewModel {
  late ChatsNotifier chatsNotifier;
  late ChatInitViewModel chatInitViewModel;

  SecurityService securityService = SecurityService();

  @override
  void init(context) async {
    super.init(context);

    chatInitViewModel = Provider.of<ChatInitViewModel>(context);
  }
}
