import 'package:flutter/material.dart';
import 'package:singnalr_streaming_poc/models/streaming_data.dart';

class WatchlistItem extends StatelessWidget {
  final StreamingDatum item;

  WatchlistItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item.data.symbol,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              item.data.ltp.toStringAsFixed(2),
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '${item.data.chng.toStringAsFixed(2)} (${item.data.chngPer.toStringAsFixed(2)}%)',
              style: TextStyle(
                color: item.data.chng < 0 ? Colors.red : Colors.green,
                fontSize: 14,
              ),
            ),
          ],
        ),
        title: Text(
          item.data.ltt,
          style: TextStyle(fontSize: 14),
        ),
        subtitle: Text(
          'Vol: ${item.data.vol}',
          style: TextStyle(fontSize: 14),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
        },
      ),
    );
  }
}
