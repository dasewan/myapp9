import 'package:myapp9/mvp/mvps.dart';

abstract class LoanBankIMvpView implements IMvpView {
  // void onCreateSuccess(CreateDBorrowEntityEntity createDBorrowEntityEntity);
  void onCreateSuccess(String route, bool toHome);

  void onCreateRefuse(String message);
}
