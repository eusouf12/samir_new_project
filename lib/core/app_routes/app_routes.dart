// ignore_for_file: prefer_const_constructors
import 'package:get/get.dart';
import '../../view/screens/Influencer_part/inf_explore_deals_screen/inf_explore_deals_screen.dart';
import '../../view/screens/Influencer_part/inf_home_screen/inf_active_host_profile_screen.dart';
import '../../view/screens/Influencer_part/inf_home_screen/inf_active_hosts_screen.dart';
import '../../view/screens/Influencer_part/inf_home_screen/inf_earnings_screen.dart';
import '../../view/screens/Influencer_part/inf_home_screen/inf_home_screen.dart';
import '../../view/screens/Influencer_part/inf_home_screen/inf_night_credits_screen.dart';
import '../../view/screens/Influencer_part/inf_home_screen/inf_total_deals_screen.dart';
import '../../view/screens/Influencer_part/inf_profile_screen/about_screen.dart';
import '../../view/screens/Influencer_part/inf_profile_screen/inf_account_settings.dart';
import '../../view/screens/Influencer_part/inf_profile_screen/inf_change_password_screen.dart';
import '../../view/screens/Influencer_part/inf_profile_screen/inf_edit_profile_screen.dart';
import '../../view/screens/Influencer_part/inf_profile_screen/inf_profile_screen.dart';
import '../../view/screens/Influencer_part/inf_profile_screen/inf_referrals_screen.dart';
import '../../view/screens/Influencer_part/inf_profile_screen/privacy_screen.dart';
import '../../view/screens/Influencer_part/inf_profile_screen/terms_services_screen‎.dart';
import '../../view/screens/authentication/views/auth_screen/forgot_screen/forgot_screen.dart';
import '../../view/screens/authentication/views/auth_screen/login_screen/login_screen.dart';
import '../../view/screens/authentication/views/auth_screen/otp_screen/otp_screen.dart';
import '../../view/screens/authentication/views/auth_screen/set_new_password/set_new_password.dart';
import '../../view/screens/authentication/views/auth_screen/sign_up_screen/sign_up_screen.dart';
import '../../view/screens/choose_role/view/role_screen.dart';
import '../../view/screens/host_part/host_active_influe/host_active_influe.dart';
import '../../view/screens/host_part/host_active_influe/host_active_view_profile_screen.dart';
import '../../view/screens/host_part/host_active_influe/host_send_collaboaration_screen.dart';
import '../../view/screens/host_part/host_deal_screen/views/host_deals_screen.dart';
import '../../view/screens/host_part/host_home_screen/collaboration_screen/host_collaboration_screen.dart';
import '../../view/screens/host_part/host_home_screen/collaboration_screen/host_collaboration_view_details_screen.dart';
import '../../view/screens/host_part/host_deal_screen/views/host_create_deal_screen.dart';
import '../../view/screens/host_part/host_deal_screen/views/host_create_deal_three_screen.dart';
import '../../view/screens/host_part/host_deal_screen/views/host_create_deal_two_screen.dart';
import '../../view/screens/host_part/host_home_screen/host_deal_overview_screen.dart';
import '../../view/screens/host_part/host_home_screen/host_home_screen.dart';
import '../../view/screens/host_part/host_home_screen/host_notification_screen.dart';
import '../../view/screens/host_part/host_home_screen/host_redeem_request_screen.dart';
import '../../view/screens/host_part/host_deal_screen/views/host_review_confirm_screen.dart';
import '../../view/screens/host_part/host_listing_screen/host_add_new_listing_screen.dart';
import '../../view/screens/host_part/host_listing_screen/host_listing_screen.dart';
import '../../view/screens/host_part/host_messages_list_screen/host_messages_list_screen.dart';
import '../../view/screens/host_part/host_profile_screen/host_about_screen.dart';
import '../../view/screens/host_part/host_profile_screen/host_change_password_screen.dart';
import '../../view/screens/host_part/host_profile_screen/host_edit_profile_screen.dart';
import '../../view/screens/host_part/host_profile_screen/host_peferrals_screen.dart';
import '../../view/screens/host_part/host_profile_screen/host_privacy_screen.dart';
import '../../view/screens/host_part/host_profile_screen/host_profile_screen.dart';
import '../../view/screens/host_part/host_profile_screen/host_terms_screen.dart';
import '../../view/screens/onboarding_screen/account_ready_screen/account_ready _screen.dart';
import '../../view/screens/onboarding_screen/view/onboarding_screen.dart';
import '../../view/screens/splash_screen/splash_screen.dart';
class AppRoutes {

  ///===========================Authentication Part=========================
  static const String loginScreen = "/LoginScreen";
  static const String signUpScreen = "/SignUpScreen";
  static const String otpScreen = "/otpScreen";
  static const String verifyPicCodeScreen = "/verify_otp";
  static const String recoverySetupScreen = '/recovery_setup_1';
  static const String finalRecoveryScreen = '/final_recovery';
  static const String subscriptionScreen = '/subscription';
  static const String settingScreen = "/SettingScreen";
  static const String forgotScreen = "/ForgotScreen";
  static const String privacyScreen = "/PrivacyScreen";
  static const String aboutScreen = "/AboutScreen";
  static const String termsServicesScreen = "/TermsServicesScreen";
  static const String setNewPassword = "/SetNewPassword";

 static const String registrationScreen = "/RegistrationScreen";
 static const String forgotPassScreen = "/ForgotPassScreen";
 static const String verifyOtpScreen = "/VerifyOtpScreen";
 static const String updatePassScreen = "/UpdatePassScreen";
 static const String onboardingScreen = "/OnboardingScreen";
 static const String chooseRole = "/ChooseRole";
 static const String accountReadyScreen = "/AccountReadyScreen";

  ///===========================Host  Part ==========================
 static const String splashScreen = "/SplashScreen";
 static const String hostHomeScreen = "/HostHomeScreen";
 static const String hostProfileScreen = "/HostProfileScreen";
 static const String hostEditProfileScreen = "/HostEditProfileScreen";
 static const String hostAccountSettings = "/HostAccountSettings";
 static const String hostChangePasswordScreen = "/HostChangePasswordScreen";
 static const String hostPrivacyScreen = "/HostPrivacyScreen";
 static const String hostTermsScreen = "/HostTermsScreen";
 static const String hostAboutScreen = "/HostAboutScreen";
 static const String hostDealsScreen = "/HostDealsScreen";
 static const String hostDealOverviewScreen = "/HostDealOverviewScreen";
 static const String hostListingScreen = "/HostListingScreen";
 static const String hostAddNewListingScreen = "/HostAddNewListingScreen";
 static const String hostActiveInflue = "/HostActiveInflue";
 static const String hostActiveViewProfileScreen = "/HostActiveViewProfileScreen";
 static const String hostSendCollaboarationScreen = "/HostSendCollaboarationScreen";
 static const String hostMessagesListScreen = "/HostMessagesListScreen";
 static const String hostPeferralsScreen = "/HostPeferralsScreen";
 static const String hostCreateDealScreen = "/HostCreateDealScreen";
 static const String hostCreateDealTwoScreen = "/HostCreateDealTwoScreen";
 static const String hostCreateDealThreeScreen = "/HostCreateDealThreeScreen";
 static const String hostReviewConfirmScreen = "/HostReviewConfirmScreen";
 static const String hostNotificationScreen = "/HostNotificationScreen";
 static const String myListing = "/MyListing";
 static const String hostCollaborationScreen = "/HostCollaborationScreen";
 static const String hostCollaborationViewDetailsScreen = "/HostCollaborationViewDetailsScreen";
 static const String hostRedeemRequestScreen = "/HostRedeemRequestScreen";


 ///===========================Influencer Part========================
 static const String infHomeScreen = "/InfHomeScreen";
 static const String infProfileScreen = "/InfProfileScreen";
 static const String infEditProfileScreen = "/InfEditProfileScreen";
 static const String infAccountSettings = "/InfAccountSettings";
 static const String infReferralsScreen = "/InfReferralsScreen";
 static const String infChangePasswordScreen = "/InfChangePasswordScreen";
 static const String infTermsScreen = "/InfTermsScreen";
 static const String infPrivacyScreen = "/InfPrivacyScreen";
 static const String infAboutScreen = "/InfAboutScreen";
 static const String infExploreDealsScreen = "/InfExploreDealsScreen";
 static const String infNightCreditsScreen = "/InfNightCreditsScreen";
 static const String infEarningsScreen = "/InfEarningsScreen";
 static const String infTotalDealsScreen = "/InfTotalDealsScreen";
 static const String infActiveHostsScreen = "/InfActiveHostsScreen";
 static const String infActiveHostProfileScreen = "/InfActiveHostProfileScreen";


  static List<GetPage> routes = [
    ///===========================Authentication Part========================
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onboardingScreen, page: () => const OnboardingScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: otpScreen, page: () => OtpScreen()),
    GetPage(name: signUpScreen, page: () => SignUpScreen()),
    GetPage(name: forgotScreen, page: () => ForgotScreen()),
    GetPage(name: privacyScreen, page: () => PrivacyScreen()),
    GetPage(name: aboutScreen, page: () => AboutScreen()),
    GetPage(name: termsServicesScreen, page: () => TermsServicesScreen()),
    GetPage(name: setNewPassword, page: () => SetNewPassword()),
    GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
    GetPage(name: chooseRole, page: () => ChooseRole()),
    GetPage(name: accountReadyScreen, page: () => AccountReadyScreen()),
    // GetPage(name: subscriptionScreen, page: () => const SubscriptionScreenOne(),),






    ///===========================Host Part==========================
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: hostHomeScreen, page: () => HostHomeScreen()),
    GetPage(name: hostProfileScreen, page: () => HostProfileScreen()),
    GetPage(name: hostEditProfileScreen, page: () => HostEditProfileScreen()),
    GetPage(name: hostChangePasswordScreen, page: () => HostChangePasswordScreen()),
    GetPage(name: hostPrivacyScreen, page: () => HostPrivacyScreen()),
    GetPage(name: hostTermsScreen, page: () => HostTermsScreen()),
    GetPage(name: hostAboutScreen, page: () => HostAboutScreen()),
    GetPage(name: hostDealsScreen, page: () => HostDealsScreen()),
    GetPage(name: hostDealOverviewScreen, page: () => HostDealOverviewScreen()),
    GetPage(name: hostListingScreen, page: () => HostListingScreen()),
    GetPage(name: hostAddNewListingScreen, page: () => HostAddNewListingScreen()),
    GetPage(name: hostActiveInflue, page: () => HostActiveInflue()),
    GetPage(name: hostActiveViewProfileScreen, page: () => HostActiveViewProfileScreen()),
    GetPage(name: hostSendCollaboarationScreen, page: () => HostSendCollaboarationScreen()),
    GetPage(name: hostMessagesListScreen, page: () => HostMessagesListScreen()),
    GetPage(name: hostPeferralsScreen, page: () => HostPeferralsScreen()),
    GetPage(name: hostCreateDealScreen, page: () => HostCreateDealScreen()),
    GetPage(name: hostCreateDealTwoScreen, page: () => HostCreateDealTwoScreen()),
    GetPage(name: hostCreateDealThreeScreen, page: () => HostCreateDealThreeScreen()),
    GetPage(name: hostReviewConfirmScreen, page: () => HostReviewConfirmScreen()),
    GetPage(name: hostNotificationScreen, page: () => HostNotificationScreen()),
    GetPage(name: hostCollaborationScreen, page: () => HostCollaborationScreen()),
    GetPage(name: hostCollaborationViewDetailsScreen, page: () => HostCollaborationViewDetailsScreen()),
    GetPage(name: hostRedeemRequestScreen, page: () => HostRedeemRequestScreen()),



    ///===========================Influencer Part========================
    GetPage(name: infHomeScreen, page: () => InfHomeScreen()),
    GetPage(name: infProfileScreen, page: () => InfProfileScreen()),
    GetPage(name: infEditProfileScreen, page: () => InfEditProfileScreen()),
    GetPage(name: infAccountSettings, page: () => InfAccountSettings()),
    GetPage(name: infReferralsScreen, page: () => InfReferralsScreen()),
    GetPage(name: infChangePasswordScreen, page: () => InfChangePasswordScreen()),
    GetPage(name: infExploreDealsScreen, page: () => InfExploreDealsScreen()),
    GetPage(name: infNightCreditsScreen, page: () => InfNightCreditsScreen()),
    GetPage(name: infEarningsScreen, page: () => InfEarningsScreen()),
    GetPage(name: infTotalDealsScreen, page: () => InfTotalDealsScreen()),
    GetPage(name: infActiveHostsScreen, page: () => InfActiveHostsScreen()),
    GetPage(name: infActiveHostProfileScreen, page: () => InfActiveHostProfileScreen()),

  ];
}
