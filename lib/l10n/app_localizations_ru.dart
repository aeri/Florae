// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get no => 'Нет';

  @override
  String get yes => 'Да';

  @override
  String get mainNoCares =>
      'Ура! У вас нет растений, за которыми нужно ухаживать';

  @override
  String get mainNoPlants => 'Сад пуст. Может, стоит что-нибудь посадить?';

  @override
  String get buttonGarden => 'Сад';

  @override
  String get buttonToday => 'Сегодня';

  @override
  String get tooltipCareAll => 'Отметить уход за всеми растениями';

  @override
  String get tooltipShowCalendar => 'Показать Календарь';

  @override
  String get tooltipSettings => 'Настройки';

  @override
  String get tooltipNewPlant => 'Добавить новое растение';

  @override
  String get selectDays => 'Выбрать дни';

  @override
  String get ok => 'ОК';

  @override
  String get every => 'каждые';

  @override
  String get days => 'дня (-ей)';

  @override
  String get never => 'Никогда';

  @override
  String get titleEditPlant => 'Изменить';

  @override
  String get titleNewPlant => 'Новое';

  @override
  String get tooltipCameraImage => 'Снять изображение на камеру';

  @override
  String get tooltipNextAvatar => 'Следующий аватар';

  @override
  String get tooltipGalleryImage => 'Выбрать изображение из галереи';

  @override
  String get emptyError => 'Пожалуйста, введите какой-нибудь текст';

  @override
  String get conflictError => 'Уже есть растение с таким именем';

  @override
  String get labelName => 'Имя';

  @override
  String get exampleName => 'Прим: Пилея';

  @override
  String get labelDescription => 'Описание';

  @override
  String get labelLocation => 'Место';

  @override
  String get exampleLocation => 'Прим: Двор';

  @override
  String get labelDayPlanted => 'День посадки';

  @override
  String get saveButton => 'Сохранить';

  @override
  String get careAll => 'Вы позаботились обо всех растениях?';

  @override
  String get careAllBody =>
      'Это отметит уход за всем растениями на сегодняшний день.';

  @override
  String get water => 'Полив';

  @override
  String get spray => 'Опрыскивание';

  @override
  String get rotate => 'Разворот';

  @override
  String get prune => 'Подрезка';

  @override
  String get fertilise => 'Удобрение';

  @override
  String get transplant => 'Пересадка';

  @override
  String get clean => 'Очистка';

  @override
  String get now => 'Сейчас';

  @override
  String get daysLeft => 'дней осталсь';

  @override
  String get daysLate => 'Начиная с';

  @override
  String get tooltipEdit => 'Изменить это растение';

  @override
  String get deleteButton => 'Удалить';

  @override
  String get noCaresError => 'Выберите хотя бы один уход';

  @override
  String get careButton => 'Уход';

  @override
  String get selectHours => 'Выбрать часы';

  @override
  String get notifyEvery => 'Напоминать каждые';

  @override
  String get hours => 'часа (-ов)';

  @override
  String get testNotificationButton => 'Тестовое уведомление';

  @override
  String get testNotificationTitle => 'Тестовое уведомление Florae';

  @override
  String get testNotificationBody => 'Это тестовое уведомление';

  @override
  String get aboutFloraeButton => 'О Florae';

  @override
  String get notificationInfo =>
      'Время уведомление будет сброшено, когда вы откроете Приложение.\n\nПожалуйста, имейте ввиду, что некоторые устройства могут вести очень агрессивную оптимизацию батареи. Эта оптимизация может вызывать проблемы с отображением уведомлений.';

  @override
  String get careNotificationTitle => 'Растениям нужен уход';

  @override
  String get careNotificationName => 'Напоминание об уходе';

  @override
  String get careNotificationDescription => 'Получать уведомление об уходе';

  @override
  String get deletePlantTitle => 'Удалить растение';

  @override
  String get deletePlantBody =>
      'Вы собираетесь полностью удалить своё растение. Это действие не может быть отменено.';

  @override
  String get exportData => 'Export garden';

  @override
  String get importData => 'Import garden';

  @override
  String get unsuccessfullyRestore => 'Unable to restore the backup.';

  @override
  String get unsuccessfullyBackup => 'Unable to create a backup file.';

  @override
  String get atDay => 'Daytime';

  @override
  String get atNoon => 'At noon';

  @override
  String get atNight => 'At night';
}
