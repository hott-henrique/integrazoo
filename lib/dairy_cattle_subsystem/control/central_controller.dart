import 'package:integrazoo/dairy_cattle_subsystem/control/bovine_controller.dart';
import 'package:integrazoo/dairy_cattle_subsystem/control/cow_production_controller.dart';
import 'package:integrazoo/dairy_cattle_subsystem/control/dry_treatment_controller.dart';
import 'package:integrazoo/dairy_cattle_subsystem/control/herd_production_controller.dart';
import 'package:integrazoo/dairy_cattle_subsystem/control/reproduction_controller.dart';
import 'package:integrazoo/dairy_cattle_subsystem/control/semen_controller.dart';
import 'package:integrazoo/dairy_cattle_subsystem/control/treatment_controller.dart';


class CentralController {
  BovineController bovineController;
  CowProductionController cowProductionController;
  HerdProductionController herdProductionController;
  DryTreatmentController dryTreatmentController;
  TreatmentController treatmentController;
  ReproductionController reproductionController;
  SemenController semenController;

  CentralController(this.bovineController,
                    this.cowProductionController,
                    this.herdProductionController,
                    this.dryTreatmentController,
                    this.treatmentController,
                    this.reproductionController,
                    this.semenController);
}
