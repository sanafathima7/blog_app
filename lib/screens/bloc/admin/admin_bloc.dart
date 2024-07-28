import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_bloc/screens/bloc/admin/admin_events.dart';
import 'package:hive_bloc/screens/bloc/admin_state.dart';

class AdminHomepageBloc extends Bloc<AdminHomepageEvent, AdminHomepageState> {
  AdminHomepageBloc() : super(const AdminHomepageInitial(0));

  @override
  Stream<AdminHomepageState> mapEventToState(AdminHomepageEvent event) async* {
    if (event is BottomNavBarTapped) {
      yield AdminHomepageInitial(event.index);
    }
  }
}
