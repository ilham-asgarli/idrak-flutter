import 'package:emekteb/data-domain/security/modules/chat_contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../utils/constants/assets/image_constants.dart';
import '../../../../utils/constants/navigation/navigation_constants.dart';
import '../../../../core/init/navigation/navigation_service.dart';
import '../../../widgets/image_placeholder.dart';

class ChatItem extends StatelessWidget {
  final ChatContactController? chatContactController;

  const ChatItem({
    Key? key,
    required this.chatContactController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildPage();
  }

  Widget buildPage() {
    return Card(
      child: ListTile(
        leading: buildProfilePhoto(),
        title: Text(
          chatContactController?.fullName ?? "",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
        subtitle: Text(
          chatContactController?.role ?? "",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
        trailing: SizedBox(
          width: 20,
          child: (chatContactController?.unreadMessagesCount ?? 0) > 0
              ? CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text(
                    "${chatContactController?.unreadMessagesCount ?? 0}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                )
              : const SizedBox(),
        ),
        onTap: () {
          NavigationService.instance.navigateToPage(
            path: NavigationConstants.CHAT_ITEM,
            data: chatContactController,
          );
        },
      ),
    );
  }

  Widget buildProfilePhoto({String? url}) {
    if (url != null) {
      return CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) => ImagePlaceholder(
          imageProvider: AssetImage(ImageConstants.instance.logoPlayStore),
        ),
        errorWidget: (context, url, error) => ImagePlaceholder(
          imageProvider: AssetImage(ImageConstants.instance.logoPlayStore),
        ),
        imageBuilder: (context, image) {
          return ImagePlaceholder(imageProvider: image);
        },
      );
    } else {
      return ImagePlaceholder(
        imageProvider: AssetImage(ImageConstants.instance.logoPlayStore),
      );
    }
  }
}
