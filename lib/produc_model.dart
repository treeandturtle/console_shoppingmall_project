import 'dart:io';

class ShoppingMall {
  List<Product> items = []; // 상품 목록
  List<Consumer> kings = []; // 등록된 리뷰들
  List<String> guni = []; // 장바구니에 담긴 상품 이름 목록
  int totalPrice = 0; // 장바구니에 담긴 총 가격

  // 상품 목록 출력
  showProducts() {
    for (Product i in items) {
      print('${i.item}/ ${i.price}원');
    }
  }

  // 리뷰 목록 출력
  showReview() {
    for (Consumer i in kings) {
      print('${i.person}: ${i.item}의 구매후기! -> ${i.review}');
    }
  }

  // 장바구니에 상품 추가
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

  // 리뷰 등록
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

// 상품 클래스
class Product {
  String item;
  int price;

  Product(this.item, this.price);
}

// 리뷰 작성자 클래스
class Consumer {
  String person;
  String item;
  String review;
  Consumer(this.person, this.item, this.review);
}
