import 'package:easy_localization/easy_localization.dart';
import 'package:emekteb/core/constants/colors/my_colors.dart';
import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:emekteb/data-domain-layer/security/modules/chat_message_from_controller.dart';
import 'package:emekteb/presentation-layer/widgets/my_shimmer.dart';
import 'package:flutter/material.dart';

import '../../../../generated/locale_keys.g.dart';
import 'message_bubble.dart';

class ChatViewPlaceholder extends StatefulWidget {
  const ChatViewPlaceholder({Key? key}) : super(key: key);

  @override
  State<ChatViewPlaceholder> createState() => _ChatViewPlaceholderState();
}

class _ChatViewPlaceholderState extends State<ChatViewPlaceholder> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return buildChat();
  }

  Widget buildChat() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: buildMessages(),
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

  Widget buildMessages() {
    return ListView.separated(
      padding: context.paddingLow,
      cacheExtent: 1,
      reverse: true,
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return MyShimmer(
          color: index.isOdd ? MyColors.mainColor : Colors.green,
          child: MessageBubble(
            messageFromContent: ChatMessageFromContent(
              owner: index.isEven,
            ),
            child: SizedBox(
              height: (10 * (index + 1)).toDouble(),
              width: (30 * (index + 1)).toDouble(),
            ),
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
