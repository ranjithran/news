import 'dart:io';

const List topics = [
  "General",
  "Entertainment",
  "Health",
  "Business",
  "Science",
  "Sports",
  "Technology"
];

String getAppId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-3442468769074584~8197660195';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-3442468769074584~8197660195';
  }
  return 'ca-app-pub-3442468769074584~8197660195';
}

String getBannerAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-3442468769074584/3687585455';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-3442468769074584/3687585455';
  }
  return 'ca-app-pub-3442468769074584/3687585455';
}
