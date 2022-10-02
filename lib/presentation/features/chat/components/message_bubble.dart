import 'package:emekteb/core/constants/colors/my_colors.dart';
import 'package:emekteb/presentation/features/chat/components/bubble_child.dart';
import 'package:flutter/material.dart';

import '../../../../data-domain/security/modules/chat_message_from_controller.dart';
import 'bubble_background.dart';

@immutable
class MessageBubble extends StatelessWidget {
  final ChatMessageFromContent? messageFromContent;
  final Widget? child;

  const MessageBubble({
    Key? key,
    this.messageFromContent,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageAlignment = (messageFromContent?.owner ?? true)
        ? Alignment.topRight
        : Alignment.topLeft;

    return FractionallySizedBox(
      widthFactor: 1,
      child: FractionallySizedBox(
        alignment: messageAlignment,
        widthFactor: 0.8,
        child: Align(
          alignment: messageAlignment,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              child: BubbleBackground(
                colors: (messageFromContent?.owner ?? true)
                    ? [
                        Colors.green.shade300,
                        Colors.green,
                      ]
                    : [
                        MyColors.mainColor.shade300,
                        MyColors.mainColor,
                      ],
                child: DefaultTextStyle.merge(
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: child ??
                        BubbleChild(
                          messageFromContent: messageFromContent,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
