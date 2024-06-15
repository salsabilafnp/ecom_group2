import 'package:ecom_group2/flutter/packages/flutter_tools/lib/src/base/context.dart';
import 'package:flutter/material.dart';

class HistoryTransaksiView extends StatefulWidget {
  const HistoryTransaksiView({super.key});

  @override
  State<HistoryTransaksiView> createState() => _HistoryTransaksiViewState();
}

class _HistoryTransaksiViewState extends State<HistoryTransaksiView> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            title(context),
            TabBar(
              tabs: [
                Tab(text: 'Dikirim'),
                Tab(text: 'Selesai'),
                Tab(text: 'Dibatalkan'),
                Tab(text: 'Pengembalian'),
              ],
            ),
            TabBarView(
              children: [
                Center(child: Text('Dikirim')),
                Center(child: Text('Dibatalkan')),
                Center(child: Text('Pengembalian')),
              ],
            ),
          ],
        ),
      ),
    );
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
