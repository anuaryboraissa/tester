class TesterApp {
  static List<Map<String, dynamic>> items = [
    {
      "id": 1,
      "name": "a",
      "numbers": [1, 2, 3, 4, 5]
    },
    {
      "id": 2,
      "name": "b",
      "numbers": [1, 2, 3, 4, 5]
    },
    {
      "id": 3,
      "name": "c",
      "numbers": [1, 2, 3, 4, 5]
    },
    {
      "id": 4,
      "name": "d",
      "numbers": [1, 2, 3, 4, 5]
    },
    {
      "id": 5,
      "name": "e",
      "numbers": [1, 2, 3, 4, 5]
    },
    {
      "id": 6,
      "name": "f",
      "numbers": [1, 2, 3, 4, 5]
    },
    {
      "id": 7,
      "name": "g",
      "numbers": [1, 2, 3, 4, 5]
    }
  ];

  static analyze() {
    double initial = 0.0;
    double initial2 = 0.0;

    for (int i = 0; i < items.length; i++) {
      initial = i / (items.length - 1);
      // double sub = 0;
      for (int b = 0; b < items[i]['numbers'].length; b++) {
        initial2 =
            ((b / (items[i]['numbers'].length - 1)) * i) / ((items.length - 1));
        if (initial2 >= initial) {
          initial = initial2;
        }
        print("sub $initial");
      }
      print(
          "progress $initial >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    }
  }
}
