import 'package:emekteb/presentation-layer/features/chat/notifiers/chat_notifier.dart';
import 'package:emekteb/presentation-layer/features/chat/view-models/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/views/base_view.dart';

class ChatView extends StatefulWidget {
  final String title;

  const ChatView({required this.title, Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late ChatViewModel _chatViewModel;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatNotifier(),
        ),
        Consumer<ChatNotifier>(builder: (context, notifier, _) {
          return BaseView<ChatViewModel>(
            viewModel: ChatViewModel(),
            onModelReady: (model) async {
              _chatViewModel = model;
              _chatViewModel.chatNotifier = notifier;
              model.init(context);
            },
            onPageBuilder: (BuildContext buildContext, ChatViewModel model) =>
                buildPage(),
          );
        }),
      ],
    );
  }

  buildPage() {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text(widget.title),
        ),
        body: buildBody(),
      ),
    );
  }

  buildBody() {
    return Container();
  }
}
