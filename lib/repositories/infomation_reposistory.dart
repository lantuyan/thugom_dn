import 'package:appwrite/models.dart' as models;
import 'package:thu_gom/providers/infomation_provider.dart';
class InfomationReposistory{
  final InfomationProvider infomationProvider;
  InfomationReposistory(this.infomationProvider);

  Future<models.Document > getMainInfomationSetting() => infomationProvider.getMainInfomationSetting();
}