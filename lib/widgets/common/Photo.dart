import 'dart:math';

String randomPhotoUrl() {
  final random = Random();
  // Sử dụng số ngẫu nhiên từ 1 đến 1000
  int x = random.nextInt(1000);
  return "https://picsum.photos/200?random=$x";
}
