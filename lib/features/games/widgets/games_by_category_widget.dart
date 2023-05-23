import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/enum.dart';
import '../../../core/widgets/custom_network_image.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../utils/app_color.dart';
import '../models/game_category_response.dart';
import '../providers/providers.dart';
import 'game_girdview.dart';


class GamesByCategoryWidget extends ConsumerStatefulWidget {
  final GameType gameType;

  const GamesByCategoryWidget({
    super.key,
    required this.gameType,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GamesByCategoryState();
}

class _GamesByCategoryState extends ConsumerState<GamesByCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    final categoryController =
        ref.watch(gameCategoryControllerProvider(widget.gameType));
    return categoryController.when(
      data: (category) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 65,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: AppColor.secondColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowIndicator();
                    return true;
                  },
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: category.length,
                    itemBuilder: (context, index) => CategoryTabImage(
                      category: category[index],
                      gameType: widget.gameType,
                      isIndexOne: index == 0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: category.isEmpty
                    ? Container()
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              controller: ref.watch(
                                searchTextEditingControllerProvider(
                                    widget.gameType),
                              ),
                              decoration: InputDecoration(
                                hintText: "Search game",
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor.accentColor),
                                  borderRadius: BorderRadius.circular(50),
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
                          Expanded(
                            child: GameGridViewWidget(
                              gameType: widget.gameType,
                            ),
                          ),
                        ],
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
    final bool isUnitedGaming = category.img == "storage/providers/UG.png";
    final bool isPG =
        category.img == "storage/providers/pg-soft-pg-soft-logo_1.png";
    return GestureDetector(
      onTap: () {
        ref.read(selectedCategoryNotifier(gameType).notifier).state =
            category.id;
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selectedCategoryId == category.id
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
              : KNetworkImage(
                  url: category.img!,
                  color: selectedCategoryId == category.id
                      ? AppColor.textColor
                      : null,
                ),
        ),
      ),
    );
  }
}
