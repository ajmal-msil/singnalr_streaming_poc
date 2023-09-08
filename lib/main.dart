import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:singnalr_streaming_poc/bloc/watchlist_bloc.dart';
import 'package:singnalr_streaming_poc/models/streaming_data.dart';
import 'package:singnalr_streaming_poc/screens/watchlist_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late final HubConnection _hubConnection;
  late final WatchlistBloc _watchlistBloc;

  Timer? reconnectTimer;

  StreamController<StreamingData> dataStreamController =
      StreamController.broadcast();

  @override
  void initState() {
    _hubConnection = HubConnectionBuilder()
        .withUrl("http://192.168.100.79:5003/streamingHub",
            options: HttpConnectionOptions())
        .withAutomaticReconnect(retryDelays: [
      1000,
      2000,
      1000,
      1000,
      1000,
      5000,
      10000,
      20000,
    ]).build();
    _watchlistBloc = WatchlistBloc(_hubConnection);

    connectToSignalR();
    WidgetsBinding.instance.addObserver(this);

    _hubConnection.onreconnected(({connectionId}) {
      _startStreaming();
    });

    super.initState();
  }

  Future<void> connectToSignalR() async {
    try {
      await _hubConnection.start();
      print("Connected to SignalR server");

      _hubConnection.on('ReceiveStreamingData', _handleStreamingData);

      startStreaming();
    } catch (e) {
      print("Error connecting to SignalR server1: $e");
    }
  }

  _handleStreamingData(List<Object?>? args) {
    if (args != null && args.isNotEmpty) {
      final jsonData = args[0] as String;
      Map<String, dynamic> jsonMap = json.decode(jsonData);
      StreamingData streamingData = StreamingData.fromJson(jsonMap);
      print("Received streaming data: $jsonData");
      // setState(() {
      //   print("Received streaming ");
      //
      //   dataStreamController.add(streamingData);
      //   print("Received  after ");
      //
      // });
      dataStreamController.add(streamingData);
      print("Received streaming after ");

      // Add the received data to the BLoC
      // _watchlistBloc.add(UpdateWatchlistEvent([streamingData]));
    }
  }

  void startStreaming() async {
    try {
      if (_hubConnection.state == HubConnectionState.Connected) {
        await _hubConnection.invoke("StartStreaming");
      } else {
        print("Connection is not in the 'Connected' state.");

        reconnectTimer = Timer(Duration(seconds: 5), () {
          connectToSignalR(); // Implement the connectToSignalR function to reconnect
        });
      }
    } catch (e) {
      print("Error connecting to SignalR server2: $e");
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      print("AppLifecycleState.paused");

      _stopStreaming();
      // dataStreamController.close();
    } else if (state == AppLifecycleState.resumed) {
      print("AppLifecycleState.resumed");

      _startStreaming();
    }
  }

  Future startConnection() async {
    await _hubConnection.start();
  }

  Future stopConnection() async {
    await _hubConnection.stop();
  }

  _startStreaming() async {
    // await startConnection();
    _hubConnection.on("ReceiveStreamingData", _handleStreamingData);
  }

  _stopStreaming() async {
    _hubConnection.off("ReceiveStreamingData", method: _handleStreamingData);
    // await stopConnection();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Watchlist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => _watchlistBloc,
        child: WatchlistPage(
          dataStreamController: dataStreamController,
        ),
      ),
    );
  }
}
