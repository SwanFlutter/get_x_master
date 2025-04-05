class ConditionalNavigation {
  final dynamic Function() condition;
  final dynamic truePage;
  final dynamic falsePage;

  ConditionalNavigation({
    required this.condition,
    required this.truePage,
    required this.falsePage,
  });

  dynamic evaluate() {
    return condition() ? truePage : falsePage;
  }
} 