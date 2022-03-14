import 'package:get/get.dart';

import '../../provider/hacker_news/hacker_news_provider.dart';
import 'detail_controller.dart';
import 'detail_widget.dart';

const detailPageName = '/item';

class DetailPage extends GetPage {
  DetailPage()
      : super(
            name: '$detailPageName/:id',
            binding: _Bindings(),
            page: () => const DetailWidget());
}

class _Bindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HackerNewsProvider());
    Get.lazyPut(() => DetailController(hackerNewsProvider: Get.find()));
  }
}
