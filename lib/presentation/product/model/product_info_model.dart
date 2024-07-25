class ProductInfo {
  final String key;
  final String value;

  ProductInfo({
    required this.key,
    required this.value,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    return ProductInfo(
      key: json['key'].toString(),
      value: json['value'],
    );
  }
}

// {"key": "Age", "value": "Age"},