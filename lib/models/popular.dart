// To parse this JSON data, do
//
//     final popular = popularFromMap(jsonString);

import 'dart:convert';

import 'package:nirobifilm/models/models.dart';

class Popular {
    Popular({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory Popular.fromJson(String str) => Popular.fromMap(json.decode(str));

 

    factory Popular.fromMap(Map<String, dynamic> json) => Popular(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );


}
