import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('nl'),
    Locale('pl'),
    Locale('ru'),
    Locale('zh')
  ];

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @mainNoCares.
  ///
  /// In en, this message translates to:
  /// **'Yay! You don\'t have any pending plants to care'**
  String get mainNoCares;

  /// No description provided for @mainNoPlants.
  ///
  /// In en, this message translates to:
  /// **'The garden is empty, shall we plant something?'**
  String get mainNoPlants;

  /// No description provided for @buttonGarden.
  ///
  /// In en, this message translates to:
  /// **'Garden'**
  String get buttonGarden;

  /// No description provided for @buttonToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get buttonToday;

  /// No description provided for @tooltipCareAll.
  ///
  /// In en, this message translates to:
  /// **'Apply care to all plants'**
  String get tooltipCareAll;

  /// No description provided for @tooltipShowCalendar.
  ///
  /// In en, this message translates to:
  /// **'Show Calendar'**
  String get tooltipShowCalendar;

  /// No description provided for @tooltipSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get tooltipSettings;

  /// No description provided for @tooltipNewPlant.
  ///
  /// In en, this message translates to:
  /// **'Add new plant'**
  String get tooltipNewPlant;

  /// No description provided for @selectDays.
  ///
  /// In en, this message translates to:
  /// **'Select days'**
  String get selectDays;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @every.
  ///
  /// In en, this message translates to:
  /// **'every'**
  String get every;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// No description provided for @never.
  ///
  /// In en, this message translates to:
  /// **'Never'**
  String get never;

  /// No description provided for @titleEditPlant.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get titleEditPlant;

  /// No description provided for @titleNewPlant.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get titleNewPlant;

  /// No description provided for @tooltipCameraImage.
  ///
  /// In en, this message translates to:
  /// **'Get image from camera'**
  String get tooltipCameraImage;

  /// No description provided for @tooltipNextAvatar.
  ///
  /// In en, this message translates to:
  /// **'Next avatar'**
  String get tooltipNextAvatar;

  /// No description provided for @tooltipGalleryImage.
  ///
  /// In en, this message translates to:
  /// **'Get image from gallery'**
  String get tooltipGalleryImage;

  /// No description provided for @emptyError.
  ///
  /// In en, this message translates to:
  /// **'Please enter some text'**
  String get emptyError;

  /// No description provided for @conflictError.
  ///
  /// In en, this message translates to:
  /// **'Plant name already exists'**
  String get conflictError;

  /// No description provided for @labelName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get labelName;

  /// No description provided for @exampleName.
  ///
  /// In en, this message translates to:
  /// **'Ex: Pilea'**
  String get exampleName;

  /// No description provided for @labelDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get labelDescription;

  /// No description provided for @labelLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get labelLocation;

  /// No description provided for @exampleLocation.
  ///
  /// In en, this message translates to:
  /// **'Ex: Courtyard'**
  String get exampleLocation;

  /// No description provided for @labelDayPlanted.
  ///
  /// In en, this message translates to:
  /// **'Day planted'**
  String get labelDayPlanted;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @careAll.
  ///
  /// In en, this message translates to:
  /// **'Have you taken care of all the plants?'**
  String get careAll;

  /// No description provided for @careAllBody.
  ///
  /// In en, this message translates to:
  /// **'This action will mark all plants as cared for today cycle.'**
  String get careAllBody;

  /// No description provided for @water.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get water;

  /// No description provided for @spray.
  ///
  /// In en, this message translates to:
  /// **'Spray'**
  String get spray;

  /// No description provided for @rotate.
  ///
  /// In en, this message translates to:
  /// **'Rotate'**
  String get rotate;

  /// No description provided for @prune.
  ///
  /// In en, this message translates to:
  /// **'Prune'**
  String get prune;

  /// No description provided for @fertilise.
  ///
  /// In en, this message translates to:
  /// **'Fertilise'**
  String get fertilise;

  /// No description provided for @transplant.
  ///
  /// In en, this message translates to:
  /// **'Transplant'**
  String get transplant;

  /// No description provided for @clean.
  ///
  /// In en, this message translates to:
  /// **'Clean'**
  String get clean;

  /// No description provided for @now.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get now;

  /// No description provided for @daysLeft.
  ///
  /// In en, this message translates to:
  /// **'days left'**
  String get daysLeft;

  /// No description provided for @daysLate.
  ///
  /// In en, this message translates to:
  /// **'Since'**
  String get daysLate;

  /// No description provided for @tooltipEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit this plant'**
  String get tooltipEdit;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @noCaresError.
  ///
  /// In en, this message translates to:
  /// **'Select at least one care'**
  String get noCaresError;

  /// No description provided for @careButton.
  ///
  /// In en, this message translates to:
  /// **'Care'**
  String get careButton;

  /// No description provided for @selectHours.
  ///
  /// In en, this message translates to:
  /// **'Select hours'**
  String get selectHours;

  /// No description provided for @notifyEvery.
  ///
  /// In en, this message translates to:
  /// **'Notify every'**
  String get notifyEvery;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get hours;

  /// No description provided for @testNotificationButton.
  ///
  /// In en, this message translates to:
  /// **'Test notification'**
  String get testNotificationButton;

  /// No description provided for @testNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Florae Test Notification'**
  String get testNotificationTitle;

  /// No description provided for @testNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'This is a test message'**
  String get testNotificationBody;

  /// No description provided for @aboutFloraeButton.
  ///
  /// In en, this message translates to:
  /// **'About Florae'**
  String get aboutFloraeButton;

  /// No description provided for @notificationInfo.
  ///
  /// In en, this message translates to:
  /// **'The notification time will be reset when you enter the App.\n\nPlease note that some devices perform very aggressive battery optimizations that may cause notifications to not be issued correctly.'**
  String get notificationInfo;

  /// No description provided for @careNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Plants require care'**
  String get careNotificationTitle;

  /// No description provided for @careNotificationName.
  ///
  /// In en, this message translates to:
  /// **'Care reminder'**
  String get careNotificationName;

  /// No description provided for @careNotificationDescription.
  ///
  /// In en, this message translates to:
  /// **'Receive plants care notifications'**
  String get careNotificationDescription;

  /// No description provided for @deletePlantTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete plant'**
  String get deletePlantTitle;

  /// No description provided for @deletePlantBody.
  ///
  /// In en, this message translates to:
  /// **'You are going to proceed to eliminate your plant definitively, this action cannot be undone.'**
  String get deletePlantBody;

  /// No description provided for @exportData.
  ///
  /// In en, this message translates to:
  /// **'Export garden'**
  String get exportData;

  /// No description provided for @importData.
  ///
  /// In en, this message translates to:
  /// **'Import garden'**
  String get importData;

  /// No description provided for @unsuccessfullyRestore.
  ///
  /// In en, this message translates to:
  /// **'Unable to restore the backup.'**
  String get unsuccessfullyRestore;

  /// No description provided for @unsuccessfullyBackup.
  ///
  /// In en, this message translates to:
  /// **'Unable to create a backup file.'**
  String get unsuccessfullyBackup;

  /// No description provided for @atDay.
  ///
  /// In en, this message translates to:
  /// **'Daytime'**
  String get atDay;

  /// No description provided for @atNoon.
  ///
  /// In en, this message translates to:
  /// **'At noon'**
  String get atNoon;

  /// No description provided for @atNight.
  ///
  /// In en, this message translates to:
  /// **'At night'**
  String get atNight;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'de',
        'en',
        'es',
        'fr',
        'it',
        'nl',
        'pl',
        'ru',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
