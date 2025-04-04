// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get no => 'No';

  @override
  String get yes => 'Yes';

  @override
  String get mainNoCares => 'Yay! You don\'t have any pending plants to care';

  @override
  String get mainNoPlants => 'The garden is empty, shall we plant something?';

  @override
  String get buttonGarden => 'Garden';

  @override
  String get buttonToday => 'Today';

  @override
  String get tooltipCareAll => 'Apply care to all plants';

  @override
  String get tooltipShowCalendar => 'Show Calendar';

  @override
  String get tooltipSettings => 'Settings';

  @override
  String get tooltipNewPlant => 'Add new plant';

  @override
  String get selectDays => 'Select days';

  @override
  String get ok => 'OK';

  @override
  String get every => 'every';

  @override
  String get days => 'days';

  @override
  String get never => 'Never';

  @override
  String get titleEditPlant => 'Edit';

  @override
  String get titleNewPlant => 'New';

  @override
  String get tooltipCameraImage => 'Get image from camera';

  @override
  String get tooltipNextAvatar => 'Next avatar';

  @override
  String get tooltipGalleryImage => 'Get image from gallery';

  @override
  String get emptyError => 'Please enter some text';

  @override
  String get conflictError => 'Plant name already exists';

  @override
  String get labelName => 'Name';

  @override
  String get exampleName => 'Ex: Pilea';

  @override
  String get labelDescription => 'Description';

  @override
  String get labelLocation => 'Location';

  @override
  String get exampleLocation => 'Ex: Courtyard';

  @override
  String get labelDayPlanted => 'Day planted';

  @override
  String get saveButton => 'Save';

  @override
  String get careAll => 'Have you taken care of all the plants?';

  @override
  String get careAllBody => 'This action will mark all plants as cared for today cycle.';

  @override
  String get water => 'Water';

  @override
  String get spray => 'Spray';

  @override
  String get rotate => 'Rotate';

  @override
  String get prune => 'Prune';

  @override
  String get fertilise => 'Fertilise';

  @override
  String get transplant => 'Transplant';

  @override
  String get clean => 'Clean';

  @override
  String get now => 'Today';

  @override
  String get daysLeft => 'days left';

  @override
  String get daysLate => 'Since';

  @override
  String get tooltipEdit => 'Edit this plant';

  @override
  String get deleteButton => 'Delete';

  @override
  String get noCaresError => 'Select at least one care';

  @override
  String get careButton => 'Care';

  @override
  String get selectHours => 'Select hours';

  @override
  String get notifyEvery => 'Notify every';

  @override
  String get hours => 'hours';

  @override
  String get testNotificationButton => 'Test notification';

  @override
  String get testNotificationTitle => 'Florae Test Notification';

  @override
  String get testNotificationBody => 'This is a test message';

  @override
  String get aboutFloraeButton => 'About Florae';

  @override
  String get notificationInfo => 'The notification time will be reset when you enter the App.\n\nPlease note that some devices perform very aggressive battery optimizations that may cause notifications to not be issued correctly.';

  @override
  String get careNotificationTitle => 'Plants require care';

  @override
  String get careNotificationName => 'Care reminder';

  @override
  String get careNotificationDescription => 'Receive plants care notifications';

  @override
  String get deletePlantTitle => 'Delete plant';

  @override
  String get deletePlantBody => 'You are going to proceed to eliminate your plant definitively, this action cannot be undone.';
}
