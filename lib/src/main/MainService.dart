import '../../main.dart';
import 'interfaces/MainView.dart';
import 'models/MainResponse.dart';

class MainService {
  final MainView mMainView;

  MainService(this.mMainView);

  void getTest() async {
    try {
      MyApp.getDio().lock();
      await MyApp.getDio().get("/test").then((value) {
        MainResponse mainResponse = MainResponse.fromJson(value.data);
        if (mainResponse == null || !mainResponse.isSuccess) {
          mMainView.validateFailure();
          return;
        }
        mMainView.validateSuccess(mainResponse);
      }).whenComplete(() => MyApp.getDio().unlock());
    } catch (e) {
      mMainView.validateFailure();
    }
  }
}
