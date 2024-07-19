import 'package:integrazoo/dairy_cattle_subsystem/model/bovine.dart';


enum DiscardReason {
    death,
    sell,
    discard;

    @override
    String toString() {
        switch (this) {
            case death:
                return 'Morte';

            case sell:
                return 'Venda';

            case discard:
                return 'Descarte';
        }
    }
}

class DiscardEvent {
    int id;
    DiscardReason reason;
    List<Bovine> herd;
    String? observation;

    DiscardEvent(this.id, this.reason, this.herd, this.observation);
}

