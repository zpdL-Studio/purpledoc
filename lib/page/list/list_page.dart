import 'package:get/get.dart';

import '../../provider/hacker_news/hacker_news_provider.dart';
import 'list_controller.dart';
import 'list_widget.dart';

const listPageName = '/';

class ListPage extends GetPage {
  ListPage()
      : super(
            name: listPageName,
            binding: _Bindings(),
            page: () => const ListWidget());
}

class _Bindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HackerNewsProvider());
    Get.lazyPut(() => ListController(hackerNewsProvider: Get.find()));
  }
}
