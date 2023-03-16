import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/data/services/storage/services.dart';
import 'package:todo/modules/home/view.dart';

import 'modules/home/binding.dart';

main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
      home: Home(),
    );
  }
}
