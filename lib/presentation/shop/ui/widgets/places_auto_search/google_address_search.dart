import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/shop/ui/widgets/places_auto_search/google_place_model.dart';

class GoogleAddressSearch extends SearchDelegate<GoogleSuggestion> {
  GoogleAddressSearch() {
    apiClient = GooglePlaceApiProvider();
  }

  late GooglePlaceApiProvider apiClient;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            iconTheme: IconThemeData(color: Colors.white),
            elevation: 1,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          textTheme: const TextTheme(),
        );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(
        Icons.arrow_back_ios_outlined,
        size: 20,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  //Show google API predicted list
  @override
  Widget buildSuggestions(BuildContext context) {
    var snapData;
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: query == ""
              ? null
              : apiClient.fetchSuggestions(
                  query, Localizations.localeOf(context).languageCode),
          builder: (context, snapshot) {
            snapData = snapshot.data;
            return query == ''
                ? Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child: const TextView(
                      'Enter address',
                      textAlign: TextAlign.center,
                      maxLine: 2,
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                : snapshot.hasData
                    ? ListView.builder(
                        itemBuilder: (context, index) => ListTile(
                          title: TextView(
                            (snapData[index] as GoogleSuggestion).description!,
                            maxLine: 3,
                          ),
                          onTap: () async {
                            String? placeId =
                                (snapData[index] as GoogleSuggestion).placeId;
                            String? desc = (snapData[index] as GoogleSuggestion)
                                .description;
                            GoogleSuggestion res = await apiClient
                                .getPlaceDetailFromId(placeId, desc);
                            close(context, res);
                            FocusScope.of(context).unfocus();
                          },
                        ),
                        itemCount: snapData.length,
                      )
                    : const Center(
                        child: TextView(
                          'Loading',
                        ),
                      );
          }),
    );
  }

  //Search button
  @override
  Widget buildResults(BuildContext context) {
    var snapData;
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: query == ""
              ? null
              : apiClient.fetchSuggestions(
                  query, Localizations.localeOf(context).languageCode),
          builder: (context, snapshot) {
            snapData = snapshot.data;
            return query == ''
                ? Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child: const TextView(
                      'Enter address',
                      textAlign: TextAlign.center,
                      maxLine: 2,
                    ),
                  )
                : snapshot.hasData
                    ? ListView.builder(
                        itemBuilder: (context, index) => ListTile(
                          title: TextView((snapData[index] as GoogleSuggestion)
                              .description!),
                          onTap: () async {
                            String? placeId =
                                (snapData[index] as GoogleSuggestion).placeId;
                            String? desc = (snapData[index] as GoogleSuggestion)
                                .description;
                            GoogleSuggestion res = await apiClient
                                .getPlaceDetailFromId(placeId, desc);
                            close(context, res);
                            FocusScope.of(context).unfocus();
                          },
                        ),
                        itemCount: snapData.length,
                      )
                    : const Center(
                        child: TextView(
                          'Loading',
                        ),
                      );
          }),
    );
  }
}
