import 'package:console_shoppingmall/produc_model.dart';
import 'dart:io';

void main() {
  String? key = ''; // 사용자 입력 메뉴 선택 키
  String? pass = '6852'; // 관리자 모드 비밀번호
  String? stop = ''; // 종료 변수

  ShoppingMall shop = ShoppingMall(); // 쇼핑몰 인스턴스 생성

  shop.items = [
    Product('shirts', 45000),
    Product('pants', 30000),
    Product('outerwear', 35000),
    Product('tops', 38000),
    Product('shoes', 5000),
  ]; // 기본 상품 목록 초기화

  // 사용자 입력을 받아 기능 실행 반복
  while (stop != '5') {
    showMenu();
    shop.showReview();
    key = stdin.readLineSync();
    // 선택한 메뉴에 따라 기능 분기
    switch (key) {
      case '1': // 상품 목록 보기
        {
          shop.showProducts();
          break;
        }
      case '2': // 장바구니 담기
        {
          print('상품 이름을 입력해 주세요!');
          String? item = stdin.readLineSync();
          print('상품 개수를 입력해 주세요!');
          try {
            int num = int.parse(stdin.readLineSync() ?? '');
            shop.addToCart(item!, num);
          } catch (e) {
            print('입력값이 올바르지 않아요!');
          }
          break;
        }
      case '3': // 장바구니 목록 및 총 금액 출력
        {
          if (shop.guni.isEmpty) {
            print('장바구니에 담긴 상품이 업습빈다.');
          } else {
            print(
              '장박구니에 ${shop.guni.join(',')}가 담겨있네요. 총 ${shop.totalPrice}원 어치를 담으셨네요!',
            );
          }
          break;
        }

      case '4': // 프로그램 종료 확인
        {
          print('정말 종료하시겠습니까?');
          stop = stdin.readLineSync();
          if (stop == '5') {
            print('이용해주셔서 감사합니다!');
          } else {
            print('종료하지 않습니다');
          }
          break;
        }
      case '6': // 장바구니 초기화
        {
          {
            if (shop.guni.isEmpty) {
              print('이미 장바구니가 비었습니다');
            } else {
              print('장바구니를 초기화합니다');
              shop.guni.clear();
              shop.totalPrice = 0;
            }
          }
          break;
        }
      case '7': // 리뷰 작성
        {
          print('이름을 작성해주세요');
          String? person = stdin.readLineSync();
          print('상품 이름을 작성해주세요');
          String? item = stdin.readLineSync();
          print('리뷰를 작성해주세요');
          String? review = stdin.readLineSync();
          Consumer king = Consumer(person!, item!, review!);
          shop.review(king);
          break;
        }

      case '8': // 관리자 모드 - 상품 추가
        {
          print('관리자 모드~ 비번을 입력하세요!');

          String? tempass = stdin.readLineSync();
          if (pass == tempass) {
            print('상품 이름을 입력해 주세요!');
            String? additem = stdin.readLineSync();
            print('가격을 입력해주세요!');
            int price = int.parse(stdin.readLineSync() ?? '');

            try {
              if (price < 0) {
                throw Exception();
              } else if (additem.runtimeType != String) {
                throw FormatException();
              } else {
                try {
                  shop.items.add(Product(additem!, price));
                } catch (e) {
                  print('입력값이 올바르지 않아요~!');
                }
              }
            } on FormatException {
              ('제품 이름이 올바르지 않아요~!');
            } on Exception {
              print('가격이 올바르지 않아요~!');
            }
          } else {
            print('비번이 틀렸네요~');
          }
        }
        break;
    }
  }
}

// 메뉴 출력 함수
void showMenu() {
  List<String> catalog = [
    '상품 목록 보기',
    '장바구니에 담기',
    '장바구니에 담긴 상품의 총 가격 보기',
    '프로그램 종료',
    '프로그램 종료 확인',
    '장바구니 초기화',
    '리뷰 작성',
    '관리자 모드',
  ];
  print('--------------------------------------------------------------------');

  for (int i = 0; i < catalog.length; i++) {
    stdout.write('[${i + 1}] ${catalog[i]}/ ');
  }
  print(
    '\n--------------------------------------------------------------------',
  );
}
