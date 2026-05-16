import 'package:admin_dashboard/components/button/detail_inventory_button.dart';
import 'package:admin_dashboard/components/chip/detail_inventory_chip.dart';
import 'package:admin_dashboard/components/tile/detail_inventory_tile.dart';
import 'package:admin_dashboard/controller/detail_inventory_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailInventoryPage extends StatelessWidget {
  DetailInventoryPage({super.key});

  final controller = Get.find<DetailInventoryController>();

  @override
  Widget build(BuildContext context) {
    final inventory = controller.inventory;

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  inventory.image,
                  height: 280,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ],
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: const Color(0xffF7F2F2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    inventory.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      const Text(
                        'ID Inventaris',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff922B21),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Text(inventory.inventoryId),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Text(
                        'Unit Tersedia',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff922B21),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Text(inventory.totalUnit.toString()),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      DetailInventoryChip(
                        title: inventory.location,
                        icon: Icons.location_on,
                      ),

                      const SizedBox(width: 8),

                      DetailInventoryChip(title: inventory.category),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.red.shade100),
                  bottom: BorderSide(color: Colors.red.shade100),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff922B21),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    inventory.description,
                    style: const TextStyle(height: 1.5),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      DetailInventoryButton(
                        title: 'Nonaktifkan',
                        onTap: controller.onDeactivate,
                      ),

                      const SizedBox(width: 12),

                      DetailInventoryButton(
                        title: 'Edit',
                        onTap: controller.onEdit,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Unit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff922B21),
                    ),
                  ),

                  const SizedBox(height: 16),

                  ...inventory.units.map(
                    (unit) => DetailInventoryTile(
                      id: unit['id'],
                      status: unit['status'],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
