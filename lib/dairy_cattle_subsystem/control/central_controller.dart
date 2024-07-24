import 'package:integrazoo/dairy_cattle_subsystem/control/bovine_controller.dart';
import 'package:integrazoo/dairy_cattle_subsystem/control/cow_production_controller.dart';
import 'package:integrazoo/dairy_cattle_subsystem/control/herd_production_controller.dart';
import 'package:integrazoo/dairy_cattle_subsystem/control/dry_treatment_controller.dart';

class CentralController {
    BovineController bovineController;
    CowProductionController cowProductionController;
    HerdProductionController herdProductionController;
    DryTreatmentController dryTreatmentController;

    CentralController(this.bovineController,
                      this.cowProductionController,
                      this.herdProductionController,
                      this.dryTreatmentController);
}
