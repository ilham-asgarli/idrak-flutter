import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

import '../../../widgets/table_place_holder.dart';

class ContractPaymentsPlaceHolder extends StatelessWidget {
  const ContractPaymentsPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingNormal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          TablePlaceHolder(
            columnCount: 2,
            rowCount: 6,
          ),
        ],
      ),
    );
  }
}
