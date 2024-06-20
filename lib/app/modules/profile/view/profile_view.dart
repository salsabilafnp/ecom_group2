import 'package:ecom_group2/app/components/custom_appbar.dart';
import 'package:ecom_group2/app/modules/profile/view/edit_profile.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Profile',
        appBarType: AppBarType.profile,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                      'assets/human.jpeg'), // Replace with actual image
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Column(
                  children: [
                    const Text(
                      'Jhon Doe',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'John@gmail.com',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileScreen()),
                        );
                      },
                      child: Text('Edit Profile'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Saldo & Points',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildBalanceCard(
                    'assets/gopay.png', // Replace with actual image
                    'Rp. 3000',
                  ),
                  _buildBalanceCard(
                    'assets/credit_card.jpeg', // Replace with actual image
                    'Daftar sekarang',
                  ),
                  _buildBalanceCard(
                    'assets/money_bill.jpeg', // Replace with actual image
                    'Rp. 0',
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Daftar Transaksi',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildListItem(Icons.list_alt_rounded, 'Daftar Transaksi'),
              _buildListItem(Icons.star, 'Ulasan'),
              _buildListItem(Icons.favorite, 'Wishlist'),
              _buildListItem(Icons.storefront, 'Toko yang di follow'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard(String assetImagePath, String title) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey[300]!,
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            assetImagePath,
            width: 80,
            height: 60,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
    );
  }
}
