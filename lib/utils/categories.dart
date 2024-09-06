import 'package:ppp444/utils/modals.dart';

abstract class Categories {
  static final List<CategoryItem> listOfCategoriesItems = [
    CategoryItem(
      name: 'Outerwear',
      subNames: [
        'Coat',
        'Jacket',
        'Cloak',
        'Down jacket',
        'Fur coat',
        'Vest',
      ],
    ),
    CategoryItem(
      name: 'Casual clothes',
      subNames: [
        'Dress',
        'T-shirt',
        'Sweatshirt',
        'Shirt',
        'Blouse',
      ],
    ),
    CategoryItem(
      name: 'Lower Clothing',
      subNames: [
        'Trousers',
        'Jeans',
        'Trousers',
        'Skirt',
        'Shorts',
      ],
    ),
    CategoryItem(
      name: 'Undergarments',
      subNames: [
        'Underpants',
        'Bra',
        'Undershirt',
      ],
    ),
    CategoryItem(
      name: 'Sports and fitness clothing',
      subNames: [
        'Sports suit',
        'Sweatpants',
        'Sports shorts',
        'Sports T-shirt',
        'Leggings',
        'Sweatshirt',
        'Sports headband',
      ],
    ),
    CategoryItem(
      name: 'Shoes',
      subNames: [
        'Sneakers',
        'Shoes',
        'Sandals',
        'Ballet shoes',
        'Boots',
        'Flip flops',
        'Sabo',
        'Sandals',
      ],
    ),
    CategoryItem(
      name: 'Evening dresses',
      subNames: [
        'Evening dress',
        'Costume',
        'Shirt',
        'Trousers',
      ],
    ),
    CategoryItem(
      name: 'Beachwear',
      subNames: [
        'Swimsuit',
        'Beach dress',
        'Sundress',
        'Swimming trunks',
      ],
    ),
    CategoryItem(
      name: 'Accessories',
      subNames: [
        'Bag',
        'Scarf',
        'Cap',
        'Hat',
        'Jewel',
      ],
    ),
  ];
}
