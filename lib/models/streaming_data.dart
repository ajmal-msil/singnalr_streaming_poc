// To parse this JSON data, do
//
//     final streamingData = streamingDataFromJson(jsonString);

import 'dart:convert';

StreamingData streamingDataFromJson(String str) => StreamingData.fromJson(json.decode(str));

String streamingDataToJson(StreamingData data) => json.encode(data.toJson());

class StreamingData {
  List<StreamingDatum> streamingData;

  StreamingData({
    required this.streamingData,
  });

  factory StreamingData.fromJson(Map<String, dynamic> json) => StreamingData(
    streamingData: List<StreamingDatum>.from(json["StreamingData"].map((x) => StreamingDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "StreamingData": List<dynamic>.from(streamingData.map((x) => x.toJson())),
  };
}

class StreamingDatum {
  Data data;
  String streamingType;

  StreamingDatum({
    required this.data,
    required this.streamingType,
  });

  factory StreamingDatum.fromJson(Map<String, dynamic> json) => StreamingDatum(
    data: Data.fromJson(json["data"]),
    streamingType: json["streaming_type"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "streaming_type": streamingType,
  };
}

class Data {
  dynamic oi;
  dynamic oiChngPer;
  int ttv;
  int atp;
  double chng;
  double chngPer;
  double close;
  double high;
  int lcl;
  double low;
  double ltp;
  int ltq;
  String ltt;
  double open;
  String symbol;
  int ucl;
  int vol;
  int yHigh;
  int yLow;
  dynamic askPrice;
  dynamic bidPrice;

  Data({
    required this.oi,
    required this.oiChngPer,
    required this.ttv,
    required this.atp,
    required this.chng,
    required this.chngPer,
    required this.close,
    required this.high,
    required this.lcl,
    required this.low,
    required this.ltp,
    required this.ltq,
    required this.ltt,
    required this.open,
    required this.symbol,
    required this.ucl,
    required this.vol,
    required this.yHigh,
    required this.yLow,
    required this.askPrice,
    required this.bidPrice,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    oi: json["OI"],
    oiChngPer: json["OIChngPer"],
    ttv: json["ttv"],
    atp: json["atp"],
    chng: json["chng"]?.toDouble(),
    chngPer: json["chngPer"]?.toDouble(),
    close: json["close"]?.toDouble(),
    high: json["high"]?.toDouble(),
    lcl: json["lcl"],
    low: json["low"]?.toDouble(),
    ltp: json["ltp"]?.toDouble(),
    ltq: json["ltq"],
    ltt: json["ltt"],
    open: json["open"]?.toDouble(),
    symbol: json["symbol"],
    ucl: json["ucl"],
    vol: json["vol"],
    yHigh: json["yHigh"],
    yLow: json["yLow"],
    askPrice: json["askPrice"],
    bidPrice: json["bidPrice"],
  );

  Map<String, dynamic> toJson() => {
    "OI": oi,
    "OIChngPer": oiChngPer,
    "ttv": ttv,
    "atp": atp,
    "chng": chng,
    "chngPer": chngPer,
    "close": close,
    "high": high,
    "lcl": lcl,
    "low": low,
    "ltp": ltp,
    "ltq": ltq,
    "ltt": ltt,
    "open": open,
    "symbol": symbol,
    "ucl": ucl,
    "vol": vol,
    "yHigh": yHigh,
    "yLow": yLow,
    "askPrice": askPrice,
    "bidPrice": bidPrice,
  };
}
