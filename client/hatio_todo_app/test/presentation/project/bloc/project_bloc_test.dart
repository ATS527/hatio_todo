import 'package:flutter_test/flutter_test.dart';
import 'package:hatio_todo_app/presentation/project/bloc/project_bloc.dart';

void main() {
  group("project bloc tests", () {
    test("Initial State", () {
      expect(ProjectBloc().state, ProjectInitial());
    });
  });

  // All Other Tests could not be conducted since the API uses cookie to fetch the jwt access token to authenticate the user.
}
