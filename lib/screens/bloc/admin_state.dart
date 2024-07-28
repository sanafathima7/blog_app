import 'package:equatable/equatable.dart';

abstract class AdminHomepageState extends Equatable {
  const AdminHomepageState();

  @override
  List<Object?> get props => [];
}

class AdminHomepageInitial extends AdminHomepageState {
  final int currentIndex;

  const AdminHomepageInitial(this.currentIndex);

  @override
  List<Object?> get props => [currentIndex];
}
