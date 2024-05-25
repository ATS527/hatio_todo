part of 'project_bloc.dart';

@immutable
sealed class ProjectEvent {}

final class InitialProjectEvent extends ProjectEvent {}

final class AddProjectButtonPressed extends ProjectEvent {
  final String name;

  AddProjectButtonPressed({
    required this.name,
  });
}

final class UpdateProject extends ProjectEvent {
  final String projectId;
  final String name;

  UpdateProject({
    required this.projectId,
    required this.name,
  });
}
