import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enum.dart';
import '../../../core/widgets/custom_network_image.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../utils/app_color.dart';
import '../models/game_category_response.dart';
import '../providers/providers.dart';
import 'game_girdview.dart';

class GamesByCategoryDetailWidget extends ConsumerStatefulWidget {
  final GameType gameType;
  final String title;

  const GamesByCategoryDetailWidget({
    super.key,
    required this.title,
    required this.gameType,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GamesByCategoryState();
}

class _GamesByCategoryState extends ConsumerState<GamesByCategoryDetailWidget> {
  @override
  Widget build(BuildContext context) {
    final categoryController =
        ref.watch(gameCategoryControllerProvider(widget.gameType));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: categoryController.when(
        data: (category) {
          if (category.first.id != 0) {
            category.insert(
                0,
                GameCategory(
                    id: 0,
                    name: "All",
                    pCode: "",
                    img: "",
                    active: 1,
                    createdAt: "",
                    updatedAt: ""));
          }
          return category.isEmpty
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
                          onNotification:
                              (OverscrollIndicatorNotification overscroll) {
                            overscroll.disallowIndicator();
                            return true;
                          },
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            // shrinkWrap: true,
                            itemCount: category.length,
                            itemBuilder: (context, index) => CategoryTabImage(
                              category: category[index],
                              gameType: widget.gameType,
                              isIndexOne: index == 0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: TextField(
                          controller: ref.watch(
                            searchTextEditingControllerProvider(
                                widget.gameType),
                          ),
                          decoration: InputDecoration(
                            hintText: "Search game",
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 10,
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColor.accentColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.search_rounded),
                            suffixIcon: IconButton(
                              onPressed: () {
                                ref
                                    .read(
                                      searchTextEditingControllerProvider(
                                          widget.gameType),
                                    )
                                    .clear();
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Expanded(
                        child: GameGridViewWidget(
                          gameType: widget.gameType,
                        ),
                      ),
                    ],
                  ),
                );
        },
        error: (error, stackTrace) {
          return AppErrorWidget(
            error: error,
            onRetry: () {
              ref.refresh(gameCategoryControllerProvider(widget.gameType));
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class CategoryTabImage extends ConsumerWidget {
  final GameType gameType;
  final bool isIndexOne;
  final GameCategory category;

  const CategoryTabImage({
    super.key,
    required this.category,
    required this.gameType,
    this.isIndexOne = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategoryId = ref.watch(selectedCategoryNotifier(gameType));
    print("category id ${category.id}");
    print("selectedCategoryId ${selectedCategoryId}");
    final bool isUnitedGaming = category.img == "storage/providers/UG.png";
    final bool isPG =
        category.img == "storage/providers/pg-soft-pg-soft-logo_1.png";
    return GestureDetector(
      onTap: () {
        ref.read(selectedCategoryNotifier(gameType).notifier).state =
            category.id == 0 ? null : category.id;
      },
      child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          width: 80,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            //shape: BoxShape.circle,
            color: (selectedCategoryId??0) == category.id
                ? AppColor.accentColor
                : AppColor.textColor,
          ),
          child: FittedBox(
              child: isUnitedGaming || isPG
                  ? Text(
                      isPG ? "PG" : "UG",
                      style: TextStyle(
                        color: selectedCategoryId == category.id
                            ? Colors.black
                            : AppColor.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : category.img != ""
                      ? KNetworkImage(
                          url: category.img!,
                          color: selectedCategoryId == category.id
                              ? AppColor.textColor
                              : null,
                        )
                      : Text(
                          "All",
                          style: TextStyle(
                            color: selectedCategoryId == null
                                ? Colors.black
                                : AppColor.accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ))),
    );
  }
}
