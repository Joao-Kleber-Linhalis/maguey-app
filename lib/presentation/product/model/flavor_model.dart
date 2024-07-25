class FlavorModel {
  final String name;
  final int value;
  bool selected;

  FlavorModel({
    required this.name,
    required this.value,
    this.selected = false,
  });

  factory FlavorModel.fromJson(dynamic val) {
    return FlavorModel(
      // name: json['name'],
      // value: json['value'],
      name: val,
      value: 0,
    );
  }

  toggleSelection({bool? value}) {
    selected = value ?? !selected;
  }
}
