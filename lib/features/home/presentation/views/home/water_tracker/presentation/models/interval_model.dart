class IntervalModel {
  final int minute;
  final bool selected;
  final String displayName;

  IntervalModel({
    required this.minute,
    this.selected = false,
    String? displayName,
  }) : displayName = displayName ?? '$minute min';

  Map<String, dynamic> toMap() {
    return {
      'minute': minute,
      'selected': selected ? 1 : 0,
      'displayName': displayName,
    };
  }

  factory IntervalModel.fromMap(Map<String, dynamic> map) {
    return IntervalModel(
      minute: map['minute'],
      selected: map['selected'] == 1,
      displayName: map['displayName'],
    );
  }
}
