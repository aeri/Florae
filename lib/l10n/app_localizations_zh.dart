// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get no => '否';

  @override
  String get yes => '是';

  @override
  String get mainNoCares => '哎呀！还没有什么植物需要养护哟';

  @override
  String get mainNoPlants => '花园是空的，种点什么吗？';

  @override
  String get buttonGarden => '花园';

  @override
  String get buttonToday => '今天';

  @override
  String get tooltipCareAll => '养护所有植物';

  @override
  String get tooltipShowCalendar => '显示日历';

  @override
  String get tooltipSettings => '设置';

  @override
  String get tooltipNewPlant => '新增植物';

  @override
  String get selectDays => '选择日期';

  @override
  String get ok => '确定';

  @override
  String get every => '每';

  @override
  String get days => '天';

  @override
  String get never => '从不';

  @override
  String get titleEditPlant => '编辑';

  @override
  String get titleNewPlant => '新增';

  @override
  String get tooltipCameraImage => '相机拍照';

  @override
  String get tooltipNextAvatar => '换个头像';

  @override
  String get tooltipGalleryImage => '相册选图';

  @override
  String get emptyError => '请输入文字';

  @override
  String get conflictError => '同名植物已经存在';

  @override
  String get labelName => '名称';

  @override
  String get exampleName => '例如：鸢尾';

  @override
  String get labelDescription => '详情';

  @override
  String get labelLocation => '位置';

  @override
  String get exampleLocation => '例如：庭院';

  @override
  String get labelDayPlanted => '种植日期';

  @override
  String get saveButton => '保存';

  @override
  String get careAll => '养护所有植物吗？';

  @override
  String get careAllBody => '此操作会将所有植物标记为“本周期已养护”。';

  @override
  String get water => '浇水';

  @override
  String get spray => '喷水';

  @override
  String get rotate => '转向';

  @override
  String get prune => '修剪';

  @override
  String get fertilise => '施肥';

  @override
  String get transplant => '移植';

  @override
  String get clean => '清理';

  @override
  String get now => '现在';

  @override
  String get daysLeft => '天到期';

  @override
  String get daysLate => '从';

  @override
  String get tooltipEdit => '编辑此植物';

  @override
  String get deleteButton => '删除';

  @override
  String get noCaresError => '请至少选择一种养护项目';

  @override
  String get careButton => '养护';

  @override
  String get selectHours => '选择小时';

  @override
  String get notifyEvery => '提醒，每';

  @override
  String get hours => '小时';

  @override
  String get testNotificationButton => '测试提醒';

  @override
  String get testNotificationTitle => 'Florae测试提醒';

  @override
  String get testNotificationBody => '这是一条测试信息';

  @override
  String get aboutFloraeButton => '关于Florae';

  @override
  String get notificationInfo => '输入后，提醒时间将会重新开始计算。\n\n请注意，有些设备进行了非常激进的电池优化，可能会导致无法正确发出提醒。';

  @override
  String get careNotificationTitle => '植物需要养护';

  @override
  String get careNotificationName => '养护提醒';

  @override
  String get careNotificationDescription => '接收植物养护提醒';

  @override
  String get deletePlantTitle => '删除植物';

  @override
  String get deletePlantBody => '您将彻底删除此植物，此操作无法撤销。';

  @override
  String get exportData => 'Export garden';

  @override
  String get importData => 'Import garden';

  @override
  String get atDay => 'Daytime';

  @override
  String get atEvening => 'In the evening';

  @override
  String get atNight => 'At night';
}
