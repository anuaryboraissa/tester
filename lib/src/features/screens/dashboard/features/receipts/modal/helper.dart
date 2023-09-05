import 'package:erisiti/src/constants/data/receipts.dart';
import 'package:erisiti/src/constants/styles/style.dart';
import 'package:erisiti/src/features/screens/dashboard/features/receipts/modal/receipt.dart';
import 'package:flutter/material.dart';

class ReceiptHelper {
  static List<Receipt> receipts = AvailableReceipts.receipts
      .map((e) => Receipt(
          issuer: e["issuer"]!, address: e['address']!, phone: e["Phone"]!))
      .toList();

  TextSpan searchMatch(String match, String search) {
    TextStyle positiveColorStyle =
        const TextStyle(color: ApplicationStyles.realAppColor);
    TextStyle negativeColorStyle = const TextStyle(color: Colors.black);
    if (search.isEmpty) {
      return TextSpan(text: match, style: negativeColorStyle);
    }
    var refinedMatch = match.toLowerCase();
    var refinedSearch = search.toLowerCase();
    if (refinedMatch.contains(refinedSearch)) {
      if (refinedMatch.substring(0, refinedSearch.length) == refinedSearch) {
        return TextSpan(
          style: positiveColorStyle,
          text: match.substring(0, refinedSearch.length),
          children: [
            searchMatch(
                match.substring(
                  refinedSearch.length,
                ),
                search),
          ],
        );
      } else if (refinedMatch.length == refinedSearch.length) {
        return TextSpan(text: match, style: positiveColorStyle);
      } else {
        return TextSpan(
          style: negativeColorStyle,
          text: match.substring(
            0,
            refinedMatch.indexOf(refinedSearch),
          ),
          children: [
            searchMatch(
                match.substring(
                  refinedMatch.indexOf(refinedSearch),
                ),
                search),
          ],
        );
      }
    } else if (!refinedMatch.contains(refinedSearch)) {
      return TextSpan(text: match, style: negativeColorStyle);
    }
    return TextSpan(
      text: match.substring(0, refinedMatch.indexOf(refinedSearch)),
      style: negativeColorStyle,
      children: [
        searchMatch(
            match.substring(refinedMatch.indexOf(refinedSearch)), search)
      ],
    );
  }
}
