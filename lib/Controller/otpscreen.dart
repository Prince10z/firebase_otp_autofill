import 'dart:async';

import 'package:get/get.dart';

class OtpControllers extends GetxController {
  late Timer timer;
  RxInt count = 30.obs;
  RxBool showbutton = false.obs;
  void runCount() async {
    if (count > 0) {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        count--;
        if (count == 0) {
          timer.cancel();
          showbutton.value = true;
        }
      });
    }
  }

  void reset() {
    showbutton.value = false;
    count.value = 30;
    runCount();
  }
}
