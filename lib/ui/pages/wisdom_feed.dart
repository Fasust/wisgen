import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisgen/blocs/favorite_bloc.dart';
import 'package:wisgen/blocs/storage_bloc.dart';
import 'package:wisgen/blocs/wisdom_bloc.dart';
import 'package:wisgen/blocs/wisdom_event.dart';
import 'package:wisgen/blocs/wisdom_state.dart';
import 'package:wisgen/models/wisdom.dart';
import 'package:wisgen/ui/pages/favorites.dart';
import 'package:wisgen/ui/ui_helper.dart';
import 'package:wisgen/ui/widgets/error_text.dart';
import 'package:wisgen/ui/widgets/loading_card.dart';
import 'package:wisgen/ui/widgets/loading_spinner.dart';
import 'package:wisgen/ui/widgets/wisdom_card.dart';

///Subscribes to the WisdomBLoC to generate its ListView.
///Sets of the WisdomBLoC by dispatching an initial FetchEvent.
///Sets up the StorageBLoC and links it to the Globally Provided FavoritesBLoC.
class WisdomFeed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WisdomFeedState();
}

class WisdomFeedState extends State<WisdomFeed> {
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
            if (state is WisdomStateIdle)
              return _WisdomList(_scrollController, state.wisdoms);

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
                context, CupertinoPageRoute(builder: (context) => Favorites()));
          },
        )
      ],
    );
  }

  ///Navigation
  void _swipeNavigation(BuildContext context, DragEndDetails details) {
    if (details.primaryVelocity.compareTo(0) == -1) //right to left
      Navigator.push(
          context, CupertinoPageRoute(builder: (context) => Favorites()));
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
//Private Widgets -----------
class _WisdomList extends StatelessWidget {
  final List<Wisdom> _wisdoms;
  final ScrollController _scrollController;

  const _WisdomList(this._scrollController, this._wisdoms);

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
