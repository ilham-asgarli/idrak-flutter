import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

import '../../../widgets/table_place_holder.dart';

class ChatsViewPlaceholder extends StatelessWidget {
  const ChatsViewPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: context.paddingLow,
      child: const TablePlaceHolder(
        columnCount: 1,
        rowCount: 25,
        padding: 28,
        space: 10,
      ),
    );
  }
}
