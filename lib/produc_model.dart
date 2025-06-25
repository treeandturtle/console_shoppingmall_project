import 'dart:io';

class ShoppingMall {
  List<Product> items = [];
  List<Consumer> kings = [];
  List<String> guni = [];
  int totalPrice = 0;

  showProducts() {
    for (Product i in items) {
      print('${i.item}/ ${i.price}원');
    }
  }

  showReview() {
    for (Consumer i in kings) {
      print('${i.person}: ${i.item}의 구매후기! -> ${i.review}');
    }
  }

  addToCart(String item, int num) {
    try {
      print('입력받은 item: "$item"');
      print('현재 상품 목록: ${items.map((e) => e.item).toList()}');
      if (items.any((i) => i.item == item)) {
        if (num > 0) {
          Product temproduct = items.firstWhere((e) => e.item == item);
          guni.add(item);

          totalPrice = totalPrice + num * temproduct.price;
        } else {
          throw Exception();
        }
      } else {
        throw FormatException();
      }
    } on FormatException {
      print('입력값이 올바르지 않아요!');
    } on Exception {
      print('0개보다 많은 개수의 상품만 담을 수 있어요 !');
    }
  }

  review(Consumer king) {
    kings.add(king);
    print('리뷰를 업로드하시겠습니까?');
    print('확인은 1, 취소는 2');
    String? check = stdin.readLineSync();
    if (check == '1') {
      try {
        if ([king.person, king.item, king.review].every((e) => e.isNotEmpty)) {
        } else {
          kings.clear();
          throw Exception();
        }
      } on Exception {
        print('빈 입력이 있네요~!');
      }
    } else {
      kings.clear();
    }
  }
}

class Product {
  String item;
  int price;

  Product(this.item, this.price);
}

class Consumer {
  String person;
  String item;
  String review;
  Consumer(this.person, this.item, this.review);
}
