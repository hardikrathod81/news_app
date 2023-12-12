part of 'languges_bloc.dart';

@immutable
abstract class LangugesEvent extends Equatable {
  const LangugesEvent();

  @override
  List<Object> get props => [];
}

class SelectLangugesEvent extends LangugesEvent {
  final FillterList selectedFilterList;

  const SelectLangugesEvent(this.selectedFilterList);
  @override
  List<Object> get props => [selectedFilterList];
}
