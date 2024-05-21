// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:memoir/const.dart';
import 'package:memoir/controller/authController.dart';
import 'package:memoir/controller/homeController.dart';
import 'package:memoir/view/screens/chatList.dart';
import 'package:memoir/view/module/moduleList.dart';
import 'package:memoir/view/screens/profile.dart';
import 'package:memoir/view/screens/search.dart';

const newsImage = [
  'https://img.freepik.com/free-photo/ai-technology-microchip-background-digital-transformation-concept_53876-124669.jpg',
  'https://cdn.unischolarz.com/blog/wp-content/uploads/2023/01/02204733/tim-alex-FC1uuekWoZc-unsplash-1-min-scaled.jpg',
  'https://media.istockphoto.com/id/1047570732/vector/english.jpg?s=612x612&w=0&k=20&c=zgafUJxCytevU-ZRlrZlTEpw3mLlS_HQTIOHLjaSPPM='
];
const newText = [
  "Journées ouvertes sur l'intelligence artificielle du 15 au 18 avril 2024 animées par le Dr. Malik Boualem",
  "l'Université Mohamed El Bachir El Ibrahimi a accueilli les célébrations à l'occasion de la Journée du Savoir",
  "All first-year doctoral students are hereby informed that they are invited to take the final level in English language"
];

class HomePage extends StatelessWidget {
  AuthController auth = Get.put(AuthController());
  HomeController home = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Obx(
          () => CrystalNavigationBar(
            borderRadius: 25,
            backgroundColor: Color.fromARGB(255, 139, 139, 139),
            currentIndex: home.tabIndex.value,
            onTap: home.changeTabIndex,
            indicatorColor: primaryColor,
            unselectedItemColor: Color.fromARGB(255, 255, 255, 255),
            items: [
              CrystalNavigationBarItem(
                icon: FontAwesomeIcons.house,
              ),
              CrystalNavigationBarItem(icon: FontAwesomeIcons.magnifyingGlass),
              CrystalNavigationBarItem(icon: FontAwesomeIcons.solidMessage),
              CrystalNavigationBarItem(icon: FontAwesomeIcons.solidUser)
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 230, 230, 230),
        body: Obx(
          () => IndexedStack(
            index: home.tabIndex.value,
            children: [
              home.isLoading.value
                  ? Center(
                      child: loadingScreen,
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Actualités',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  '.',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                      fontSize: 40),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CarouselSlider(
                            options: CarouselOptions(
                              autoPlayInterval: Duration(seconds: 15),
                              viewportFraction: 1,
                              height: 250,
                              enlargeCenterPage: true,
                              autoPlay: true,
                            ),
                            items: [0, 1, 2].map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: newsImage[i])),
                                        Container(
                                          color: Color.fromARGB(97, 0, 0, 0),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15.0, horizontal: 15),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Text(
                                              newText[i],
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                wordSpacing: 4,
                                                letterSpacing: 1,
                                                color: Colors.white,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Sélectionnez votre Spécialité',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  '.',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                      fontSize: 40),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: home.specialities.length,
                            itemBuilder: (context, index) {
                              final speciality = home.specialities[index];
                              return Card(
                                elevation: 1,
                                child: ExpansionTile(
                                  title: Text(speciality.title),
                                  children: [
                                    for (var year in years)
                                      Card(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 18.0),
                                          child: ExpansionTile(
                                            title: Text(year),
                                            children: [
                                              for (var sub
                                                  in home.getSubspecialty(
                                                      speciality.id, year))
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 18.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Get.to(ModuleListPage(
                                                          title: sub.title,
                                                          modules:
                                                              home.getModules(
                                                                  sub.id)));
                                                    },
                                                    child: Card(
                                                      child: ListTile(
                                                        title: Text(sub.title),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                            ],
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
              SearchPage(),
              ChatPageList(),
              ProfilePage(),
            ],
          ),
        ));
  }
}
