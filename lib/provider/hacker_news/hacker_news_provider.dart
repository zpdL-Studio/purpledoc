import 'package:get/get.dart';
import 'package:purpledog/tool/map_extension.dart';

import '../provider_exception.dart';


class HackerNewsProvider extends GetConnect {

  static const _baseUrl = 'https://hacker-news.firebaseio.com/v0/';

  final List<String> category = [
    'topstories',
    'newstories',
    'askstories',
    'showstories',
    'jobstories'
  ];

  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = _baseUrl;
  }

  Future<List<int>> getList(String category) async {
    final res = await get('$category.json?print=pretty');
    if(res.isOk) {
      final body = res.body;
      if(body is List) {
        final results = <int>[];
        for(final id in body) {
          if(id is int) {
            results.add(id);
          }
        }
        return results..sort();
      }
    }

    throw ProviderException();
  }

  Future<HackerNewsItem> getItem(String id) async {
    final res = await get('item/$id.json?print=pretty');
    if(res.isOk) {
      final body = res.body;
      if(body is Map) {
        return HackerNewsItem(body);
      }
    }

    throw ProviderException();
  }
}

class HackerNewsItem {
  final String id;
  final String by;
  final String title;
  final String type;
  final String score;
  final String descendants;
  final String url;

  HackerNewsItem(Map map)
      : id = map.getString('id'),
        by = map.getString('by'),
        title = map.getString('title'),
        type = map.getString('type'),
        score = map.getString('score'),
        descendants = map.getString('descendants'),
        url = map.getString('url');
}
