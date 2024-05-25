import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatio_todo_app/data/model/project.dart';
import 'package:hatio_todo_app/data/repository/project_repository.dart';
import 'package:meta/meta.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepository _projectRepository;

  ProjectBloc(this._projectRepository) : super(ProjectInitial()) {
    on<InitialProjectEvent>((event, emit) async {
      emit(ProjectInitial());
      try {
        List<Project> projects = await _projectRepository.getUserProjects();
        emit(ProjectSuccess(projects: projects));
      } catch (err) {
        emit(ProjectFailure(error: err.toString()));
      }
    });
  }
}
