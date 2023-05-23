import '../core/enum.dart';

class UrlConst {
  UrlConst._();

  static const String mainUrl = "https://admin.marsgaming.org/api";

  static const String deviceTokenUrl = "$mainUrl/user/save_device_token";

  static const String bannerUrl = "$mainUrl/banner_mobile";

  static const headerPlayTextUrl = "$mainUrl/header_play_text";

  static const socialLinkUrl = "$mainUrl/social_link";

  static const appUpdateUrl = "$mainUrl/app-setting";

  ///Auth
  static const String loginUrl = "$mainUrl/user/login";

  static String checkPhone = "$mainUrl/user/check_phone";

  static String otpSend(String phone) =>
      "$mainUrl/user/send_otp?phone=$phone&title=Login Register OTP";

  static String verifyOtp(String phone, code) =>
      "$mainUrl/user/verify_otp?phone=$phone&code=$code";

  static const String registerUrl = "$mainUrl/user/verify_register";

  static const String forgotPasswordUrl = "$mainUrl/user/forget_password";

  ///Profile
  static const String profileUrl = "$mainUrl/user/profile";

  static const String updateProfileUrl = "$mainUrl/user/profile_update";

  static String uploadLevelTwoPhotoUrl = "$mainUrl/user/lvl_2";

  static String gameBalanceUrl(int userId) =>
      "$mainUrl/get_game_balance/$userId";

  ///IMAGE PRE FIT
  static const String imagePrefix = "https://admin.marsgaming.org/";

  ///promotion
  static const getPromotionCashIn = "$mainUrl/user/get_promo_cash_in";

  ///Wallet
  static String mainToGameTransferUrl = "$mainUrl/user/transfer_in";

  static String gameToMainTransferUrl = "$mainUrl/user/transfer_out";

  ///Cash in out
  static const cashInUrl = "$mainUrl/cash-in";
  static const cashOutUrl = "$mainUrl/cash-out";
  static const cashOutPaymentMethodUrl = "$mainUrl/payment-method/show-cashout";
  static const cashInPaymentMethodUrl = "$mainUrl/payment-method/show-cashin";

  static getCashInHistoryUrl({
    required int userId,
    required String startDate,
    required String endDate,
  }) =>
      "$mainUrl/user/cash_in_history?user_id=$userId&start_date=$startDate&end_date=$endDate";

  static getCashOutHistoryUrl({
    required int userId,
    required String startDate,
    required String endDate,
  }) =>
      "$mainUrl/user/cash_out_history?user_id=$userId&start_date=$startDate&end_date=$endDate";

  ///Game main transfer

  static String mainToGameTransferHistoryUrl({
    required String startDate,
    required String endDate,
  }) =>
      "$mainUrl/user/transfer_in_his?start_date=$startDate&end_date=$endDate";

  static String gameToMainTransferHistoryUrl({
    required String startDate,
    required String endDate,
  }) =>
      "$mainUrl/user/transfer_out_his?start_date=$startDate&end_date=$endDate";

  ///2d
  static String twodUrl = "$mainUrl/new_two_d";
  static String twodSectionUrl = "$mainUrl/section";
  static String twoDBettingUrl = "$mainUrl/user/betting";
  static String twoDluckyNumberDailyList = "$mainUrl/luckynumber_daily";
  static String thaiTwoDLive = "https://api.thaistock2d.com/live27";

  static String twoDBetSlipsHistoryUrl({
    required String startDate,
    required String endDate,
  }) =>
      "$mainUrl/user/bet_slip_history_2d?start_date=$startDate&end_date=$endDate";

  static String twoDLuckyNumHistoryUrl({
    required String startDate,
    required String endDate,
  }) =>
      "$mainUrl/luckynumber_history/2D?start_date=$startDate&end_date=$endDate";

  ///GAME
  static String hotNewGamesUrl = "$mainUrl/games/new";

  static String gameViewUrl(int userId, String gameCode) =>
      "$mainUrl/game_view/$userId?game_id=$gameCode&req=mb";

  static String getGamesUrl(GameType type) {
    switch (type) {
      case GameType.football:
        return "$mainUrl/getgame_by_pro?id=all&p_type=SB";
      case GameType.card:
        return "$mainUrl/getgame_by_pro/?id=all&p_type=CB";
      case GameType.casino:
        return "$mainUrl/getgame_by_pro/?id=all&p_type=lc";
      case GameType.fishing:
        return "$mainUrl/getgame_by_pro/?id=all&p_type=fh";
      case GameType.slot:
        return "$mainUrl/getgame_by_pro/?id=all&p_type=sl";
      case GameType.hotNew:
        return "$mainUrl/games/new";
    }
  }

  //games categories
  static String getGameCategoryUrl(GameType type) {
    switch (type) {
      case GameType.football:
        return "$mainUrl/game-providers/SB";
      case GameType.card:
        return "$mainUrl/game-providers/cb";
      case GameType.casino:
        return "$mainUrl/game-providers/lc";
      case GameType.fishing:
        return "$mainUrl/game-providers/fh";
      case GameType.slot:
        return "$mainUrl/game-providers/sl";
      case GameType.hotNew:
        return "";
    }
  }

  //game reports
  static String gameReports({
    required String startDate,
    required String endDate,
  }) =>
      "$mainUrl/reports?start_date=$startDate&end_date=$endDate";

  //game reports detail
  static String gameReportDetail({
    required String date,
    required String provider,
    required String usercode,
  }) =>
      "$mainUrl/report-details/?date=$date&provider=$provider&username=$usercode";

  ///3d
  static String threeDUrl = "$mainUrl/three_d";
  static String threeDBetUrl = "$mainUrl/user/betting_3d";
  static String threeDLuckyNumberUrl = "$mainUrl/luckynumber3d";
  static String threeDSectionUrl = "$mainUrl/section_3d";

  static String threeDBetSlipUrl({
    required String startDate,
    required String endDate,
  }) =>
      "$mainUrl/user/bet_slip_history_3d?start_date=$startDate&end_date=$endDate";

  static String threeDLuckyNumHistoryUrl({
    required String startDate,
    required String endDate,
  }) =>
      "$mainUrl/luckynumber_history/3D?start_date=$startDate&end_date=$endDate";

  ///crypto 2d
  static String cryptoTwoDUrl = "$mainUrl/crypto_two_d";
  static String cryptoTwoDSectionUrl = "$mainUrl/section_crypton2d";
  static String cryptoTwoDBettingUrl = "$mainUrl/user/betting_c2d";
  static String cryptoTwoDLuckyNumberDailyList =
      "$mainUrl/luckynumbercrypton2d";

  //static String thaiTwoDLive = "https://api.thaistock2d.com/live27";
  static String cryptoTwoDBetSlipsHistoryUrl({
    required String startDate,
    required String endDate,
  }) =>
      "$mainUrl/user/bet_slip_history_c2d?start_date=$startDate&end_date=$endDate";

  static String cryptoTwoDLuckyNumHistoryUrl({
    required String startDate,
    required String endDate,
  }) =>
      "$mainUrl/luckynumber_history/C2D?start_date=$startDate&end_date=$endDate";

  ///
  static String referralHistoryUrl({
    required String startDate,
    required String endDate,
    required String type,
  }) =>
      "$mainUrl/user/my_referral_his?start_date=$startDate&end_date=$endDate&type=$type";
  static String claimReferralAmountUrl = "$mainUrl/user/claim_game_refer_amt";

  /// Winner list
  static String twoDWinnerListUrl = "$mainUrl/winner_users/2D";

  static String threeDWinnerListUrl = "$mainUrl/winner_users/3D";

  static String cryptoTwoDWinnerListUrl = "$mainUrl/winner_users/C2D";

}
