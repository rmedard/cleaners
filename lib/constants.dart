
const String kApiUrl = 'http://www.isuku.site/api';
const String kMainDateTimeFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS";
const String kLoggedInUser = 'LOGGED_IN_USER';
const double kPadding = 10.0;
const double kAvatarRadius = 50.0;

enum headerType { accessToken, tokenType, client, expiry, uid }

const Map<headerType, String> kHeaders = {
  headerType.accessToken: 'access-token',
  headerType.tokenType: 'token-type',
  headerType.client: 'client',
  headerType.expiry: 'expiry',
  headerType.uid: 'uid'
};
