import 'package:flutter/material.dart';

class VIPMedicineOrdersView extends StatelessWidget {
  const VIPMedicineOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'VIP Medicine Orders',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VIPBenefitsCard(),
            const SizedBox(height: 20),
            const MedicineSearchBar(),
            const SizedBox(height: 20),
            const CategoryTabs(),
            const SizedBox(height: 20),
            const MedicineGrid(),
          ],
        ),
      ),
    );
  }
}

class VIPBenefitsCard extends StatelessWidget {
  const VIPBenefitsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2196F3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.star, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(
                'VIP Medicine Benefits',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              BenefitItem(
                icon: Icons.local_shipping,
                title: 'Free Delivery',
                subtitle: 'Within 2 hours',
              ),
              const SizedBox(width: 20),
              BenefitItem(
                icon: Icons.verified,
                title: 'Verified',
                subtitle: '100% Authentic',
              ),
              const SizedBox(width: 20),
              BenefitItem(
                icon: Icons.discount,
                title: 'Discounts',
                subtitle: 'Up to 25% off',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BenefitItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const BenefitItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: Colors.orange, size: 16),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class MedicineSearchBar extends StatelessWidget {
  const MedicineSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: const TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          hintText: 'Search medicines...',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class CategoryTabs extends StatelessWidget {
  const CategoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CategoryTab(text: 'All', isSelected: true),
          const SizedBox(width: 8),
          CategoryTab(text: 'Pain Relief', isSelected: false),
          const SizedBox(width: 8),
          CategoryTab(text: 'Antibiotics', isSelected: false),
          const SizedBox(width: 8),
          CategoryTab(text: 'Allergy', isSelected: false),
          const SizedBox(width: 8),
          CategoryTab(text: 'Digestive', isSelected: false),
        ],
      ),
    );
  }
}

class CategoryTab extends StatelessWidget {
  final String text;
  final bool isSelected;

  const CategoryTab({Key? key, required this.text, required this.isSelected})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF2196F3) : const Color(0xFF2A2A3E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class MedicineGrid extends StatelessWidget {
  const MedicineGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: .91,

      children: [
        MedicineCard(
          name: 'Paracetamol 500mg',
          brand: 'Panadol',
          price: '₹25.0',
          originalPrice: '₹30.0',
          discount: true,
        ),
        MedicineCard(
          name: 'Amoxicillin 250mg',
          brand: 'Cipla',
          price: '₹120.0',
          originalPrice: '₹150.0',
          discount: true,
        ),
        MedicineCard(
          name: 'Cetirizine 10mg',
          brand: 'Dr. Reddy\'s',
          price: '₹35.0',
          originalPrice: '₹40.0',
          discount: false,
        ),
        MedicineCard(
          name: 'Omeprazole 20mg',
          brand: 'Lupin',
          price: '₹85.0',
          originalPrice: '₹100.0',
          discount: false,
        ),

        MedicineCard(
          name: 'Paracetamol 500mg',
          brand: 'Panadol',
          price: '₹25.0',
          originalPrice: '₹30.0',
          discount: true,
        ),
        MedicineCard(
          name: 'Amoxicillin 250mg',
          brand: 'Cipla',
          price: '₹120.0',
          originalPrice: '₹150.0',
          discount: true,
        ),
      ],
    );
  }
}

class MedicineCard extends StatelessWidget {
  final String name;
  final String brand;
  final String price;
  final String originalPrice;
  final bool discount;

  const MedicineCard({
    super.key,
    required this.name,
    required this.brand,
    required this.price,
    required this.originalPrice,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.medication, color: Colors.grey, size: 40),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(brand, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (discount) ...[
                        const SizedBox(width: 4),
                        Text(
                          originalPrice,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (discount)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else
                    const SizedBox(),
                ],
              ),
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: Color(0xFF2196F3),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.add, color: Colors.white, size: 16),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
