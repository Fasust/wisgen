import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wisgen/blocs/wisdom_bloc.dart';
import 'package:wisgen/blocs/wisdom_event.dart';
import 'package:wisgen/blocs/wisdom_state.dart';
import 'package:wisgen/ui/page_favorites.dart';
import 'package:wisgen/ui/ui_helper.dart';
import 'package:wisgen/ui/widgets/card_loading.dart';
import 'package:wisgen/ui/widgets/card_wisdom.dart';

//View Fre of Business Logic
//Subscribing to the Wisdom BLoC and displaying the Wisdom it Broadcasts
//Dispatching Fetch events on the Business BLoC when we reach the end of the List.
class PageWisdomFeed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageWisdomFeedState();
}

class PageWisdomFeedState extends State<PageWisdomFeed> {
  //We keep the Wisdom BLoC local because we only need it in this View
  final WisdomBloc _wisdomBloc = new WisdomBloc();
  final _scrollController = ScrollController();
  static const _scrollThreshold = 200.0;

  @override
  void initState() {
    _wisdomBloc.dispatch(FetchEvent(context));
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          _swipeNavigation(context, details);
        },
        child: BlocBuilder(
          bloc: _wisdomBloc,
          builder: (context, WisdomState state) {
            log('state: ' +state.toString());
            
            //This is where we determine the State of the Wisdom BLoC
            if (state is ErrorWisdomState) return _error(state);

            if (state is LoadedWisdomState) return _listView(context, state);
            
            log(state.toString());
            return _loading(context);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _wisdomBloc.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  //UI-Elements ----
  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Wisdom Feed',
        style: Theme.of(context).textTheme.headline,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      actions: <Widget>[
        IconButton(
          iconSize: UIHelper.iconSize,
          icon: Icon(
            Icons.list,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => PageFavoriteList()));
          },
        )
      ],
    );
  }

  Widget _error(ErrorWisdomState state) {
    return Center(
      child: Text('We Got this Exception when trying to fetch our Wisdom:\n' +
          state.exception.toString()),
    );
  }

  Widget _listView(BuildContext context, LoadedWisdomState state) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        log("list index: " + "$index");
        log("Wisdom Length: " + "${state.wisdoms.length}");
        return index >= state.wisdoms.length
        //This is where the Loading Inference is made. 
        //We don't have more List items so the BLoC must be loading
            ? CardLoading() 
            : CardWisdom(wisdom: state.wisdoms[index]);
      },
      itemCount: state.wisdoms.length + 1,
      controller: _scrollController,
    );
  }

  Widget _loading(BuildContext context) {
    return Center(
        child: SpinKitCircle(
      color: Theme.of(context).accentColor,
      size: UIHelper.loadingAnimSize,
    ));
  }

  //Navigation ----
  void _swipeNavigation(BuildContext context, DragEndDetails details) {
    if (details.primaryVelocity.compareTo(0) == -1) //right to left
      Navigator.push(context,
          CupertinoPageRoute(builder: (context) => PageFavoriteList()));
  }

  //Helpers ----
  //Dispatching fetch events to the BLoC when we reach the end of the List
  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _wisdomBloc.dispatch(FetchEvent(context));
    }
  }
}
