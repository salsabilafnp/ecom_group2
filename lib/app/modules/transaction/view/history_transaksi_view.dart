import 'package:ecom_group2/app/components/custom_appbar.dart';
import 'package:ecom_group2/app/modules/transaction/controller/history_transaksi_controller.dart';
import 'package:flutter/material.dart';

class HistoryTransaksiView extends StatefulWidget {
  final HistoryTransaksiController? controller;
  const HistoryTransaksiView({super.key, this.controller});

  @override
  State<HistoryTransaksiView> createState() => _HistoryTransaksiViewState();
}

class _HistoryTransaksiViewState extends State<HistoryTransaksiView> {
  late HistoryTransaksiController _controller;
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? HistoryTransaksiController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Transaction History',
        appBarType: AppBarType.transaction,
        onFavoritePressed: () {},
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(color: Color(0xffD9D9D9)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () => _onItemTapped(0),
                        child: _selectedIndex == 0
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 6),
                                decoration: BoxDecoration(
                                    color: const Color(0xffD9D9D9),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(1),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]),
                                child: const Text(
                                  "Dikirim",
                                  style: TextStyle(color: Color(0xffD60A0A)),
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.all(8),
                                child: const Text("Dikirim"),
                              )),
                    GestureDetector(
                        onTap: () => _onItemTapped(1),
                        child: _selectedIndex == 1
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 6),
                                decoration: BoxDecoration(
                                    color: const Color(0xffD9D9D9),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(1),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]),
                                child: const Text("Selesai",
                                    style: TextStyle(color: Color(0xffD60A0A))),
                              )
                            : Container(
                                padding: const EdgeInsets.all(8),
                                child: const Text("Selesai"),
                              )),
                    GestureDetector(
                        onTap: () => _onItemTapped(3),
                        child: _selectedIndex == 3
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 6),
                                decoration: BoxDecoration(
                                    color: const Color(0xffD9D9D9),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(1),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]),
                                child: const Text("Dibatalkan",
                                    style: TextStyle(color: Color(0xffD60A0A))),
                              )
                            : Container(
                                padding: const EdgeInsets.all(8),
                                child: const Text("Dibatalkan"),
                              )),
                    GestureDetector(
                        onTap: () => _onItemTapped(4),
                        child: _selectedIndex == 4
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 6),
                                decoration: BoxDecoration(
                                    color: const Color(0xffD9D9D9),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(1),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]),
                                child: const Text("Pengembalian",
                                    style: TextStyle(color: Color(0xffD60A0A))),
                              )
                            : Container(
                                padding: const EdgeInsets.all(8),
                                child: const Text("Pengembalian"),
                              )),
                  ],
                ),
              ),
              _bodyList()
            ],
          ),
        ),
      ),
    );
  }

  Container _bodyList() {
    switch (_selectedIndex) {
      case 0:
        return Container(
            padding: const EdgeInsets.all(10),
            child: const Text("Tidak Ada Produk"));
      case 1:
        return Container(
          child: FutureBuilder(
              future: _controller.fetchProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _controller.products.length,
                    itemBuilder: (context, index) {
                      final item = _controller.products[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          color:
                                              Color.fromARGB(139, 64, 64, 64),
                                        ),
                                        child: Image.network(
                                          item.image,
                                          width: 150,
                                          height: 200,
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.share_outlined,
                                            color: Colors.black,
                                            size: 20,
                                          )),
                                      Positioned(
                                        top: 12,
                                        right: 25,
                                        child: Icon(
                                          _controller.isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_outline,
                                          size: 20,
                                          color: _controller.isFavorite
                                              ? Colors.red
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          item.title,
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("01 coklat (31c)"),
                                        ),
                                        const SizedBox(height: 40),
                                        const Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text("x1"),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text("\$${item.price}"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(179, 217, 217, 217)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("1 Produk"),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Text("Total Pesanan"),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text("\$${item.price}"),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.network(
                                    "https://i.imgur.com/4VuBbRw.png"),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Pesanan telah sampai diterima oleh yang bersangkutan",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: const Icon(Icons.chevron_right),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                          Color(0xff12327B)),
                                      shape: WidgetStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))))),
                                  onPressed: () {},
                                  child: const Text(
                                    "Beli lagi",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      );
                    },
                  );
                }
              }),
        );
      case 2:
        return Container(
            padding: const EdgeInsets.all(10),
            child: const Text("Tidak Ada Produk"));
      default:
        return Container(
            padding: const EdgeInsets.all(10),
            child: const Text("Tidak Ada Produk"));
    }
  }
}
