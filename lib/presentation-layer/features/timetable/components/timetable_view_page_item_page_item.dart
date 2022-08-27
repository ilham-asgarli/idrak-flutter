import 'package:emekteb/data-domain-layer/school/modules/timetable_controller.dart';
import 'package:emekteb/presentation-layer/widgets/my_table.dart';
import 'package:flutter/material.dart';

import '../../../../core/base/views/base_view.dart';
import '../view-models/timetable_view_page_item_page_item_view_model.dart';

class TimetableViewPageItemPageItem extends StatefulWidget {
  final Dates? date;
  final int index;

  const TimetableViewPageItemPageItem({
    required this.date,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  State<TimetableViewPageItemPageItem> createState() =>
      _TimetableViewPageItemPageItemState();
}

class _TimetableViewPageItemPageItemState
    extends State<TimetableViewPageItemPageItem> {
  late TimetableViewPageItemPageItemViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<TimetableViewPageItemPageItemViewModel>(
      viewModel: TimetableViewPageItemPageItemViewModel(),
      onModelReady: (model) async {
        _viewModel = model;
        _viewModel.date = widget.date;
        model.init(context);
      },
      onPageBuilder: (BuildContext buildContext,
              TimetableViewPageItemPageItemViewModel model) =>
          buildPage(),
    );
  }

  Widget buildPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyTable(map: _viewModel.getTimetableSubjectMap(widget.index)),
      ],
    );
  }
}
