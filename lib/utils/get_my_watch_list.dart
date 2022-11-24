import 'package:http/http.dart' as http;
import 'package:counter_7/model/watch_list.dart';
import 'dart:convert';

Future<List<WatchList>> fetchWatchList() async {
  var url = Uri.parse('http://pbp-tugas2-hadziq.herokuapp.com/mywatchlist/json/');
  var response = await http.get(
    url,
    headers: {
      "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object WatchList
  List<WatchList> listWatchList = [];
  for (var d in data) {
    if (d != null) {
      listWatchList.add(WatchList.fromJson(d));
    }
  }

  return listWatchList;
}