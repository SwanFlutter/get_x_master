class ConditionalNavigation {
  final dynamic Function() condition;
  final dynamic Function() truePage;
  final dynamic Function() falsePage;

  ConditionalNavigation({
    required this.condition,
    required this.truePage,
    required this.falsePage,
  });

  dynamic Function() evaluate() {
    return condition() ? truePage : falsePage;
  }
}
