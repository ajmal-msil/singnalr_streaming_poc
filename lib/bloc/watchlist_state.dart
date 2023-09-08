part of 'watchlist_bloc.dart';

@immutable
abstract class WatchlistState {}

class InitialState extends WatchlistState {}

class UpdatedState extends WatchlistState {
  final List<StreamingData> watchlistData;
  UpdatedState(this.watchlistData);
}
