import 'dart:math';

class Util {
  double ranking() {
    var rng = new Random();
    var rankings = new List.generate(10, (_) => rng.nextInt(10));
    return rankings.reduce((a, b) => a + b) / rankings.length;
  }
}
