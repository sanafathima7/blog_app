import 'package:equatable/equatable.dart';

abstract class AdminHomepageEvent extends Equatable {
  const AdminHomepageEvent();

  @override
  List<Object?> get props => [];
}

class BottomNavBarTapped extends AdminHomepageEvent {
  final int index;

  const BottomNavBarTapped(this.index);

  @override
  List<Object?> get props => [index];
}
