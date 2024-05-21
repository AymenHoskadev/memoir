import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memoir/const.dart';
import 'package:memoir/controller/moduleController.dart';
import 'package:memoir/models/module.dart';
import 'package:memoir/view/module/moduleDetails.dart';

class ModuleListPage extends StatelessWidget {
  String title;
  List<Module> modules;
  ModuleListPage({required this.title, required this.modules});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Container(
            child: Text(title,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                softWrap: true),
          ),
          bottom: TabBar(
            labelColor: Colors.black,
            indicatorColor: primaryColor,
            tabs: const [
              Tab(
                text: 'Semestre 1',
              ),
              Tab(
                text: 'Semestre 2',
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TabBarView(
            children: [
              ModuleSemestre(semestre: 1, modules: modules),
              ModuleSemestre(semestre: 2, modules: modules),
            ],
          ),
        ),
      ),
    );
  }
}

class ModuleSemestre extends StatelessWidget {
  int semestre;
  List<Module> modules;
  ModuleSemestre({required this.semestre, required this.modules});

  @override
  Widget build(BuildContext context) {
    ModuleController moduleController =
        Get.put(ModuleController(modules: modules));

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: GridView.builder(
        itemCount: moduleController.getSemestreModule(semestre).length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 2,
            childAspectRatio: 1 / 0.8),
        itemBuilder: (BuildContext context, int index) {
          Module module = moduleController.getSemestreModule(semestre)[index];
          return InkWell(
            onTap: () {
              Get.to(ModuleDetails(module: module));
            },
            child: Container(
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        moduleController.getFirstLetters(module.title),
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(module.title),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}
