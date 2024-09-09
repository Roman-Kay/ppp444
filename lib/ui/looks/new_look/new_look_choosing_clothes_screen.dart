import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppp444/data/hive.dart';
import 'package:ppp444/utils/colors.dart';
import 'package:ppp444/utils/modals.dart';
import 'package:ppp444/widgets/choose_categories_list.dart';
import 'package:ppp444/widgets/custom_app_bar.dart';
import 'package:ppp444/widgets/custom_grid_view.dart';
import 'package:ppp444/widgets/empty_widget.dart';
import 'package:ppp444/widgets/search.dart';
import 'package:ppp444/widgets/widget_button.dart';

class NewLookChoosingClothesScreen extends StatefulWidget {
  const NewLookChoosingClothesScreen({super.key});

  @override
  State<NewLookChoosingClothesScreen> createState() => _NewLookChoosingClothesScreentate();
}

class _NewLookChoosingClothesScreentate extends State<NewLookChoosingClothesScreen> {
  List<ClothesItem> choossenClothesItems = [];
  List? listOfFilteredClothesItems;
  final TextEditingController searchController = TextEditingController();

  void searchItems() {
    final text = searchController.text;
    if (text.isNotEmpty) {
      listOfFilteredClothesItems = boxClothes.values.toList().where((dynamic item) {
        return item.name.toLowerCase().contains(text.toLowerCase());
      }).toList();
    } else {
      listOfFilteredClothesItems = null;
    }
    setState(() {});
  }

  @override
  void initState() {
    searchItems();
    searchController.addListener(searchItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 25.h),
                  const CustomAppBar(
                    text: 'Back',
                    needArrow: true,
                    needPadding: true,
                  ),
                  boxClothes.isEmpty
                      ? EmptyWidget(
                          imageName: 'wardrobe_empty',
                          text: 'Wardrobe is empty',
                          topPading: 70.h,
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
                                itemCount: boxClothes.length,
                                itemBuilder: (context, index) {
                                  ClothesItem clothesItem = boxClothes.getAt(index)!;
                                  // если категория не выбрана или наш категория элемента совпдает с ней показываем его
                                  // далее проверка на находится ли элемент в списке отсартированных поиско элементов (если поиск был)
                                  if ((choosenCategory == '' ||
                                          clothesItem.category == choosenCategory) &&
                                      (listOfFilteredClothesItems == null ||
                                          listOfFilteredClothesItems!
                                              .any((element) => clothesItem == element))) {
                                    return CustomGridViewElement(
                                      clothesItem: clothesItem,
                                      isChoosen: choossenClothesItems.any(
                                        (element) => element == clothesItem,
                                      ),
                                      onPressed: () {
                                        setState(
                                          () {
                                            choossenClothesItems
                                                    .any((element) => element == clothesItem)
                                                ? choossenClothesItems.remove(clothesItem)
                                                : choossenClothesItems.add(clothesItem);
                                          },
                                        );
                                      },
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                ],
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: choossenClothesItems.isEmpty ? 0 : 1,
                child: SafeArea(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 12.w,
                        right: 12.w,
                        bottom: MediaQuery.of(context).padding.bottom >= 10 ? 10.h : 20.h,
                      ),
                      child: Button(
                        text: 'Confirm',
                        boxShadow: true,
                        onPressed: () => Navigator.pop(context, choossenClothesItems),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
