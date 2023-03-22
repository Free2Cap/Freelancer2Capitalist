class Project {
  const Project({
    required this.aim,
    required this.objective,
    required this.budgetStart,
    required this.budgetEnd,
    required this.field,
    required this.projectImages,
    required this.creator,
  });
  final String creator;
  final String aim;
  final String objective;
  final String budgetStart;
  final String budgetEnd;
  final String field;
  final String projectImages;
}

class Firm {
  const Firm({
    required this.name,
    required this.mission,
    required this.budgetStart,
    required this.budgetEnd,
    required this.field,
    required this.firmImages,
    required this.creator,
  });
  final String name;
  final String mission;
  final String budgetStart;
  final String budgetEnd;
  final String field;
  final String firmImages;
  final String creator;
}
