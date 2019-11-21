
const String kApiUrl = 'http://www.isuku.site/api';
const String kLoggedInUser = 'LOGGED_IN_USER';

enum headerType { accessToken, tokenType, client, expiry, uid }

const Map<headerType, String> kHeaders = {
  headerType.accessToken: 'access-token',
  headerType.tokenType: 'token-type',
  headerType.client: 'client',
  headerType.expiry: 'expiry',
  headerType.uid: 'uid'
};
