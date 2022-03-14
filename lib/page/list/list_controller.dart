import 'package:get/get.dart';
import 'package:purpledog/obx/obx_snapshop.dart';
import 'package:purpledog/provider/hacker_news/hacker_news_provider.dart';

class ListController extends GetxController {
  final HackerNewsProvider hackerNewsProvider;

  ListController({required this.hackerNewsProvider});

  late final _category = hackerNewsProvider.category.first.obs;

  String get category => _category.value;

  set category(String value) => _category.value = value;

  final _list = const ObxSnapshot<List<int>>.init().obs;

  ObxSnapshot<List<int>> get list => _list.value;

  @override
  void onInit() {
    super.onInit();

    refreshCategory();
    _category.listen((p0) async {
      refreshCategory();
    });
  }

  void refreshCategory() async {
    _list.value = _list.value.copyWithState(ObxSnapshotState.loading);
    try {
      _list.value = ObxSnapshot<List<int>>.value(
          await hackerNewsProvider.getList(category));
    } catch (e) {
      _list.value =
          ObxSnapshot<List<int>>(ObxSnapshotState.error, _list.value.value, e);
    }
  }
}
