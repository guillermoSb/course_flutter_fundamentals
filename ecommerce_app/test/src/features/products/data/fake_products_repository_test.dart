import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FakeProductsRepository', () {
    final productsRepository = FakeProductsRepository(addDelay: false);
    test('getProductList returns global list.', () {
      expect(productsRepository.getProductsList(),
          kTestProducts); // Expect that the list returned by getProductsList() is equal to kTestProducts.
    });

    test('getProduct(1) shuld return the first item', () {
      expect(productsRepository.getProduct('1'), kTestProducts[0]);
    });

    test('getProduct(100) shuld return null', () {
      expect(productsRepository.getProduct('100'), null);
    });

    test('fetchProductsList returns global list.', () async {
      expect(await productsRepository.fetchProductsList(), kTestProducts);
    });

    test('whatchProductLists returns global list', () async {
      expect(productsRepository.watchProductsList(), emits(kTestProducts));
    });

    test('whatchProduct(1) emits first item', () {
      expect(productsRepository.watchProduct('1'), emits(kTestProducts[0]));
    });

    test('whatchProduct(100) emits null', () {
      expect(productsRepository.watchProduct('100'), emits(null));
    });
  });
}
