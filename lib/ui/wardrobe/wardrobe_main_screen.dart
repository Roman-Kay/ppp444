import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/data/hive.dart';
import 'package:ppp444/ui/wardrobe/new_clothes/new_clothes_main_screen.dart';
import 'package:ppp444/ui/wardrobe/wardrobe_clothes_card_screen.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/widgets/choose_categories_list.dart';
import 'package:ppp444/widgets/custom_app_bar.dart';
import 'package:ppp444/widgets/custom_grid_view.dart';
import 'package:ppp444/widgets/empty_widget.dart';
import 'package:ppp444/widgets/search.dart';

class WardrobeMainScreen extends StatefulWidget {
  const WardrobeMainScreen({super.key});

  @override
  State<WardrobeMainScreen> createState() => _WardrobeMainScreenState();
}

class _WardrobeMainScreenState extends State<WardrobeMainScreen> {
  TextEditingController searchController = TextEditingController();
  List listFilteredClothesItems = box.get('listOfClothesItems') ?? [];
  late List listOfAllClothesItems;
  late List listOfFilteredClothesItems;

  void searchItems() {
    final text = searchController.text;
    if (text.isNotEmpty) {
      listOfFilteredClothesItems = listOfAllClothesItems.where((dynamic item) {
        return item.name.toLowerCase().contains(text.toLowerCase());
      }).toList();
    } else {
      listOfFilteredClothesItems = listOfAllClothesItems;
    }
    setState(() {});
  }

  @override
  void initState() {
    listOfAllClothesItems = box.get('listOfClothesItems') ?? [];
    searchItems();
    searchController.addListener(searchItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppColors.backgroundGradient,
      ),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 25.h),
            CustomAppBar(
              needPadding: true,
              text: 'Wardrobe',
              textAddButton: 'Add Clothes',
              onPressedAddButton: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewClothesMainScreen(),
                  ),
                );
                setState(() {
                  listOfAllClothesItems = box.get('listOfClothesItems') ?? [];
                  searchItems();
                });
              },
            ),
            listOfAllClothesItems.isEmpty
                ? EmptyWidget(
                    topPading: 70.h,
                    imageName: 'wardrobe_empty',
                    text: 'Wardrobe is empty',
                  )
                : Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: 30.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Search(searchController: searchController),
                        ),
                        ChooseCategoriesList(
                          // передаем setState чтобы наш экран пересобрался и обновился
                          setState: () => setState(() {}),
                        ),
                        SizedBox(height: 15.h),
                        CustomGreedView(
                          listOfItems: listOfFilteredClothesItems,
                          itemBuilder: (context, index) {
                            ClothesItem clothesItem = listOfFilteredClothesItems[index];
                            return // если не выбрана катеория то просто показываем наш элемент
                                choosenCategory == '' ||
                                        // если выбрана категория и она сопдает с категорией элемента
                                        // то тоже показываем его
                                        clothesItem.category.name.split(', ').first ==
                                            choosenCategory
                                    ? CustomGridViewElement(
                                        clothesItem: clothesItem,
                                        onPressed: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => WardrobeClothesCardScreen(
                                                clothesItem: clothesItem,
                                              ),
                                            ),
                                          );
                                          // чтобы обновился лист фото
                                          setState(() {});
                                        },
                                      )
                                    : const SizedBox();
                          },
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
