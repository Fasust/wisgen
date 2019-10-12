import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisgen/blocs/favorite_bloc.dart';
import 'package:wisgen/blocs/storage_bloc.dart';
import 'package:wisgen/blocs/wisdom_bloc.dart';
import 'package:wisgen/blocs/wisdom_event.dart';
import 'package:wisgen/blocs/wisdom_state.dart';
import 'package:wisgen/ui/pages/favorites_page.dart';
import 'package:wisgen/ui/ui_helper.dart';
import 'package:wisgen/ui/widgets/error_text.dart';
import 'package:wisgen/ui/widgets/loading_spinner.dart';
import 'package:wisgen/ui/widgets/wisdom_list.dart';

///Subscribes to the WisdomBLoC to generate its ListView.
///Sets of the WisdomBLoC by dispatching an initial FetchEvent.
///Sets up the StorageBLoC and links it to the Globally Provided FavoritesBLoC.
class WisdomFeedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WisdomFeedPageState();
}

class WisdomFeedPageState extends State<WisdomFeedPage> {
  //Wisdom & Storage BLoC are Local because we only use
  //them inside this View
  WisdomBloc _wisdomBloc;
  StorageBloc _storageBloc;

  //We Tell the WisdomBLoC to fetch more data based on how far we have scrolled down
  //the list. That is why we need this Controller
  final _scrollController = ScrollController();
  static const _scrollThreshold = 200.0;

  @override
  void initState() {
    //Build Local BLoCs
    _wisdomBloc = WisdomBloc();
    _storageBloc = StorageBloc(BlocProvider.of<FavoriteBloc>(context));

    //Dispatch Initial Events
    _wisdomBloc.dispatch(WisdomEventFetch(context));
    _storageBloc.dispatch(StorageEvent.load);

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
            //This is where we determine the State of the Wisdom BLoC
            if (state is WisdomStateError) return ErrorText(state.exception);
            if (state is WisdomStateIdle) return WisdomList(_scrollController, state.wisdoms);

            return LoadingSpinner();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    //Dispose all local BLoCs
    _wisdomBloc.dispose();
    _storageBloc.dispose();

    _scrollController.dispose();
    super.dispose();
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Wisdom Feed',
        style: Theme.of(context).textTheme.headline,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      actions: <Widget>[
        IconButton(
          iconSize: UiHelper.iconSize,
          icon: Icon(
            Icons.list,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context, CupertinoPageRoute(builder: (context) => FavoritesPage()));
          },
        )
      ],
    );
  }

  ///Navigation
  void _swipeNavigation(BuildContext context, DragEndDetails details) {
    if (details.primaryVelocity.compareTo(0) == -1) //right to left
      Navigator.push(
          context, CupertinoPageRoute(builder: (context) => FavoritesPage()));
  }

  ///Dispatching fetch events to the BLoC when we reach the end of the List
  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _wisdomBloc.dispatch(WisdomEventFetch(context));
    }
  }
}