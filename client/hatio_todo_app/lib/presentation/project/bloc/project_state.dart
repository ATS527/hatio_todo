part of 'project_bloc.dart';

@immutable
sealed class ProjectState {}

final class ProjectInitial extends ProjectState {}

final class ProjectLoading extends ProjectState {}

final class ProjectSuccess extends ProjectState {
  final List<Project> projects;

  ProjectSuccess({required this.projects});
}

final class ProjectFailure extends ProjectState {
  final String error;

  ProjectFailure({required this.error});
}

final class ProjectAdded extends ProjectState {
  final Project project;

  ProjectAdded({required this.project});
}

final class ProjectUpdated extends ProjectState {
  final Project project;

  ProjectUpdated({required this.project});
}
