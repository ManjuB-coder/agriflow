import 'package:flutter/material.dart';

import '../services/market_price_service.dart';
import 'market_detail_screen.dart';

class CropMarketListScreen extends StatefulWidget {
  final String cropName;

  const CropMarketListScreen({
    super.key,
    required this.cropName,
  });

  @override
  State<CropMarketListScreen> createState() => _CropMarketListScreenState();
}

class _CropMarketListScreenState extends State<CropMarketListScreen> {
  List<dynamic> markets = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPrices();
  }

  Future<void> fetchPrices() async {
    try {
      final result = await MarketPriceService.getCropPrices(
        widget.cropName,
      );

      setState(() {
        markets = result;
        isLoading = false;
      });

      debugPrint(
        "Markets Found: ${result.length}",
      );
    } catch (e) {
      debugPrint(
        "Error: $e",
      );

      setState(() {
        isLoading = false;
      });
    }
  }

  Color trendColor(int index) {
    return index % 2 == 0 ? Colors.green : Colors.red;
  }

  String trendText(int index) {
    return index % 2 == 0 ? "▲ 2.3%" : "▼ 0.8%";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FAF4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5FAF4),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "${widget.cropName} Prices",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : markets.isEmpty
              ? const Center(
                  child: Text(
                    "No market prices found",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: markets.length,
                  itemBuilder: (context, index) {
                    final market = markets[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MarketDetailScreen(
                              marketData: {
                                "market": market.market,
                                "district": market.district,
                                "state": market.state,
                                "commodity": market.commodity,
                                "modal_price": market.modalPrice,
                                "min_price": market.minPrice,
                                "max_price": market.maxPrice,
                              },
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          bottom: 14,
                        ),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    market.market,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "${market.district}, ${market.state}",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "₹${market.modalPrice}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  trendText(index),
                                  style: TextStyle(
                                    color: trendColor(index),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
