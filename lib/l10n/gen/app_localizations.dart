import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];

  /// Nome do app — NÃO traduzir (marca).
  ///
  /// In pt, this message translates to:
  /// **'Sabores de Parintins'**
  String get appTitle;

  /// No description provided for @commonCancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get commonCancel;

  /// No description provided for @commonRetry.
  ///
  /// In pt, this message translates to:
  /// **'Tentar de novo'**
  String get commonRetry;

  /// No description provided for @commonTryAgain.
  ///
  /// In pt, this message translates to:
  /// **'Tentar novamente'**
  String get commonTryAgain;

  /// No description provided for @commonComingSoon.
  ///
  /// In pt, this message translates to:
  /// **'Em breve'**
  String get commonComingSoon;

  /// No description provided for @commonNotNow.
  ///
  /// In pt, this message translates to:
  /// **'Agora não'**
  String get commonNotNow;

  /// No description provided for @commonAllow.
  ///
  /// In pt, this message translates to:
  /// **'Permitir'**
  String get commonAllow;

  /// No description provided for @commonOpen.
  ///
  /// In pt, this message translates to:
  /// **'ABRIR'**
  String get commonOpen;

  /// No description provided for @commonEdit.
  ///
  /// In pt, this message translates to:
  /// **'Editar'**
  String get commonEdit;

  /// No description provided for @commonDelete.
  ///
  /// In pt, this message translates to:
  /// **'Excluir'**
  String get commonDelete;

  /// No description provided for @commonSeeMore.
  ///
  /// In pt, this message translates to:
  /// **'Ver mais'**
  String get commonSeeMore;

  /// No description provided for @commonSeeLess.
  ///
  /// In pt, this message translates to:
  /// **'Ver menos'**
  String get commonSeeLess;

  /// No description provided for @navHome.
  ///
  /// In pt, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navSearch.
  ///
  /// In pt, this message translates to:
  /// **'Buscar'**
  String get navSearch;

  /// No description provided for @navMap.
  ///
  /// In pt, this message translates to:
  /// **'Mapa'**
  String get navMap;

  /// No description provided for @navProfile.
  ///
  /// In pt, this message translates to:
  /// **'Perfil'**
  String get navProfile;

  /// No description provided for @profileTitle.
  ///
  /// In pt, this message translates to:
  /// **'Perfil'**
  String get profileTitle;

  /// No description provided for @profileLanguage.
  ///
  /// In pt, this message translates to:
  /// **'Idioma'**
  String get profileLanguage;

  /// No description provided for @profileLanguageSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Idioma do aplicativo'**
  String get profileLanguageSubtitle;

  /// No description provided for @profileFavorites.
  ///
  /// In pt, this message translates to:
  /// **'Meus favoritos'**
  String get profileFavorites;

  /// No description provided for @profileFavoritesSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Sua lista personalizada'**
  String get profileFavoritesSubtitle;

  /// No description provided for @profileReviews.
  ///
  /// In pt, this message translates to:
  /// **'Minhas avaliações'**
  String get profileReviews;

  /// No description provided for @profileReviewsSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Suas avaliações por aqui'**
  String get profileReviewsSubtitle;

  /// No description provided for @profileSettings.
  ///
  /// In pt, this message translates to:
  /// **'Configurações'**
  String get profileSettings;

  /// No description provided for @profileSettingsSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Em breve'**
  String get profileSettingsSubtitle;

  /// No description provided for @profileSignOut.
  ///
  /// In pt, this message translates to:
  /// **'Sair'**
  String get profileSignOut;

  /// No description provided for @profileSignOutConfirmTitle.
  ///
  /// In pt, this message translates to:
  /// **'Sair da conta?'**
  String get profileSignOutConfirmTitle;

  /// No description provided for @profileSignOutConfirmBody.
  ///
  /// In pt, this message translates to:
  /// **'Você precisará entrar de novo pra usar os recursos personalizados.'**
  String get profileSignOutConfirmBody;

  /// No description provided for @profileSignOutCancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get profileSignOutCancel;

  /// No description provided for @profileSignOutConfirm.
  ///
  /// In pt, this message translates to:
  /// **'Sair'**
  String get profileSignOutConfirm;

  /// No description provided for @profileSignedOutToast.
  ///
  /// In pt, this message translates to:
  /// **'Você saiu.'**
  String get profileSignedOutToast;

  /// No description provided for @profileLoggedOutHeadline.
  ///
  /// In pt, this message translates to:
  /// **'Entre pra ter uma experiência personalizada'**
  String get profileLoggedOutHeadline;

  /// No description provided for @profileLoggedOutBody.
  ///
  /// In pt, this message translates to:
  /// **'Salve favoritos, faça avaliações e muito mais.'**
  String get profileLoggedOutBody;

  /// No description provided for @profileLoggedOutTerms.
  ///
  /// In pt, this message translates to:
  /// **'Ao continuar você aceita nossos Termos de Uso e Política de Privacidade.'**
  String get profileLoggedOutTerms;

  /// No description provided for @languagePickerTitle.
  ///
  /// In pt, this message translates to:
  /// **'Idioma'**
  String get languagePickerTitle;

  /// No description provided for @languageSystemDefault.
  ///
  /// In pt, this message translates to:
  /// **'Padrão do sistema'**
  String get languageSystemDefault;

  /// No description provided for @languageSystemDefaultSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Usar o idioma do celular'**
  String get languageSystemDefaultSubtitle;

  /// No description provided for @languagePortuguese.
  ///
  /// In pt, this message translates to:
  /// **'Português (Brasil)'**
  String get languagePortuguese;

  /// No description provided for @languageEnglish.
  ///
  /// In pt, this message translates to:
  /// **'Inglês'**
  String get languageEnglish;

  /// No description provided for @languageSpanish.
  ///
  /// In pt, this message translates to:
  /// **'Espanhol'**
  String get languageSpanish;

  /// No description provided for @homeSearchHint.
  ///
  /// In pt, this message translates to:
  /// **'Busque por restaurante, prato ou categoria'**
  String get homeSearchHint;

  /// No description provided for @homeCategoriesTitle.
  ///
  /// In pt, this message translates to:
  /// **'Categorias'**
  String get homeCategoriesTitle;

  /// No description provided for @homeCategoryAll.
  ///
  /// In pt, this message translates to:
  /// **'Todos'**
  String get homeCategoryAll;

  /// No description provided for @homeCategoriesError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível carregar categorias'**
  String get homeCategoriesError;

  /// No description provided for @homeEstablishmentsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Estabelecimentos'**
  String get homeEstablishmentsTitle;

  /// No description provided for @homeEstablishmentsError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar estabelecimentos'**
  String get homeEstablishmentsError;

  /// No description provided for @homeEstablishmentsEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum estabelecimento encontrado'**
  String get homeEstablishmentsEmpty;

  /// No description provided for @bannerHeadline.
  ///
  /// In pt, this message translates to:
  /// **'Sabores Garantidos'**
  String get bannerHeadline;

  /// No description provided for @bannerSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Descubra os destaques de Parintins'**
  String get bannerSubtitle;

  /// No description provided for @favoritesTitle.
  ///
  /// In pt, this message translates to:
  /// **'Meus favoritos'**
  String get favoritesTitle;

  /// No description provided for @favoritesEmptyTitle.
  ///
  /// In pt, this message translates to:
  /// **'Você ainda não tem favoritos'**
  String get favoritesEmptyTitle;

  /// No description provided for @favoritesEmptySubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Toque no coração nos estabelecimentos pra salvar aqui.'**
  String get favoritesEmptySubtitle;

  /// No description provided for @favoriteAddSemantics.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar aos favoritos'**
  String get favoriteAddSemantics;

  /// No description provided for @favoriteRemoveSemantics.
  ///
  /// In pt, this message translates to:
  /// **'Remover dos favoritos'**
  String get favoriteRemoveSemantics;

  /// No description provided for @favoriteToggleError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao salvar favorito. Tente novamente.'**
  String get favoriteToggleError;

  /// No description provided for @statusOpen.
  ///
  /// In pt, this message translates to:
  /// **'Aberto'**
  String get statusOpen;

  /// No description provided for @statusClosed.
  ///
  /// In pt, this message translates to:
  /// **'Fechado'**
  String get statusClosed;

  /// No description provided for @statusOpenNow.
  ///
  /// In pt, this message translates to:
  /// **'Aberto agora'**
  String get statusOpenNow;

  /// No description provided for @detailSectionAbout.
  ///
  /// In pt, this message translates to:
  /// **'Sobre'**
  String get detailSectionAbout;

  /// No description provided for @detailSectionHours.
  ///
  /// In pt, this message translates to:
  /// **'Horários'**
  String get detailSectionHours;

  /// No description provided for @detailSectionAddress.
  ///
  /// In pt, this message translates to:
  /// **'Endereço'**
  String get detailSectionAddress;

  /// No description provided for @detailSectionAmenities.
  ///
  /// In pt, this message translates to:
  /// **'Comodidades'**
  String get detailSectionAmenities;

  /// No description provided for @detailDescriptionEmpty.
  ///
  /// In pt, this message translates to:
  /// **'O estabelecimento ainda não adicionou uma descrição.'**
  String get detailDescriptionEmpty;

  /// No description provided for @detailErrorTitle.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível carregar este estabelecimento.'**
  String get detailErrorTitle;

  /// No description provided for @hoursEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Horários não informados pelo estabelecimento'**
  String get hoursEmpty;

  /// No description provided for @amenitiesEmpty.
  ///
  /// In pt, this message translates to:
  /// **'Sem comodidades cadastradas'**
  String get amenitiesEmpty;

  /// No description provided for @addressNotProvided.
  ///
  /// In pt, this message translates to:
  /// **'Endereço não informado'**
  String get addressNotProvided;

  /// No description provided for @addressOpenMap.
  ///
  /// In pt, this message translates to:
  /// **'Abrir no Mapa'**
  String get addressOpenMap;

  /// No description provided for @actionWhatsApp.
  ///
  /// In pt, this message translates to:
  /// **'WhatsApp'**
  String get actionWhatsApp;

  /// No description provided for @actionInstagram.
  ///
  /// In pt, this message translates to:
  /// **'Instagram'**
  String get actionInstagram;

  /// No description provided for @actionMap.
  ///
  /// In pt, this message translates to:
  /// **'Mapa'**
  String get actionMap;

  /// No description provided for @actionShare.
  ///
  /// In pt, this message translates to:
  /// **'Compartilhar'**
  String get actionShare;

  /// No description provided for @actionWhatsAppMissing.
  ///
  /// In pt, this message translates to:
  /// **'Este estabelecimento ainda não configurou o WhatsApp.'**
  String get actionWhatsAppMissing;

  /// No description provided for @actionInstagramMissing.
  ///
  /// In pt, this message translates to:
  /// **'Este estabelecimento ainda não configurou o Instagram.'**
  String get actionInstagramMissing;

  /// No description provided for @actionLocationMissing.
  ///
  /// In pt, this message translates to:
  /// **'Localização não disponível.'**
  String get actionLocationMissing;

  /// No description provided for @actionOpenUrlError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível abrir: {url}'**
  String actionOpenUrlError(String url);

  /// No description provided for @actionGenericError.
  ///
  /// In pt, this message translates to:
  /// **'Erro: {error}'**
  String actionGenericError(String error);

  /// No description provided for @actionWhatsAppGreeting.
  ///
  /// In pt, this message translates to:
  /// **'Olá! Vi vocês no Sabores de Parintins.'**
  String get actionWhatsAppGreeting;

  /// No description provided for @actionShareText.
  ///
  /// In pt, this message translates to:
  /// **'Confira {name} no Sabores de Parintins!'**
  String actionShareText(String name);

  /// No description provided for @actionShareError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao compartilhar: {error}'**
  String actionShareError(String error);

  /// No description provided for @mapShowingCount.
  ///
  /// In pt, this message translates to:
  /// **'Mostrando {shown} de {total} estabelecimentos'**
  String mapShowingCount(int shown, int total);

  /// No description provided for @mapNoLocations.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum estabelecimento com localização cadastrada.'**
  String get mapNoLocations;

  /// No description provided for @mapDistanceMeters.
  ///
  /// In pt, this message translates to:
  /// **'{meters} m daqui'**
  String mapDistanceMeters(int meters);

  /// No description provided for @mapDistanceKilometers.
  ///
  /// In pt, this message translates to:
  /// **'{km} km daqui'**
  String mapDistanceKilometers(String km);

  /// No description provided for @mapViewDetails.
  ///
  /// In pt, this message translates to:
  /// **'Ver detalhes →'**
  String get mapViewDetails;

  /// No description provided for @locationGpsDisabled.
  ///
  /// In pt, this message translates to:
  /// **'GPS desligado. Ative a localização do celular.'**
  String get locationGpsDisabled;

  /// No description provided for @locationFailed.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível obter sua localização.'**
  String get locationFailed;

  /// No description provided for @locationDialogTitle.
  ///
  /// In pt, this message translates to:
  /// **'Permitir acesso à localização?'**
  String get locationDialogTitle;

  /// No description provided for @locationDialogBody.
  ///
  /// In pt, this message translates to:
  /// **'Pra mostrar estabelecimentos próximos no mapa e calcular a distância, precisamos da sua localização.'**
  String get locationDialogBody;

  /// No description provided for @locationDeniedForever.
  ///
  /// In pt, this message translates to:
  /// **'Permissão negada permanentemente. Ative nas configurações.'**
  String get locationDeniedForever;

  /// No description provided for @reviewsSectionTitle.
  ///
  /// In pt, this message translates to:
  /// **'Avaliações'**
  String get reviewsSectionTitle;

  /// No description provided for @reviewActionAdd.
  ///
  /// In pt, this message translates to:
  /// **'Avaliar este lugar'**
  String get reviewActionAdd;

  /// No description provided for @reviewActionEdit.
  ///
  /// In pt, this message translates to:
  /// **'Editar minha avaliação'**
  String get reviewActionEdit;

  /// No description provided for @reviewSeeAll.
  ///
  /// In pt, this message translates to:
  /// **'Ver todas as {count} avaliações'**
  String reviewSeeAll(int count);

  /// No description provided for @reviewsAggregateCount.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =0{Sem avaliações} =1{1 avaliação} other{{count} avaliações}}'**
  String reviewsAggregateCount(int count);

  /// No description provided for @reviewsEmptyTitle.
  ///
  /// In pt, this message translates to:
  /// **'Ainda não há avaliações'**
  String get reviewsEmptyTitle;

  /// No description provided for @reviewsEmptySubtitleDetail.
  ///
  /// In pt, this message translates to:
  /// **'Seja o primeiro a avaliar este lugar!'**
  String get reviewsEmptySubtitleDetail;

  /// No description provided for @reviewsListEmptySubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Seja o primeiro a contar como foi sua experiência por aqui.'**
  String get reviewsListEmptySubtitle;

  /// No description provided for @reviewAxisFood.
  ///
  /// In pt, this message translates to:
  /// **'Comida'**
  String get reviewAxisFood;

  /// No description provided for @reviewAxisService.
  ///
  /// In pt, this message translates to:
  /// **'Atendimento'**
  String get reviewAxisService;

  /// No description provided for @reviewAxisAmbience.
  ///
  /// In pt, this message translates to:
  /// **'Ambiente'**
  String get reviewAxisAmbience;

  /// No description provided for @reviewDefaultUserName.
  ///
  /// In pt, this message translates to:
  /// **'Usuário'**
  String get reviewDefaultUserName;

  /// No description provided for @reviewReportTooltip.
  ///
  /// In pt, this message translates to:
  /// **'Denunciar'**
  String get reviewReportTooltip;

  /// No description provided for @myReviewsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Minhas avaliações'**
  String get myReviewsTitle;

  /// No description provided for @myReviewsEmptyTitle.
  ///
  /// In pt, this message translates to:
  /// **'Você ainda não avaliou nenhum lugar'**
  String get myReviewsEmptyTitle;

  /// No description provided for @myReviewsEmptySubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Encontre seu próximo restaurante favorito! 🍽️'**
  String get myReviewsEmptySubtitle;

  /// No description provided for @reviewDeleteConfirmTitle.
  ///
  /// In pt, this message translates to:
  /// **'Excluir avaliação?'**
  String get reviewDeleteConfirmTitle;

  /// No description provided for @reviewDeleteConfirmBody.
  ///
  /// In pt, this message translates to:
  /// **'Você poderá avaliar este estabelecimento novamente quando quiser.'**
  String get reviewDeleteConfirmBody;

  /// No description provided for @reviewDeleteError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao excluir.'**
  String get reviewDeleteError;

  /// No description provided for @reviewStatusPending.
  ///
  /// In pt, this message translates to:
  /// **'Em análise'**
  String get reviewStatusPending;

  /// No description provided for @reviewStatusHidden.
  ///
  /// In pt, this message translates to:
  /// **'Oculta'**
  String get reviewStatusHidden;

  /// No description provided for @reviewStatusRejected.
  ///
  /// In pt, this message translates to:
  /// **'Não aprovada'**
  String get reviewStatusRejected;

  /// No description provided for @reviewStatusVisible.
  ///
  /// In pt, this message translates to:
  /// **'Publicada'**
  String get reviewStatusVisible;

  /// No description provided for @reviewStatusPendingMsg.
  ///
  /// In pt, this message translates to:
  /// **'Sua avaliação está sendo analisada por nossa equipe e aparecerá em breve.'**
  String get reviewStatusPendingMsg;

  /// No description provided for @reviewStatusHiddenMsg.
  ///
  /// In pt, this message translates to:
  /// **'Sua avaliação foi ocultada. Entre em contato conosco se acha que foi um engano.'**
  String get reviewStatusHiddenMsg;

  /// No description provided for @reviewStatusRejectedMsg.
  ///
  /// In pt, this message translates to:
  /// **'Sua avaliação não foi aprovada. Você pode editar e enviá-la novamente.'**
  String get reviewStatusRejectedMsg;

  /// No description provided for @reviewFormHeaderEyebrow.
  ///
  /// In pt, this message translates to:
  /// **'Avaliar'**
  String get reviewFormHeaderEyebrow;

  /// No description provided for @reviewFormDetailLabel.
  ///
  /// In pt, this message translates to:
  /// **'Detalhe sua avaliação (opcional)'**
  String get reviewFormDetailLabel;

  /// No description provided for @reviewFormCommentHint.
  ///
  /// In pt, this message translates to:
  /// **'Conte sua experiência...'**
  String get reviewFormCommentHint;

  /// No description provided for @reviewFormSubmit.
  ///
  /// In pt, this message translates to:
  /// **'Enviar avaliação'**
  String get reviewFormSubmit;

  /// No description provided for @reviewFormSaveEdits.
  ///
  /// In pt, this message translates to:
  /// **'Salvar alterações'**
  String get reviewFormSaveEdits;

  /// No description provided for @reviewRating0.
  ///
  /// In pt, this message translates to:
  /// **'Toque pra avaliar'**
  String get reviewRating0;

  /// No description provided for @reviewRating1.
  ///
  /// In pt, this message translates to:
  /// **'Péssimo'**
  String get reviewRating1;

  /// No description provided for @reviewRating2.
  ///
  /// In pt, this message translates to:
  /// **'Ruim'**
  String get reviewRating2;

  /// No description provided for @reviewRating3.
  ///
  /// In pt, this message translates to:
  /// **'Regular'**
  String get reviewRating3;

  /// No description provided for @reviewRating4.
  ///
  /// In pt, this message translates to:
  /// **'Bom'**
  String get reviewRating4;

  /// No description provided for @reviewRating5.
  ///
  /// In pt, this message translates to:
  /// **'Ótimo'**
  String get reviewRating5;

  /// No description provided for @reviewSubmitSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Avaliação publicada com sucesso ⭐'**
  String get reviewSubmitSuccess;

  /// No description provided for @reviewSubmitPending.
  ///
  /// In pt, this message translates to:
  /// **'Sua avaliação está em análise.'**
  String get reviewSubmitPending;

  /// No description provided for @reviewSubmitDuplicate.
  ///
  /// In pt, this message translates to:
  /// **'Você já avaliou esse lugar. Atualize a tela e edite a partir dela.'**
  String get reviewSubmitDuplicate;

  /// No description provided for @reviewSubmitError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao enviar. Tente de novo.'**
  String get reviewSubmitError;

  /// No description provided for @reviewPendingOverlayBody.
  ///
  /// In pt, this message translates to:
  /// **'Sua avaliação aparecerá em breve.'**
  String get reviewPendingOverlayBody;

  /// No description provided for @reportTitle.
  ///
  /// In pt, this message translates to:
  /// **'Denunciar avaliação'**
  String get reportTitle;

  /// No description provided for @reportPrompt.
  ///
  /// In pt, this message translates to:
  /// **'Por que você quer denunciar essa avaliação?'**
  String get reportPrompt;

  /// No description provided for @reportNotesHint.
  ///
  /// In pt, this message translates to:
  /// **'Conte o que aconteceu...'**
  String get reportNotesHint;

  /// No description provided for @reportSubmit.
  ///
  /// In pt, this message translates to:
  /// **'Enviar denúncia'**
  String get reportSubmit;

  /// No description provided for @reportError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao enviar denúncia.'**
  String get reportError;

  /// No description provided for @reportSuccessTitle.
  ///
  /// In pt, this message translates to:
  /// **'Denúncia recebida'**
  String get reportSuccessTitle;

  /// No description provided for @reportSuccessBody.
  ///
  /// In pt, this message translates to:
  /// **'Vamos analisar.'**
  String get reportSuccessBody;

  /// No description provided for @starsSemantics.
  ///
  /// In pt, this message translates to:
  /// **'Nota: {value} de {count} estrelas'**
  String starsSemantics(int value, int count);

  /// No description provided for @starsSemanticsLabeled.
  ///
  /// In pt, this message translates to:
  /// **'{label}: nota {value} de {count} estrelas'**
  String starsSemanticsLabeled(String label, int value, int count);

  /// No description provided for @starsDisplaySemantics.
  ///
  /// In pt, this message translates to:
  /// **'Nota: {rating} de 5'**
  String starsDisplaySemantics(String rating);

  /// No description provided for @authSignInWithGoogle.
  ///
  /// In pt, this message translates to:
  /// **'Entre com Google'**
  String get authSignInWithGoogle;

  /// No description provided for @authSignInWithGoogleShort.
  ///
  /// In pt, this message translates to:
  /// **'Entrar com Google'**
  String get authSignInWithGoogleShort;

  /// No description provided for @authLoginPromptTitle.
  ///
  /// In pt, this message translates to:
  /// **'Faça login pra salvar favoritos'**
  String get authLoginPromptTitle;

  /// No description provided for @authLoginPromptBody.
  ///
  /// In pt, this message translates to:
  /// **'Entre com sua conta Google pra montar sua lista de lugares favoritos em Parintins.'**
  String get authLoginPromptBody;

  /// No description provided for @dateJustNow.
  ///
  /// In pt, this message translates to:
  /// **'agora há pouco'**
  String get dateJustNow;

  /// No description provided for @dateMinutesAgo.
  ///
  /// In pt, this message translates to:
  /// **'há {count} min'**
  String dateMinutesAgo(int count);

  /// No description provided for @dateHoursAgo.
  ///
  /// In pt, this message translates to:
  /// **'há {count}h'**
  String dateHoursAgo(int count);

  /// No description provided for @dateDaysAgo.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{há 1 dia} other{há {count} dias}}'**
  String dateDaysAgo(int count);

  /// No description provided for @dateWeeksAgo.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{há 1 semana} other{há {count} semanas}}'**
  String dateWeeksAgo(int count);

  /// No description provided for @dateMonthsAgo.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{há 1 mês} other{há {count} meses}}'**
  String dateMonthsAgo(int count);

  /// No description provided for @dateYearsAgo.
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =1{há 1 ano} other{há {count} anos}}'**
  String dateYearsAgo(int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
