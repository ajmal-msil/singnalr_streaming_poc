import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:singnalr_streaming_poc/models/streaming_data.dart';
 // Replace with your actual import

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final HubConnection _hubConnection;



  WatchlistBloc(this._hubConnection) : super(InitialState());

  @override
  Stream<WatchlistState> mapEventToState(WatchlistEvent event) async* {
    if (event is UpdateWatchlistEvent) {
      yield* _mapUpdateWatchlistEventToState(event);
    }
  }

  Stream<WatchlistState> _mapUpdateWatchlistEventToState(
      UpdateWatchlistEvent event) async* {
    yield UpdatedState(event.watchlistData);
  }
}
