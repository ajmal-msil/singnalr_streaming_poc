import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:singnalr_streaming_poc/bloc/watchlist_bloc.dart';
import 'package:singnalr_streaming_poc/models/streaming_data.dart';
import 'package:singnalr_streaming_poc/widgets/watchlist_item.dart';

class WatchlistPage extends StatefulWidget {
  final StreamController<StreamingData> dataStreamController;

  const WatchlistPage({super.key, required this.dataStreamController});


  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Watchlist'),
      ),
      body: StreamBuilder<StreamingData>(
        stream:  widget.dataStreamController.stream,
        builder: (context, snapshot) {
              if (snapshot.hasData) {

                final watchlistData = snapshot.data?.streamingData;

                return ListView.builder(
                  itemCount: watchlistData?.length,
                  itemBuilder: (context, index) {
                    final item = watchlistData![index];
                    return WatchlistItem(item: item);
                  },
                );
              } else {
                return Text(
                  "item.data.ltt",
                  style: TextStyle(fontSize: 14),
                );
              }

        }
      ),
    );
  }
}
