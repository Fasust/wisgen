import 'package:flutter/material.dart';
import 'package:wisgen/models/wisdom.dart';
import 'package:wisgen/ui/widgets/wisdom_card.dart';

import '../ui_helper.dart';
import 'loading_card.dart';

class WisdomList extends StatelessWidget {
  final List<Wisdom> _wisdoms;
  final ScrollController _scrollController;

  const WisdomList(this._scrollController, this._wisdoms);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(UiHelper.listPadding),
      itemBuilder: (BuildContext context, int index) {
        return index >= _wisdoms.length
            //This is where the Loading Inference is made.
            //We don't have more List items so the BLoC must be loading
            ? LoadingCard()
            : WisdomCard(_wisdoms[index]);
      },
      itemCount: _wisdoms.length + 1,
      controller: _scrollController,
    );
  }
}