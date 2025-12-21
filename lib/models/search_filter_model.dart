class SearchFilter {
  final String governorate;
  final String city;
  final int minPrice;
  final int maxPrice;
  final String rooms;
  final String wifi;

  SearchFilter({
    required this.governorate,
    required this.city,
    required this.minPrice,
    required this.maxPrice,
    required this.rooms,
    required this.wifi,
  });
}
