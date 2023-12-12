part of 'languges_bloc.dart';

@immutable
abstract class LangugesState extends Equatable {
  @override
  List<Object> get props => [];
}

class LangugesInitial extends LangugesState {
  @override
  List<Object> get props => [];
}

class LangugesUpdated extends LangugesState {
  final String name;

  LangugesUpdated(this.name);
  @override
  List<Object> get props => [name];
}

class LangugesUpdate extends LangugesState {
  final FillterList selectedFilter;

  LangugesUpdate(this.selectedFilter);

  @override
  List<Object> get props => [selectedFilter];
}

class Us extends LangugesState {
  final String name;

  Us({this.name = 'us'});
  @override
  List<Object> get props => [name];
}

class In extends LangugesState {
  final String name;

  In({this.name = 'in'});
  @override
  List<Object> get props => [name];
}

class De extends LangugesState {
  final String name;

  De({this.name = 'de'});
  @override
  List<Object> get props => [name];
}
