class ApiUrl {
   static const String baseUrl = "http://10.0.2.2:3000";
   // static const String baseUrl = "https://washington-unsigned-maintain-catalyst.trycloudflare.com";
  static const String imageUrl = baseUrl;
  static String socketUrl = baseUrl;

  ///========================= Authentication =========================
   static const String signIn = "/api/v1/auth/login";
   static const String signUp = "/api/v1/auth/create-user";
   static const String forgotPassword = "/api/v1/auth/forgot-password";
   static const String verificationOtpForgetPass = "/api/v1/auth/verify-reset-otp";
   static const String newPassword = "/api/v1/auth/reset-password";
   static const String changePassword = "/api/v1/auth/change-password";

   ///========================= My Profile =========================
   static const String myProfile = "/api/v1/auth/my-profile";
   static const String updateProfile = "/api/v1/user/update-profile";
   static const String termsCondition = "/api/v1/legalDoc/get-doc/termsAndCondition";
   static const String aboutUs = "/api/v1/legalDoc/get-doc/aboutUs";
   static const String privacyPolicy = "/api/v1/legalDoc/get-doc/privacyPolicy";

  static const String refreshToken = "/api/v1/auth/refresh-token";
  static String recentOtp({required String email})=> "/api/v1/user/resend_verification_otp/$email";
  static const String helpSupport = "/api/v1/legalDoc/get-doc/aboutUs";
  static const String googleAuth = "/api/v1/user/google_auth";
   static String getGalleryPostFilter({required  int page, required String filter})=> "/api/v1/memories_event/find_my_upload_memories_event?contentType=$filter&page=$page&limit=10";



   ///========================= Host =========================createListing
   static const String createListing = "/api/v1/listing/create-listing";
   static const String createDeal = "/api/v1/deal/create-deal";
   static const String createCollaboration = "/api/v1/collaboration/create-collaboration";
   static String getListing({required String page})=> "/api/v1/listing/my-listings?currentPage=$page&limit=3";
   static String getSingleListing({required String id})=> "/api/v1/listing/single-listing/$id";
   static String getDeals({required String page})=> "/api/v1/deal/my-all-deals?currentPage=$page&limit=10";
   static String getSingleDeal({required String id})=> "/api/v1/deal/get-single-deal/$id";
   static String listingSearch({required String listSearch})=> "/api/v1/search/specific?query=listings&searchType=$listSearch";
   static String dealSearch({required String listSearch})=> "/api/v1/search/specific?query=deals&searchType=$listSearch";
   static String getChatList({required String page})=> "/api/v1/message/get-all-conversations?page=$page&limit=10";
   static String getChatMessages({required String id, required String page})=> "/api/v1/message/get-chat-list/$id?page=$page&limit=10";
   static  String  influencerCompleteDeal({required String page})=>"/api/v1/collaboration/get-my-all-collaborations?status=completed&page=$page&limit=10";
   static  String  influencerList({required String page})=>"/api/v1/user/all-users?role=influencer&page=$page&limit=10";
   static String influencerSearch({required String query})=> "/api/v1/search/specific?query=users&searchType=$query";

  //share post


}