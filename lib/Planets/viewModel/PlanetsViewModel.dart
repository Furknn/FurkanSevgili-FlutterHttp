import 'package:flutter/material.dart';
import 'package:planets/Planets/model/PlanetModel.dart';
import 'package:planets/Planets/view/Planets.dart';

import '../service/IPlanetService.dart';
import '../service/PlanetService.dart';

abstract class PlanetsViewModel extends State<Planets> {
  bool isLoading = false;
  List<PlanetModel> planets = [];
  IPlanetService planetService;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    planetService = PlanetService();
    callItems();
  }

  Future<void> callItems() async {
    await _getPlanets();
  }

  Future<void> _getPlanets() async {
    planets = await planetService.getPlanetList();
  }
}
