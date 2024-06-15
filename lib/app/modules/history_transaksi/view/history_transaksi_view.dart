import 'package:ecom_group2/app/modules/history_transaksi/controller/history_transaksi_controller.dart';
import 'package:ecom_group2/flutter/packages/flutter_tools/lib/src/base/context.dart';
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              title(context),
              Container(
                color: const Color(0xffD9D9D9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTabItem('Dikirim', 0),
                    _buildTabItem('Selesai', 1),
                    _buildTabItem('Dibatalkan', 2),
                    _buildTabItem('Pengembalian', 3),
                  ],
                ),
              ),
              _getTabContent()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: isSelected
            ? const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20)
            : const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
            color: isSelected ? const Color(0xffD9D9D9) : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ]
                : []),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.red : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _getTabContent() {
    switch (_selectedIndex) {
      case 0:
        return ListView.builder(
            itemCount: _controller.products.length,
            itemBuilder: (BuildContext context, int index) {
              final item = _controller.products[index];
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                            child: Image.network(
                              item.image,
                              fit: BoxFit.fitHeight,
                              width: double.infinity,
                              height: 150,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _controller.isFavorite =
                                    !_controller.isFavorite;
                              });
                            },
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                _controller.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                size: 17,
                                color:
                                    _controller.isFavorite ? Colors.red : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });

      case 1:
        return Text("data");
      case 2:
        return Text("data");
      case 3:
        return Text("data");
      default:
        return Text("");
    }
  }

  Padding title(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.chevron_left),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("History Pesanan")
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_outlined),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_cart_outlined),
                ),
              ],
            ),
          ],
        ));
  }
}
