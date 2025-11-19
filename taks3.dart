import 'dart:convert';

void main() {
  String jsonString = '''
  {
    "animals": [
      { "animal": "dog,cat,dog,cow,monkey" },
      { "animal": "cow,cat,cat,lion" },
      { "animal": null },
      { "animal": "" }
    ]
  }
  ''';

  Map<String, dynamic> data = jsonDecode(jsonString);
  List<dynamic> animalsList = data['animals'];
  Map<String, int> overallCount = {};

  for (var obj in animalsList) {
    String? animalStr = obj['animal'];
    if (animalStr == null || animalStr.trim().isEmpty) continue;

    List<String> animals = animalStr.split(',');

    for (var animal in animals) {
      animal = animal.trim();
      if (animal.isEmpty) continue;
      overallCount[animal] = (overallCount[animal] ?? 0) + 1;
    }
  }

  List<String> output = [];
  overallCount.forEach((animal, count) {
    if (count > 1) {
      output.add('$animal($count)');
    } else {
      output.add(animal);
    }
  });

  print(output.join(', '));
}
