// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Sabores de Parintins';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonRetry => 'Try again';

  @override
  String get commonTryAgain => 'Try again';

  @override
  String get commonComingSoon => 'Coming soon';

  @override
  String get commonNotNow => 'Not now';

  @override
  String get commonAllow => 'Allow';

  @override
  String get commonOpen => 'OPEN';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonSeeMore => 'See more';

  @override
  String get commonSeeLess => 'See less';

  @override
  String get navHome => 'Home';

  @override
  String get navSearch => 'Search';

  @override
  String get navMap => 'Map';

  @override
  String get navProfile => 'Profile';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileLanguage => 'Language';

  @override
  String get profileLanguageSubtitle => 'App language';

  @override
  String get profileFavorites => 'My favorites';

  @override
  String get profileFavoritesSubtitle => 'Your personal list';

  @override
  String get profileReviews => 'My reviews';

  @override
  String get profileReviewsSubtitle => 'Your reviews here';

  @override
  String get profileSettings => 'Settings';

  @override
  String get profileSettingsSubtitle => 'Coming soon';

  @override
  String get profileSignOut => 'Sign out';

  @override
  String get profileSignOutConfirmTitle => 'Sign out?';

  @override
  String get profileSignOutConfirmBody =>
      'You\'ll need to sign in again to use personalized features.';

  @override
  String get profileSignOutCancel => 'Cancel';

  @override
  String get profileSignOutConfirm => 'Sign out';

  @override
  String get profileSignedOutToast => 'Signed out.';

  @override
  String get profileLoggedOutHeadline =>
      'Sign in for a personalized experience';

  @override
  String get profileLoggedOutBody => 'Save favorites, leave reviews and more.';

  @override
  String get profileLoggedOutTerms =>
      'By continuing you accept our Terms of Use and Privacy Policy.';

  @override
  String get languagePickerTitle => 'Language';

  @override
  String get languageSystemDefault => 'System default';

  @override
  String get languageSystemDefaultSubtitle => 'Use the phone\'s language';

  @override
  String get languagePortuguese => 'Portuguese (Brazil)';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Spanish';

  @override
  String get homeSearchHint => 'Search restaurants, dishes or categories';

  @override
  String get homeCategoriesTitle => 'Categories';

  @override
  String get homeCategoryAll => 'All';

  @override
  String get homeCategoriesError => 'Couldn\'t load categories';

  @override
  String get homeEstablishmentsTitle => 'Places';

  @override
  String get homeEstablishmentsError => 'Couldn\'t load places';

  @override
  String get homeEstablishmentsEmpty => 'No places found';

  @override
  String get bannerHeadline => 'Top Picks';

  @override
  String get bannerSubtitle => 'Discover the highlights of Parintins';

  @override
  String get favoritesTitle => 'My favorites';

  @override
  String get favoritesEmptyTitle => 'You have no favorites yet';

  @override
  String get favoritesEmptySubtitle =>
      'Tap the heart on places to save them here.';

  @override
  String get favoriteAddSemantics => 'Add to favorites';

  @override
  String get favoriteRemoveSemantics => 'Remove from favorites';

  @override
  String get favoriteToggleError => 'Couldn\'t save favorite. Try again.';

  @override
  String get statusOpen => 'Open';

  @override
  String get statusClosed => 'Closed';

  @override
  String get statusOpenNow => 'Open now';

  @override
  String get detailSectionAbout => 'About';

  @override
  String get detailSectionHours => 'Hours';

  @override
  String get detailSectionAddress => 'Address';

  @override
  String get detailSectionAmenities => 'Amenities';

  @override
  String get detailDescriptionEmpty =>
      'The owner hasn\'t added a description yet.';

  @override
  String get detailErrorTitle => 'Couldn\'t load this place.';

  @override
  String get hoursEmpty => 'Hours not provided by the owner';

  @override
  String get amenitiesEmpty => 'No amenities listed';

  @override
  String get addressNotProvided => 'Address not provided';

  @override
  String get addressOpenMap => 'Open in Maps';

  @override
  String get actionWhatsApp => 'WhatsApp';

  @override
  String get actionInstagram => 'Instagram';

  @override
  String get actionMap => 'Map';

  @override
  String get actionShare => 'Share';

  @override
  String get actionWhatsAppMissing => 'This place hasn\'t set up WhatsApp yet.';

  @override
  String get actionInstagramMissing =>
      'This place hasn\'t set up Instagram yet.';

  @override
  String get actionLocationMissing => 'Location not available.';

  @override
  String actionOpenUrlError(String url) {
    return 'Couldn\'t open: $url';
  }

  @override
  String actionGenericError(String error) {
    return 'Error: $error';
  }

  @override
  String get actionWhatsAppGreeting =>
      'Hi! I found you on Sabores de Parintins.';

  @override
  String actionShareText(String name) {
    return 'Check out $name on Sabores de Parintins!';
  }

  @override
  String actionShareError(String error) {
    return 'Couldn\'t share: $error';
  }

  @override
  String mapShowingCount(int shown, int total) {
    return 'Showing $shown of $total places';
  }

  @override
  String get mapNoLocations => 'No places with location available.';

  @override
  String mapDistanceMeters(int meters) {
    return '$meters m from here';
  }

  @override
  String mapDistanceKilometers(String km) {
    return '$km km from here';
  }

  @override
  String get mapViewDetails => 'View details →';

  @override
  String get locationGpsDisabled =>
      'GPS is off. Turn on your phone\'s location.';

  @override
  String get locationFailed => 'Couldn\'t get your location.';

  @override
  String get locationDialogTitle => 'Allow location access?';

  @override
  String get locationDialogBody =>
      'To show nearby places on the map and calculate distance, we need your location.';

  @override
  String get locationDeniedForever =>
      'Permission permanently denied. Enable it in Settings.';

  @override
  String get reviewsSectionTitle => 'Reviews';

  @override
  String get reviewActionAdd => 'Review this place';

  @override
  String get reviewActionEdit => 'Edit my review';

  @override
  String reviewSeeAll(int count) {
    return 'See all $count reviews';
  }

  @override
  String reviewsAggregateCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count reviews',
      one: '1 review',
      zero: 'No reviews',
    );
    return '$_temp0';
  }

  @override
  String get reviewsEmptyTitle => 'No reviews yet';

  @override
  String get reviewsEmptySubtitleDetail => 'Be the first to review this place!';

  @override
  String get reviewsListEmptySubtitle =>
      'Be the first to share your experience here.';

  @override
  String get reviewAxisFood => 'Food';

  @override
  String get reviewAxisService => 'Service';

  @override
  String get reviewAxisAmbience => 'Ambience';

  @override
  String get reviewDefaultUserName => 'User';

  @override
  String get reviewReportTooltip => 'Report';

  @override
  String get myReviewsTitle => 'My reviews';

  @override
  String get myReviewsEmptyTitle => 'You haven\'t reviewed any place yet';

  @override
  String get myReviewsEmptySubtitle =>
      'Find your next favorite restaurant! 🍽️';

  @override
  String get reviewDeleteConfirmTitle => 'Delete review?';

  @override
  String get reviewDeleteConfirmBody =>
      'You can review this place again whenever you want.';

  @override
  String get reviewDeleteError => 'Couldn\'t delete.';

  @override
  String get reviewStatusPending => 'Under review';

  @override
  String get reviewStatusHidden => 'Hidden';

  @override
  String get reviewStatusRejected => 'Not approved';

  @override
  String get reviewStatusVisible => 'Published';

  @override
  String get reviewStatusPendingMsg =>
      'Your review is being checked by our team and will appear soon.';

  @override
  String get reviewStatusHiddenMsg =>
      'Your review was hidden. Contact us if you think this was a mistake.';

  @override
  String get reviewStatusRejectedMsg =>
      'Your review was not approved. You can edit and submit it again.';

  @override
  String get reviewFormHeaderEyebrow => 'Review';

  @override
  String get reviewFormDetailLabel => 'Detail your review (optional)';

  @override
  String get reviewFormCommentHint => 'Share your experience...';

  @override
  String get reviewFormSubmit => 'Submit review';

  @override
  String get reviewFormSaveEdits => 'Save changes';

  @override
  String get reviewRating0 => 'Tap to rate';

  @override
  String get reviewRating1 => 'Awful';

  @override
  String get reviewRating2 => 'Poor';

  @override
  String get reviewRating3 => 'Okay';

  @override
  String get reviewRating4 => 'Good';

  @override
  String get reviewRating5 => 'Excellent';

  @override
  String get reviewSubmitSuccess => 'Review published successfully ⭐';

  @override
  String get reviewSubmitPending => 'Your review is under review.';

  @override
  String get reviewSubmitDuplicate =>
      'You\'ve already reviewed this place. Refresh and edit from there.';

  @override
  String get reviewSubmitError => 'Couldn\'t send. Try again.';

  @override
  String get reviewPendingOverlayBody => 'Your review will appear soon.';

  @override
  String get reportTitle => 'Report review';

  @override
  String get reportPrompt => 'Why do you want to report this review?';

  @override
  String get reportNotesHint => 'Tell us what happened...';

  @override
  String get reportSubmit => 'Send report';

  @override
  String get reportError => 'Couldn\'t send report.';

  @override
  String get reportSuccessTitle => 'Report received';

  @override
  String get reportSuccessBody => 'We\'ll review it.';

  @override
  String starsSemantics(int value, int count) {
    return 'Rating: $value out of $count stars';
  }

  @override
  String starsSemanticsLabeled(String label, int value, int count) {
    return '$label: rating $value out of $count stars';
  }

  @override
  String starsDisplaySemantics(String rating) {
    return 'Rating: $rating out of 5';
  }

  @override
  String get authSignInWithGoogle => 'Sign in with Google';

  @override
  String get authSignInWithGoogleShort => 'Sign in with Google';

  @override
  String get authLoginPromptTitle => 'Sign in to save favorites';

  @override
  String get authLoginPromptBody =>
      'Sign in with your Google account to build your list of favorite places in Parintins.';

  @override
  String get dateJustNow => 'just now';

  @override
  String dateMinutesAgo(int count) {
    return '${count}m ago';
  }

  @override
  String dateHoursAgo(int count) {
    return '${count}h ago';
  }

  @override
  String dateDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days ago',
      one: '1 day ago',
    );
    return '$_temp0';
  }

  @override
  String dateWeeksAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count weeks ago',
      one: '1 week ago',
    );
    return '$_temp0';
  }

  @override
  String dateMonthsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count months ago',
      one: '1 month ago',
    );
    return '$_temp0';
  }

  @override
  String dateYearsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count years ago',
      one: '1 year ago',
    );
    return '$_temp0';
  }
}
