import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:news_app/widgets/homescreen.dart';

part 'languges_event.dart';
part 'languages_state.dart';

class LangugesBloc extends Bloc<LangugesEvent, LangugesState> {
  FillterList selectedFilter = FillterList.bbcNews;

  LangugesBloc() : super(LangugesUpdate(FillterList.bbcNews));

  Stream<LangugesState> mapEventToState(LangugesEvent event) async* {
    if (event is Us) {
      selectedFilter = FillterList.bbcNews;
    } else if (event is In) {
      selectedFilter = FillterList.indiaNews;
    } else if (event is De) {
      selectedFilter = FillterList.cnnNews;
    }

    yield LangugesUpdate(selectedFilter);
  }
}
