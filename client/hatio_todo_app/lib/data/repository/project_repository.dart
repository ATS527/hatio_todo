import 'package:hatio_todo_app/data/data_provider/project_data_provider.dart';
import 'package:hatio_todo_app/data/model/project.dart';

class ProjectRepository {
  final ProjectDataProvider _projectDataProvider = ProjectDataProvider();

  Future<Project> createProject(String title) async {
    var response = await _projectDataProvider.createProjectData(title);

    return Project.fromJson(response);
  }

  Future<List<Project>> getUserProjects() async {
    var response = await _projectDataProvider.getUserProjectsData();

    return Project.fromJsontoList(response);
  }

  Future<Project> getProjectDetails(String id) async {
    var response = await _projectDataProvider.getProjectDetailsData(id);

    return Project.fromJson(response);
  }

  Future<Project> updateProjectTitle(String id, String title) async {
    var response =
        await _projectDataProvider.updateProjectTitleData(id: id, title: title);

    return Project.fromJson(response);
  }
}
