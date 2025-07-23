enum ReproductionDiagnostic {
  waiting("waitingDiagnostic", "Aguardando Diagnóstico"),
  positive("positive", "Positivo"),
  negative("negative", "Negativo");

  const ReproductionDiagnostic(this.code, this.label);

  final String code;
  final String label;

  @override
  String toString() => label;
}
