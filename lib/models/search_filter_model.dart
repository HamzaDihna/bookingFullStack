class SearchFilter {
  final String governorate;
  final String city;
  final int minPrice;
  final int maxPrice;
  final int? rooms;
  final bool? hasWifi;

  SearchFilter({
    required this.governorate,
    required this.city,
    required this.minPrice,
    required this.maxPrice,
    this.rooms,
    this.hasWifi,
  });
}
// SearchFilter filter = SearchFilter(...);
// api.searchApartments(filter);
// لا يوجد استخدام لهذا الملف حاليا