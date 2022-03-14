import 'package:get/get.dart';
import 'package:purpledog/obx/obx_snapshop.dart';
import 'package:purpledog/provider/hacker_news/hacker_news_provider.dart';

class DetailController extends GetxController {
  final HackerNewsProvider hackerNewsProvider;

  DetailController({required this.hackerNewsProvider});

  final _item = const ObxSnapshot<HackerNewsItem>.loading().obs;

  ObxSnapshot<HackerNewsItem> get item => _item.value;

  @override
  void onInit() {
    super.onInit();
    _init(Get.parameters['id'] ?? '');
  }

  void _init(String id) async {
    try {
      _item.value = ObxSnapshot<HackerNewsItem>.value(
          await hackerNewsProvider.getItem(id));
    } catch (e) {
      _item.value = ObxSnapshot<HackerNewsItem>.error(e);
      Get.snackbar('Error', '$e');
    }
  }
}
