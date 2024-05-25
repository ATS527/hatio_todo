import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatio_todo_app/data/model/project.dart';
import 'package:hatio_todo_app/data/repository/project_repository.dart';
import 'package:meta/meta.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepository _projectRepository = ProjectRepository();

  ProjectBloc() : super(ProjectInitial()) {
    on<InitialProjectEvent>((event, emit) async {
      emit(ProjectLoading());
      try {
        List<Project> projects = await _projectRepository.getUserProjects();
        emit(ProjectLoadSuccess(projects: projects));
      } catch (err) {
        emit(ProjectLoadFailure(error: err.toString()));
      }
    });

    on<AddProjectButtonPressed>((event, emit) async {
      emit(ProjectLoading());
      try {
        Project project = await _projectRepository.createProject(event.name);
        emit(ProjectAdded(project: project));
      } catch (err) {
        emit(ProjectLoadFailure(error: err.toString()));
      }
    });

    on<UpdateProject>((event, emit) async {
      emit(ProjectLoading());
      try {
        Project project = await _projectRepository.updateProjectTitle(
          event.projectId,
          event.name,
        );
        emit(ProjectUpdated(project: project));
      } catch (err) {
        emit(ProjectLoadFailure(error: err.toString()));
      }
    });
  }
}

final projectBloc = ProjectBloc();
