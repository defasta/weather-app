import 'package:equatable/equatable.dart';
abstract class SearchEvent extends Equatable{
  const SearchEvent();
}

class FetchSearch extends SearchEvent{
  final String inputCity;
  const FetchSearch({required this.inputCity});
  @override
  List<Object?> get props => [inputCity];
}

class FetchLocation extends SearchEvent{
  final String inputCity;
  const FetchLocation({required this.inputCity});
  @override
  List<Object?> get props => [inputCity];
}