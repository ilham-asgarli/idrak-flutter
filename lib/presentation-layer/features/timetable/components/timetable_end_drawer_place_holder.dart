import 'package:flutter/material.dart';

import '../../../widgets/table_place_holder.dart';

class TimetableEndDrawerPlaceHolder extends StatelessWidget {
  const TimetableEndDrawerPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TablePlaceHolder(
      columnCount: 1,
      rowCount: 15,
    );
  }
}
