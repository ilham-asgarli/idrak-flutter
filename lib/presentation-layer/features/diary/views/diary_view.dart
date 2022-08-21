import 'package:flutter/material.dart';

import '../../../../core/base/views/base_view.dart';
import '../view-models/diary_view_model.dart';

class DiaryView extends StatefulWidget {
  final String title;

  const DiaryView({required this.title, Key? key}) : super(key: key);

  @override
  State<DiaryView> createState() => _DiaryViewState();
}

class _DiaryViewState extends State<DiaryView> {
  late DiaryViewModel _diaryViewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<DiaryViewModel>(
      viewModel: DiaryViewModel(),
      onModelReady: (model) async {
        _diaryViewModel = model;
        model.init(context);
      },
      onPageBuilder: (BuildContext buildContext, DiaryViewModel model) =>
          buildPage(),
    );
  }

  Widget buildPage() {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text(widget.title),
        ),
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Container();
  }
}
