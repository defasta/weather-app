import 'dart:convert';

// Search SearchFromJson(String str) => Search.fromJson(json.decode(str));
//
// String SearchToJson(Search data) => json.encode(data.toJson());

class Search{
  final String name;

  Search(this.name);

  Search.fromJson(Map<String, dynamic> json) : name = json["name"];

  Map<String, dynamic> toJson() => {
    'name': name
  };
}