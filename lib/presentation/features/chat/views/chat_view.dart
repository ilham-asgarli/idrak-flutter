import 'package:easy_localization/easy_localization.dart';
import 'package:emekteb/core/constants/colors/my_colors.dart';
import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:emekteb/data-domain/security/modules/chat_contact_controller.dart';
import 'package:emekteb/generated/locale_keys.g.dart';
import 'package:emekteb/presentation/features/chat/components/message_bubble.dart';
import 'package:emekteb/presentation/features/chat/notifiers/chat_notifier.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/views/base_view.dart';
import '../../../../data-domain/security/modules/chat_message_from_controller.dart';
import '../components/chat_view_placeholder.dart';
import '../view-models/chat_view_model.dart';

class ChatView extends StatefulWidget {
  final ChatContactController? chatContactController;

  const ChatView({
    required this.chatContactController,
    Key? key,
  }) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late ChatViewModel _chatViewModel;

  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    _chatViewModel.chatNotifier.isDisposed = true;
    super.dispose();
  }

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
              _chatViewModel.chatContactController =
                  widget.chatContactController;
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
          title: Text(
            _chatViewModel.chatContactController?.fullName ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
        ),
        body: buildBody(),
      ),
    );
  }

  buildBody() {
    return StreamBuilder(
      stream: _chatViewModel.streamSocket.getStream,
      //initialData: const <ChatMessageFromController>[],
      builder: (BuildContext context,
          AsyncSnapshot<List<ChatMessageFromContent>?> snapshot) {
        if (snapshot.hasData) {
          return buildChat(snapshot.data);
        } else {
          return const ChatViewPlaceholder();
        }
      },
    );
  }

  Widget buildChat(
    List<ChatMessageFromContent>? contents,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: LazyLoadScrollView(
            scrollOffset: context.height.toInt(),
            isLoading: _chatViewModel.chatNotifier.isLoadingOldMessages,
            onEndOfPage: () => _chatViewModel.loadOldMessages(),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: _chatViewModel.chatNotifier.isLoadingOldMessages,
                    child: const CircularProgressIndicator(),
                  ),
                  buildMessages(contents),
                ],
              ),
            ),
          ),
        ),
        Container(
          color: MyColors.mainColor,
          child: Padding(
            padding: EdgeInsets.only(
              left: context.normalValue,
            ),
            child: Row(
              children: [
                Expanded(
                  child: buildTextField(),
                ),
                const SizedBox(
                  width: 10,
                ),
                buildSend(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMessages(
    List<ChatMessageFromContent>? contents,
  ) {
    return ListView.separated(
      padding: context.paddingLow,
      physics: const NeverScrollableScrollPhysics(),
      cacheExtent: 1,
      reverse: true,
      shrinkWrap: true,
      itemCount: contents?.length ?? 0,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Visibility(
              visible: _chatViewModel.isNewDay(contents, index),
              child: Padding(
                padding: context.paddingLow,
                child: Card(
                  color: MyColors.mainColor,
                  child: Padding(
                    padding: context.paddingLow,
                    child: Text(
                      DateFormat("dd.MM.yyyy").format(
                        DateTime.parse(contents?[index].dateTime ?? ""),
                      ),
                      style: const TextStyle(color: MyColors.secondColor),
                    ),
                  ),
                ),
              ),
            ),
            MessageBubble(
              messageFromContent: contents?[index],
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 10,
        );
      },
    );
  }

  buildTextField() {
    return TextField(
      //focusNode: focusNode,
      cursorColor: MyColors.secondColor,
      style: const TextStyle(
        color: MyColors.secondColor,
      ),
      controller: textEditingController,
      minLines: null,
      maxLines: 1,
      decoration: InputDecoration(
        border: InputBorder.none, //OutlineInputBorder(),
        hintText: LocaleKeys.typeMessageHint.tr(),
      ),
    );
  }

  Widget buildSend() {
    return _chatViewModel.chatNotifier.isSendingMessage
        ? Container(
            margin: const EdgeInsets.only(right: 15),
            height: 20,
            width: 20,
            child: const CircularProgressIndicator(
              color: MyColors.secondColor,
            ),
          )
        : IconButton(
            color: MyColors.secondColor,
            icon: const Icon(Icons.send),
            onPressed: () {
              _chatViewModel.sendMessage(
                _chatViewModel.chatContactController?.username,
                textEditingController.text,
              );

              textEditingController.clear();
            },
          );
  }
}
