enum BodyConditionScore {
    cachetic,
    lean,
    ideal,
    fat,
    obese;

    @override
    String toString() {
        switch (this) {
            case BodyConditionScore.cachetic:
                return "Caquético";

            case BodyConditionScore.lean:
                return "Magro";

            case BodyConditionScore.ideal:
                return "Ideal";

            case BodyConditionScore.fat:
                return "Gordo";

            case BodyConditionScore.obese:
                return "Obeso";
        }
    }
}

class Birth {
    int id;
    DateTime date;
    BodyConditionScore bcs;
    double weight;

    Birth(this.id, this.date, this.bcs, this.weight);
}
