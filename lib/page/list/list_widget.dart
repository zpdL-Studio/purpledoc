import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purpledog/obx/obx_snapshop.dart';
import 'package:purpledog/page/detail/detail_page.dart';

import 'list_controller.dart';

class ListWidget extends GetWidget<ListController> {
  const ListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Obx(() => Text(controller.category)),
        centerTitle: true,
      ),
      body: SafeArea(child: Obx(_buildList)),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCategoryDialog,
        child: const Icon(Icons.list),
      ),
    );
  }

  Widget _buildList() {
    final list = controller.list;

    switch (list.state) {
      case ObxSnapshotState.init:
        return Container();
      case ObxSnapshotState.loading:
        return Stack(
          children: [
            _buildListIds(),
            Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
                child: const Center(child: CircularProgressIndicator())),
          ],
        );
      case ObxSnapshotState.value:
        return Stack(
          children: [
            _buildListIds(),
          ],
        );
      case ObxSnapshotState.error:
        return Stack(
          children: [
            _buildListIds(),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
              child: Center(
                child: ElevatedButton(
                  onPressed: controller.refreshCategory,
                  child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        '다시 시도해주세요.',
                        textAlign: TextAlign.center,
                      )),
                ),
              ),
            ),
          ],
        );
    }
  }

  Widget _buildListIds() {
    final ids = controller.list.value ?? [];

    return ListView.builder(
        key: ValueKey(controller.category),
        itemCount: ids.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(ids[index].toString()),
            onTap: () {
              Get.toNamed('$detailPageName/${ids[index]}');
            },
          );
        });
  }

  void _showCategoryDialog() async {
    final result = await Get.bottomSheet(Builder(builder: (context) {
      final currentCategory = controller.category;
      final children = <Widget>[];
      for (final category in controller.hackerNewsProvider.category) {
        if (category == currentCategory) {
          children.add(ListTile(
            title: Text(
              category,
              style: const TextStyle(color: Colors.blue),
            ),
          ));
        } else {
          children.add(ListTile(
            onTap: () {
              Navigator.pop(context, category);
            },
            title: Text(category),
          ));
        }
      }

      return Material(
        child: ListView(
          shrinkWrap: true,
          children: children,
        ),
      );
    }));

    if (result is String) {
      controller.category = result;
    }
  }
}
