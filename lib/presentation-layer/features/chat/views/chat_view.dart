import 'package:easy_localization/easy_localization.dart';
import 'package:emekteb/core/constants/colors/my_colors.dart';
import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:emekteb/data-domain-layer/security/modules/chat_contact_controller.dart';
import 'package:emekteb/generated/locale_keys.g.dart';
import 'package:emekteb/presentation-layer/features/chat/components/message_bubble.dart';
import 'package:flutter/material.dart';

import '../../../../core/base/views/base_view.dart';
import '../../../../data-domain-layer/security/modules/chat_message_from_controller.dart';
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
  Widget build(BuildContext context) {
    return BaseView<ChatViewModel>(
      viewModel: ChatViewModel(),
      onModelReady: (model) async {
        _chatViewModel = model;
        _chatViewModel.chatContactController = widget.chatContactController;
        model.init(context);
      },
      onPageBuilder: (BuildContext buildContext, ChatViewModel model) =>
          buildPage(),
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
      initialData: const <ChatMessageFromController>[],
      builder: (BuildContext context,
          AsyncSnapshot<List<ChatMessageFromController?>?> snapshot) {
        if (snapshot.hasData) {
          return buildChat(snapshot.data);
        } else {
          return Container();
        }
      },
    );
  }

  Widget buildChat(
    List<ChatMessageFromController?>? chatMessageFromControllers,
  ) {
    return Column(
      children: [
        Expanded(
          child: buildMessages(chatMessageFromControllers),
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
    List<ChatMessageFromController?>? chatMessageFromControllers,
  ) {
    return ListView.separated(
      padding: context.paddingLow,
      cacheExtent: 1,
      reverse: true,
      shrinkWrap: true,
      itemCount: chatMessageFromControllers?.length ?? 0,
      itemBuilder: (context, index) {
        return MessageBubble(
          messageFromController: chatMessageFromControllers?[index],
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
    return IconButton(
      color: MyColors.secondColor,
      icon: const Icon(Icons.send),
      onPressed: () {
        textEditingController.clear();
      },
    );
  }
}
