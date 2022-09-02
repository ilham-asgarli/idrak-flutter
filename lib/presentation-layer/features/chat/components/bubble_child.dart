import 'package:easy_localization/easy_localization.dart';
import 'package:emekteb/data-domain-layer/security/modules/chat_message_from_controller.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors/my_colors.dart';

class BubbleChild extends StatelessWidget {
  final ChatMessageFromContent? messageFromContent;

  const BubbleChild({
    Key? key,
    required this.messageFromContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        children: [
          Text(
            messageFromContent?.message ?? "",
            style: const TextStyle(
              fontSize: 15,
              color: MyColors.secondColor,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                DateFormat("HH:mm").format(
                  DateTime.parse(messageFromContent?.dateTime ?? ""),
                ),
                style: const TextStyle(
                  fontSize: 10,
                  //fontWeight: FontWeight.bold,
                  color: MyColors.secondColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
