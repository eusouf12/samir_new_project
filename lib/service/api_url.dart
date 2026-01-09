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

   ///========================= My Profile =========================
   static const String myProfile = "/api/v1/auth/my-profile";

  static const String refreshToken = "/api/v1/auth/refresh-token";
  static String recentOtp({required String email})=> "/api/v1/user/resend_verification_otp/$email";
  static const String updateProfile = "/api/v1/auth/update_my_profile";
  static const String termsCondition = "/api/v1/setting/find_by_terms_conditions";
  static const String aboutUs = "/api/v1/setting/find_by_about_us";
  static const String privacyPolicy = "/api/v1/setting/find_by_privacy_policys";
  static const String helpSupport = "/api/v1/help_support/recorded_help_support";
  static const String changePassword = "/api/v1/user/change_password";
  static const String googleAuth = "/api/v1/user/google_auth";
   static String getGalleryPostFilter({required  int page, required String filter})=> "/api/v1/memories_event/find_my_upload_memories_event?contentType=$filter&page=$page&limit=10";



   ///========================= Host =========================createListing
   static const String createListing = "/api/v1/listing/create-listing";
   static const String createDeal = "/api/v1/deal/create-deal";
   static String getListing({required String page})=> "/api/v1/listing/my-listings?currentPage=$page&limit=10";


  //share post


}