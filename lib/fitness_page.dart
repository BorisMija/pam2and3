import 'package:flutter/material.dart';

import 'models/fitness_data.dart';

class FitnessPage extends StatelessWidget {
  final Gym gym;
  const FitnessPage({super.key, required this.gym});

  static const green = Color(0xFF20C765);

  // Iconițe pentru facilități, după id-ul din JSON
  static const _amenityIcons = <String, IconData>{
    'showers': Icons.shower_outlined,
    'lockers': Icons.inventory_2_outlined,
    'parking': Icons.local_parking_outlined,
    'wifi': Icons.wifi,
  };

  String _formatNumber(int n) => n.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
        (_) => ',',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // POZA MARE CU STATUS BAR PESTE EA
                  SizedBox(
                    height: 315,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        // IMAGINEA (din JSON)
                        Positioned.fill(
                          child: Image.network(
                            gym.heroImageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                Container(color: const Color(0xFFDDDDDD)),
                          ),
                        ),

                        // STATUS BAR - PESTE IMAGINE (ALB)
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 12,
                              left: 24,
                              right: 24,
                              bottom: 8,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '9:41',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 18,
                                      height: 12,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Container(width: 3, height: 4, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(1))),
                                          const SizedBox(width: 1.5),
                                          Container(width: 3, height: 6, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(1))),
                                          const SizedBox(width: 1.5),
                                          Container(width: 3, height: 9, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(1))),
                                          const SizedBox(width: 1.5),
                                          Container(width: 3, height: 12, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(1))),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    const Icon(Icons.wifi,
                                        size: 16, color: Colors.white),
                                    const SizedBox(width: 6),
                                    Row(
                                      children: [
                                        Container(
                                          width: 22,
                                          height: 11,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white, width: 1),
                                            borderRadius:
                                            BorderRadius.circular(3),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 8,
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(2),
                                                      bottomLeft:
                                                      Radius.circular(2),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Expanded(
                                                  flex: 2, child: SizedBox()),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 2,
                                          height: 5,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        // BUTON BACK
                        Positioned(
                          top: 35,
                          left: 16,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 43,
                              height: 43,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.55),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        // BUTON MORE
                        const Positioned(
                          top: 35,
                          right: 17,
                          child: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 20, 22, 130),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // RATING
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Color(0xFFFFB52E),
                              size: 17,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${gym.rating}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(${_formatNumber(gym.reviewCount)} reviews)',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 11),

                        Text(
                          gym.name,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 9),

                        Text(
                          gym.location,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: 15),

                        Container(
                          height: 1,
                          color: const Color(0xFFE5E5E5),
                        ),

                        const SizedBox(height: 18),

                        Text(
                          gym.description,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 13,
                            height: 1.55,
                          ),
                        ),

                        const SizedBox(height: 2),

                        const Text(
                          'Read more',
                          style: TextStyle(
                            color: green,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          'Amenities',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 14),

                        ..._amenityRows(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // BOTTOM BAR
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(22, 15, 22, 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                  '\$${gym.priceAmount.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: ' /${gym.pricePeriod}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF8D8D95),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 140,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Rezervat: ${gym.name}'),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: green,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          gym.reserveLabel,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Facilitățile (din JSON), câte două pe rând
  List<Widget> _amenityRows() {
    final rows = <Widget>[];
    final items = gym.amenities;

    for (var i = 0; i < items.length; i += 2) {
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 11),
          child: Row(
            children: [
              Expanded(child: _amenity(items[i])),
              const SizedBox(width: 13),
              Expanded(
                child: i + 1 < items.length
                    ? _amenity(items[i + 1])
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      );
    }
    return rows;
  }

  Widget _amenity(Amenity a) {
    final icon = _amenityIcons[a.id] ?? Icons.check_circle_outline;

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE1E1E5),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 13),
          Icon(
            icon,
            size: 20,
            color: const Color(0xFF8B8B94),
          ),
          const SizedBox(width: 9),
          Text(
            a.name,
            style: const TextStyle(
              color: Color(0xFF85858E),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}