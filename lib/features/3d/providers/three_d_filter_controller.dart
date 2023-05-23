import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/three_d.dart';


final filterListController =
    Provider.family<List<ThreeD>, List<ThreeD>>((ref, list) {
  final sortType = ref.watch(threeDListSortTypeProvider);

  switch (sortType) {
    case '0-99':
      return getFilterList(0, 99, list);
    case '100-199':
      return getFilterList(100, 199, list);
    case '200-299':
      return getFilterList(200, 299, list);
    case '300-399':
      return getFilterList(300, 399, list);
    case '400-499':
      return getFilterList(400, 499, list);
    case '500-599':
      return getFilterList(500, 599, list);
    case '600-699':
      return getFilterList(600, 699, list);
    case '700-799':
      return getFilterList(700, 799, list);
    case '800-899':
      return getFilterList(800, 899, list);
    case '900-999':
      return getFilterList(900, 999, list);
    default:
      return getFilterList(0, 99, list);
  }
});

List<ThreeD> getFilterList(int start, int end, List<ThreeD> list) {
  List<ThreeD> result = [];
  for (int i = start; i <= end; i++) {
    result.add(list[i]);
  }
  return result;
}

final threeDListSortTypeProvider = StateProvider<String>(
  // We return the default sort type, here name.
  (ref) => items[0],
);

var items = [
  '0-99',
  '100-199',
  '200-299',
  '300-399',
  '400-499',
  '500-599',
  '600-699',
  '700-799',
  '800-899',
  '900-999',
];
