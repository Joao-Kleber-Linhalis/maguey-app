extension CapitalizeInitials on String {
  String capitalizeFirstLetter() {
    String initial = this[0];

    return initial.toUpperCase() + substring(1).toLowerCase();
  }

  String capitalizeInitials() {
    List<String> words = split(" ");
    List<String> capitals = [];
    for (String word in words) {
      if (word.isEmpty) {
        capitals.add(word);
      } else {
        capitals.add(word[0].toUpperCase() + word.substring(1));
      }
    }
    return capitals.join(" ");
  }
}

extension SubStrIfExists on String {
  String subStrIfExists(int start, [int? end]) {
    if (start < 0) throw "start pointer cannot be negative";
    if (end == null || end > length) return substring(start);

    return substring(start, end);
  }
}

extension ValidateFields on String {
  bool isAValidEmail() {
    // Regex pattern for Gmail addresses
    final RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail.com$');
    return regex.hasMatch(this);
  }

  bool containsMinChars({int minLength = 8}) {
    return length >= minLength;
  }

  bool containsMinSpecialChars({int min = 1}) {
    List<String> allSpecialCharacters = getAllSpecialCharaceters.split("");
    int totalSpecialCharacters = containsCountOf(map: allSpecialCharacters);

    return totalSpecialCharacters >= min;
  }

  bool containsMinNumbers({int min = 1}) {
    List<String> allNumbers = getAllNumbers.split("");
    int totalNumbers = containsCountOf(map: allNumbers);

    return totalNumbers >= min;
  }

  bool containsUpperCase({int min = 1}) {
    List<String> allAlphabets = alphabets.toUpperCase().split("");
    int totalAlphabets = containsCountOf(map: allAlphabets);

    return totalAlphabets >= min;
  }

  int containsCountOf({required List<String> map}) {
    int count = 0;
    List<String> val = split("");
    for (String data in val) {
      if (map.contains(data)) {
        count++;
      }
    }

    return count;
  }

  String get getAllSpecialCharaceters => "~`!@#\$%^&*()_+-={}[]\\|;:\"'<,>.?/";
  String get getAllNumbers => "0123456789";
  String get getAllAlphabets => "$alphabets${alphabets.toUpperCase()}";
  String get alphabets => "qwertyuiopasdfghjklzxcvbnm";
}
