import 'package:get/get.dart';

import 'detail/detail_page.dart';
import 'list/list_page.dart';

const initialRoute = listPageName;

List<GetPage> getPages = [
  ListPage(),
  DetailPage(),
];