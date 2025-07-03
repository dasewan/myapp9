import 'package:myapp9/mvp/mvps.dart';

import '../../../models/index_entity.dart';

abstract class IndexNewIMvpView implements IMvpView {
  // IndexNewProvider get provider;

  void showPopupOverlay(int indexAction, IndexDataRemind remind);

  void goSwipper();

  void createVerify();

  void goVerifyList();

  void goLiveness();

  void goSign(int productId);

  void goRepay(int productId);
  void scroll();
}
