part of 'project_bloc.dart';

@immutable
sealed class ProjectState {}

final class ProjectInitial extends ProjectState {}

final class ProjectLoading extends ProjectState {}

final class ProjectLoadSuccess extends ProjectState {
  final List<Project> projects;

  ProjectLoadSuccess({required this.projects});
}

final class ProjectLoadFailure extends ProjectState {
  final String error;

  ProjectLoadFailure({required this.error});
}

final class ProjectAdded extends ProjectState {
  final List<Project> projects;

  ProjectAdded({required this.projects});
}

final class ProjectUpdated extends ProjectState {
  final List<Project> projects;

  ProjectUpdated({required this.projects});
}
