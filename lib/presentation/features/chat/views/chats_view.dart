import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:emekteb/presentation/features/chat/components/chats_view_placeholder.dart';
import 'package:emekteb/presentation/features/chat/view-models/chats_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/views/base_view.dart';
import '../../../../data-domain/security/modules/chat_contact_controller.dart';
import '../components/chats_item.dart';
import '../notifiers/chats_notifier.dart';

class ChatsView extends StatefulWidget {
  final String title;

  const ChatsView({required this.title, Key? key}) : super(key: key);

  @override
  State<ChatsView> createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  late ChatsViewModel _chatsViewModel;

  @override
  void dispose() {
    _chatsViewModel.chatsNotifier.isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatsNotifier(),
        ),
        Consumer<ChatsNotifier>(builder: (context, notifier, _) {
          return BaseView<ChatsViewModel>(
            viewModel: ChatsViewModel(),
            onModelReady: (model) async {
              _chatsViewModel = model;
              _chatsViewModel.chatsNotifier = notifier;
              model.init(context);
            },
            onPageBuilder: (BuildContext buildContext, ChatsViewModel model) =>
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
    return StreamBuilder(
      stream: _chatsViewModel.chatInitViewModel.streamSocket.getStream,
      //initialData: const <ChatContactController>[],
      builder: (
        BuildContext context,
        AsyncSnapshot<List<ChatContactController?>?> snapshot,
      ) {
        if (snapshot.hasData) {
          return buildChats(snapshot.data);
        } else {
          return const ChatsViewPlaceholder();
        }
      },
    );
  }

  buildChats(List<ChatContactController?>? chatContactControllers) {
    return ListView.separated(
      padding: context.paddingLow,
      cacheExtent: 1,
      itemCount: chatContactControllers?.length ?? 0,
      itemBuilder: (context, index) {
        return InkWell(
          child: ChatItem(
            chatContactController: chatContactControllers?[index],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 10,
        );
      },
    );
  }
}
