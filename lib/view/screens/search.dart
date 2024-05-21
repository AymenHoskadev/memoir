import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memoir/controller/homeController.dart';
import 'package:memoir/models/subspeciality.dart';
import 'package:memoir/models/module.dart';

// Assuming you have your HomeController imported and initialized

class SearchPage extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 70,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              controller.filterSearchResults(value);
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(130, 255, 255, 255),
              labelText: 'Search',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Obx(() {
          return Expanded(
            child: ListView.builder(
              itemCount: controller.filteredResults.length,
              itemBuilder: (context, index) {
                var result = controller.filteredResults[index];
                if (result is SubSpeciality) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(result.title
                          // Implement what you want to do when a subspeciality is tapped
                          ),
                    ),
                  );
                } else if (result is Module) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(result.title
                          // Implement what you want to do when a module is tapped
                          ),
                    ),
                  );
                }
              },
            ),
          );
        }),
      ],
    );
  }
}
