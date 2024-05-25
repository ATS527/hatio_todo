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
  final Project project;

  ProjectAdded({required this.project});
}

final class ProjectUpdated extends ProjectState {
  final Project project;

  ProjectUpdated({required this.project});
}
