enum FinishingReason {
  notYet("notDiscarded", "Não Descartado"),
  discard("discard", "Descarte"),
  sell("sell", "Venda"),
  death("death", "Morte"),
  slaughter("slaughter", "Abate");

  const FinishingReason(this.code, this.label);

  final String code;
  final String label;

  @override
  String toString() => label;

  static FinishingReason parse(String text) {
    return FinishingReason.values.firstWhere(
      (reason) => reason.code == text || reason.label == text,
    );
  }
}
