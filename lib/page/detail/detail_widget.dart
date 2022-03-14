import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purpledog/obx/obx_snapshop.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'detail_controller.dart';

class DetailWidget extends GetWidget<DetailController> {
  const DetailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Obx(() {
          switch (controller.item.state) {
            case ObxSnapshotState.init:
            case ObxSnapshotState.loading:
            case ObxSnapshotState.error:
              return Container();
            case ObxSnapshotState.value:
              return Text(controller.item.requireData.title);
          }
        }),
        centerTitle: true,
      ),
      body: SafeArea(child: Obx(_build)),
    );
  }

  Widget _build() {
    final item = controller.item;

    switch (item.state) {
      case ObxSnapshotState.init:
      case ObxSnapshotState.error:
        return Container();
      case ObxSnapshotState.loading:
        return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.transparent,
            child: const Center(child: CircularProgressIndicator()));
      case ObxSnapshotState.value:
        return WebView(
          initialUrl: item.requireData.url,
        );
    }
  }
}
