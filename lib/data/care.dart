import 'package:json_annotation/json_annotation.dart';

part 'care.g.dart';

@JsonSerializable()
class Care {
  int id = 0;
  String name;
  int cycles = 0;
  DateTime? effected;

  Care(
      {required this.name,
      required this.cycles,
      required this.effected,
      required this.id});

  factory Care.fromJson(Map<String, dynamic> json) => _$CareFromJson(json);

  Map<String, dynamic> toJson() => _$CareToJson(this);

  int _daysBetween(DateTime date1, DateTime date2) {
    DateTime d1 = DateTime.utc(date1.year, date1.month, date1.day);
    DateTime d2 = DateTime.utc(date2.year, date2.month, date2.day);
    return (d1.difference(d2).inDays).abs();
  }

  int daysSinceLastCare(DateTime since){
    return _daysBetween(since, effected!);
  }

  bool isRequired(DateTime since, bool isPlanning) {
    var daysSinceLastCare = _daysBetween(since, effected!);

    if (isPlanning) {
      // If calendar day selected, add only the care that must be attended on a certain day.
      // Past care is assumed to have been correctly attended to in due time.
      return daysSinceLastCare != 0 && daysSinceLastCare % cycles == 0;
    }
      // Else, add all unattended care, current and past
    else {
      return daysSinceLastCare != 0 && daysSinceLastCare >= cycles;
    }
  }
}
