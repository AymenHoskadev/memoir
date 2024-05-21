import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:memoir/const.dart';
import 'package:memoir/models/module.dart';
import 'package:memoir/models/speciality.dart';
import 'package:memoir/models/subspeciality.dart';
import 'package:memoir/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends FullLifeCycleController with FullLifeCycleMixin {
  RxList<Speciality> specialities = <Speciality>[].obs;
  RxList<SubSpeciality> subspecialties = <SubSpeciality>[].obs;
  RxList<Module> modules = <Module>[].obs;
  Rx<CustomUser?> currentUser = Rx<CustomUser?>(null);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchSpecialities();
    StatusChange();
    fetchCurrentUser();
    super.onInit();
  }

  var tabIndex = 0.obs;

  Future<User?> fetchCurrentUser() async {
    final response = await Supabase.instance.client
        .from('users')
        .select()
        .eq('id', supabase.auth.currentUser!.id)
        .single();
    currentUser.value = CustomUser.fromMap(response);
    print(currentUser);
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
    update();
  }

  StatusChange() {
    try {
      supabase.from('users').update({'status': true}).match(
          {'id': supabase.auth.currentUser!.id}).catchError((e) {
        print(e);
      });
      print('online');
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchSpecialities() async {
    isLoading.value = true;
    try {
      final List response = await supabase.from('specialities').select();
      specialities.value =
          response.map((speciality) => Speciality.fromMap(speciality)).toList();

      final List response2 = await supabase.from('subspecialities').select();
      subspecialties.value = response2
          .map((subSpeciality) => SubSpeciality.fromMap(subSpeciality))
          .toList();

      final List response3 = await supabase.from('modules').select();
      modules.value =
          response3.map((module) => Module.fromMap(module)).toList();

      isLoading.value = false;
    } catch (e) {
      print('Error fetching specialities: $e');
      isLoading.value = true;
    }
  }

  List<SubSpeciality> getSubspecialty(int idSpeciality, String branche) {
    return subspecialties
        .where((x) => x.idSpeciality == idSpeciality)
        .where((x) => x.branche == branche)
        .toList();
  }

  List<Module> getModules(int idSub) {
    return modules.where((x) => x.idSpeciality == idSub).toList();
  }

  RxList<dynamic> filteredResults = <dynamic>[].obs;

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      filteredResults.value = [];
    } else {
      List<dynamic> filtered = [];
      // Filter subspecialities
      filtered.addAll(subspecialties
          .where((subSpecialty) =>
              subSpecialty.title.toLowerCase().contains(query.toLowerCase()))
          .toList());
      // Filter modules
      filtered.addAll(modules
          .where((module) =>
              module.title.toLowerCase().contains(query.toLowerCase()))
          .toList());
      filteredResults.value = filtered;
    }
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {
    try {
      supabase.from('users').update({'status': false}).match(
          {'id': supabase.auth.currentUser!.id}).catchError((e) {
        print(e);
      });
      print('offline');
    } catch (e) {
      print(e);
    }
  }

  @override
  void onResumed() {
    /*  try {
      supabase.from('users').update({'status': false}).match(
          {'id': supabase.auth.currentUser!.id}).catchError((e) {
        print(e);
      });
      print('offline');
    } catch (e) {
      print(e);
    }*/
  }
}
