// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get no => 'Non';

  @override
  String get yes => 'Oui';

  @override
  String get mainNoCares =>
      'Youpi ! Vous n\'avez aucune plante en attente de soin';

  @override
  String get mainNoPlants =>
      'Le jardin est vide, pourquoi ne pas planter quelque chose ?';

  @override
  String get buttonGarden => 'Jardin';

  @override
  String get buttonToday => 'Aujourd\'hui';

  @override
  String get tooltipCareAll => 'Marquer toutes les plantes comme soignées';

  @override
  String get tooltipShowCalendar => 'Afficher le calendrier';

  @override
  String get tooltipSettings => 'Paramètres';

  @override
  String get tooltipNewPlant => 'Ajouter une plante';

  @override
  String get selectDays => 'Sélectionner les jours';

  @override
  String get ok => 'OK';

  @override
  String get every => 'tous les';

  @override
  String get days => 'jours';

  @override
  String get never => 'Jamais';

  @override
  String get titleEditPlant => 'Modifier';

  @override
  String get titleNewPlant => 'Nouveau';

  @override
  String get tooltipCameraImage => 'Prendre une photo';

  @override
  String get tooltipNextAvatar => 'Avatar suivant';

  @override
  String get tooltipGalleryImage => 'Sélectionner dans la galerie';

  @override
  String get emptyError => 'Ajouter du texte';

  @override
  String get conflictError => 'Nom de plante déjà utilisé';

  @override
  String get labelName => 'Nom';

  @override
  String get exampleName => 'Ex: Pilea';

  @override
  String get labelDescription => 'Description';

  @override
  String get labelLocation => 'Emplacement';

  @override
  String get exampleLocation => 'Ex: Cour';

  @override
  String get labelDayPlanted => 'Jour de plante';

  @override
  String get saveButton => 'Sauvegarder';

  @override
  String get careAll => 'Avez-vous pris soin de toutes vos plantes ?';

  @override
  String get careAllBody =>
      'Cette action marquera toutes vos plantes comme soignées pour aujourd\'hui';

  @override
  String get water => 'Arroser';

  @override
  String get spray => 'Pulvériser';

  @override
  String get rotate => 'Tourner';

  @override
  String get prune => 'Élaguer';

  @override
  String get fertilise => 'Fertiliser';

  @override
  String get transplant => 'Transplanter';

  @override
  String get clean => 'Nettoyer';

  @override
  String get now => 'Maintenant';

  @override
  String get daysLeft => 'jours restants';

  @override
  String get daysLate => 'Il y a';

  @override
  String get tooltipEdit => 'Modifier cette plante';

  @override
  String get deleteButton => 'Supprimer';

  @override
  String get noCaresError => 'Sélectionner au moins un soin';

  @override
  String get careButton => 'Soigner';

  @override
  String get selectHours => 'Sélectionner les heures';

  @override
  String get notifyEvery => 'Notifier toutes les';

  @override
  String get hours => 'heures';

  @override
  String get testNotificationButton => 'Tester les notifications';

  @override
  String get testNotificationTitle => 'Test de notification pour Florae';

  @override
  String get testNotificationBody => 'Ceci est un message test';

  @override
  String get aboutFloraeButton => 'À propos de Florae';

  @override
  String get notificationInfo =>
      'Le temps de notiification sera remis à zéro à l\'ouverture de l\'application.\n\nNotez que certains appareils sont programmés pour des optimisations de batterie aggressives, qui peuvent influencer le compprtement des notifications';

  @override
  String get careNotificationTitle => 'Vos plantes ont besoin de soin';

  @override
  String get careNotificationName => 'Rappel soins';

  @override
  String get careNotificationDescription =>
      'Recevoir des notifications pour le soin des plantes';

  @override
  String get deletePlantTitle => 'Supprimer plante';

  @override
  String get deletePlantBody =>
      'La suppression d\'une plante est définitive. Cette action est irréversible';

  @override
  String get exportData => 'Exporter des données';

  @override
  String get importData => 'Importer des données';

  @override
  String get unsuccessfullyRestore => 'Impossible de restaurer la sauvegarde.';

  @override
  String get unsuccessfullyBackup =>
      'Impossible de créer un fichier de sauvegarde.';

  @override
  String get atDay => 'De jour';

  @override
  String get atEvening => 'D\'après-midi';

  @override
  String get atNight => 'De nuit';
}
