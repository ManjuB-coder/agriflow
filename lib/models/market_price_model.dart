class MarketPriceModel {
  final String state;
  final String district;
  final String market;
  final String commodity;

  final String minPrice;
  final String maxPrice;
  final String modalPrice;

  final String arrivalDate;

  MarketPriceModel({
    required this.state,
    required this.district,
    required this.market,
    required this.commodity,
    required this.minPrice,
    required this.maxPrice,
    required this.modalPrice,
    required this.arrivalDate,
  });

  factory MarketPriceModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return MarketPriceModel(
      state: json["state"]?.toString() ?? "",
      district: json["district"]?.toString() ?? "",
      market: json["market"]?.toString() ?? "",
      commodity: json["commodity"]?.toString() ?? "",
      minPrice: json["min_price"]?.toString() ?? "0",
      maxPrice: json["max_price"]?.toString() ?? "0",
      modalPrice: json["modal_price"]?.toString() ?? "0",
      arrivalDate: json["arrival_date"]?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "state": state,
      "district": district,
      "market": market,
      "commodity": commodity,
      "min_price": minPrice,
      "max_price": maxPrice,
      "modal_price": modalPrice,
      "arrival_date": arrivalDate,
    };
  }
}
