part of 'watchlist_bloc.dart';

@immutable
abstract class WatchlistEvent {}

class UpdateWatchlistEvent extends WatchlistEvent {
  final List<StreamingData> watchlistData;
  UpdateWatchlistEvent(this.watchlistData);
}
