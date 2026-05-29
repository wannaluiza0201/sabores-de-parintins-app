// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Sabores de Parintins';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonRetry => 'Tentar de novo';

  @override
  String get commonTryAgain => 'Tentar novamente';

  @override
  String get commonComingSoon => 'Em breve';

  @override
  String get commonNotNow => 'Agora não';

  @override
  String get commonAllow => 'Permitir';

  @override
  String get commonOpen => 'ABRIR';

  @override
  String get commonEdit => 'Editar';

  @override
  String get commonDelete => 'Excluir';

  @override
  String get commonSeeMore => 'Ver mais';

  @override
  String get commonSeeLess => 'Ver menos';

  @override
  String get navHome => 'Home';

  @override
  String get navSearch => 'Buscar';

  @override
  String get navMap => 'Mapa';

  @override
  String get navProfile => 'Perfil';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get profileLanguage => 'Idioma';

  @override
  String get profileLanguageSubtitle => 'Idioma do aplicativo';

  @override
  String get profileFavorites => 'Meus favoritos';

  @override
  String get profileFavoritesSubtitle => 'Sua lista personalizada';

  @override
  String get profileReviews => 'Minhas avaliações';

  @override
  String get profileReviewsSubtitle => 'Suas avaliações por aqui';

  @override
  String get profileSettings => 'Configurações';

  @override
  String get profileSettingsSubtitle => 'Em breve';

  @override
  String get profileSignOut => 'Sair';

  @override
  String get profileSignOutConfirmTitle => 'Sair da conta?';

  @override
  String get profileSignOutConfirmBody =>
      'Você precisará entrar de novo pra usar os recursos personalizados.';

  @override
  String get profileSignOutCancel => 'Cancelar';

  @override
  String get profileSignOutConfirm => 'Sair';

  @override
  String get profileSignedOutToast => 'Você saiu.';

  @override
  String get profileLoggedOutHeadline =>
      'Entre pra ter uma experiência personalizada';

  @override
  String get profileLoggedOutBody =>
      'Salve favoritos, faça avaliações e muito mais.';

  @override
  String get profileLoggedOutTerms =>
      'Ao continuar você aceita nossos Termos de Uso e Política de Privacidade.';

  @override
  String get languagePickerTitle => 'Idioma';

  @override
  String get languageSystemDefault => 'Padrão do sistema';

  @override
  String get languageSystemDefaultSubtitle => 'Usar o idioma do celular';

  @override
  String get languagePortuguese => 'Português (Brasil)';

  @override
  String get languageEnglish => 'Inglês';

  @override
  String get languageSpanish => 'Espanhol';

  @override
  String get homeSearchHint => 'Busque por restaurante, prato ou categoria';

  @override
  String get homeCategoriesTitle => 'Categorias';

  @override
  String get homeCategoryAll => 'Todos';

  @override
  String get homeCategoriesError => 'Não foi possível carregar categorias';

  @override
  String get homeEstablishmentsTitle => 'Estabelecimentos';

  @override
  String get homeEstablishmentsError => 'Erro ao carregar estabelecimentos';

  @override
  String get homeEstablishmentsEmpty => 'Nenhum estabelecimento encontrado';

  @override
  String get bannerHeadline => 'Sabores Garantidos';

  @override
  String get bannerSubtitle => 'Descubra os destaques de Parintins';

  @override
  String get favoritesTitle => 'Meus favoritos';

  @override
  String get favoritesEmptyTitle => 'Você ainda não tem favoritos';

  @override
  String get favoritesEmptySubtitle =>
      'Toque no coração nos estabelecimentos pra salvar aqui.';

  @override
  String get favoriteAddSemantics => 'Adicionar aos favoritos';

  @override
  String get favoriteRemoveSemantics => 'Remover dos favoritos';

  @override
  String get favoriteToggleError => 'Erro ao salvar favorito. Tente novamente.';

  @override
  String get statusOpen => 'Aberto';

  @override
  String get statusClosed => 'Fechado';

  @override
  String get statusOpenNow => 'Aberto agora';

  @override
  String get detailSectionAbout => 'Sobre';

  @override
  String get detailSectionHours => 'Horários';

  @override
  String get detailSectionAddress => 'Endereço';

  @override
  String get detailSectionAmenities => 'Comodidades';

  @override
  String get detailDescriptionEmpty =>
      'O estabelecimento ainda não adicionou uma descrição.';

  @override
  String get detailErrorTitle =>
      'Não foi possível carregar este estabelecimento.';

  @override
  String get hoursEmpty => 'Horários não informados pelo estabelecimento';

  @override
  String get amenitiesEmpty => 'Sem comodidades cadastradas';

  @override
  String get addressNotProvided => 'Endereço não informado';

  @override
  String get addressOpenMap => 'Abrir no Mapa';

  @override
  String get actionWhatsApp => 'WhatsApp';

  @override
  String get actionInstagram => 'Instagram';

  @override
  String get actionMap => 'Mapa';

  @override
  String get actionShare => 'Compartilhar';

  @override
  String get actionWhatsAppMissing =>
      'Este estabelecimento ainda não configurou o WhatsApp.';

  @override
  String get actionInstagramMissing =>
      'Este estabelecimento ainda não configurou o Instagram.';

  @override
  String get actionLocationMissing => 'Localização não disponível.';

  @override
  String actionOpenUrlError(String url) {
    return 'Não foi possível abrir: $url';
  }

  @override
  String actionGenericError(String error) {
    return 'Erro: $error';
  }

  @override
  String get actionWhatsAppGreeting => 'Olá! Vi vocês no Sabores de Parintins.';

  @override
  String actionShareText(String name) {
    return 'Confira $name no Sabores de Parintins!';
  }

  @override
  String actionShareError(String error) {
    return 'Erro ao compartilhar: $error';
  }

  @override
  String mapShowingCount(int shown, int total) {
    return 'Mostrando $shown de $total estabelecimentos';
  }

  @override
  String get mapNoLocations =>
      'Nenhum estabelecimento com localização cadastrada.';

  @override
  String mapDistanceMeters(int meters) {
    return '$meters m daqui';
  }

  @override
  String mapDistanceKilometers(String km) {
    return '$km km daqui';
  }

  @override
  String get mapViewDetails => 'Ver detalhes →';

  @override
  String get locationGpsDisabled =>
      'GPS desligado. Ative a localização do celular.';

  @override
  String get locationFailed => 'Não foi possível obter sua localização.';

  @override
  String get locationDialogTitle => 'Permitir acesso à localização?';

  @override
  String get locationDialogBody =>
      'Pra mostrar estabelecimentos próximos no mapa e calcular a distância, precisamos da sua localização.';

  @override
  String get locationDeniedForever =>
      'Permissão negada permanentemente. Ative nas configurações.';

  @override
  String get reviewsSectionTitle => 'Avaliações';

  @override
  String get reviewActionAdd => 'Avaliar este lugar';

  @override
  String get reviewActionEdit => 'Editar minha avaliação';

  @override
  String reviewSeeAll(int count) {
    return 'Ver todas as $count avaliações';
  }

  @override
  String reviewsAggregateCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count avaliações',
      one: '1 avaliação',
      zero: 'Sem avaliações',
    );
    return '$_temp0';
  }

  @override
  String get reviewsEmptyTitle => 'Ainda não há avaliações';

  @override
  String get reviewsEmptySubtitleDetail =>
      'Seja o primeiro a avaliar este lugar!';

  @override
  String get reviewsListEmptySubtitle =>
      'Seja o primeiro a contar como foi sua experiência por aqui.';

  @override
  String get reviewAxisFood => 'Comida';

  @override
  String get reviewAxisService => 'Atendimento';

  @override
  String get reviewAxisAmbience => 'Ambiente';

  @override
  String get reviewDefaultUserName => 'Usuário';

  @override
  String get reviewReportTooltip => 'Denunciar';

  @override
  String get myReviewsTitle => 'Minhas avaliações';

  @override
  String get myReviewsEmptyTitle => 'Você ainda não avaliou nenhum lugar';

  @override
  String get myReviewsEmptySubtitle =>
      'Encontre seu próximo restaurante favorito! 🍽️';

  @override
  String get reviewDeleteConfirmTitle => 'Excluir avaliação?';

  @override
  String get reviewDeleteConfirmBody =>
      'Você poderá avaliar este estabelecimento novamente quando quiser.';

  @override
  String get reviewDeleteError => 'Erro ao excluir.';

  @override
  String get reviewStatusPending => 'Em análise';

  @override
  String get reviewStatusHidden => 'Oculta';

  @override
  String get reviewStatusRejected => 'Não aprovada';

  @override
  String get reviewStatusVisible => 'Publicada';

  @override
  String get reviewStatusPendingMsg =>
      'Sua avaliação está sendo analisada por nossa equipe e aparecerá em breve.';

  @override
  String get reviewStatusHiddenMsg =>
      'Sua avaliação foi ocultada. Entre em contato conosco se acha que foi um engano.';

  @override
  String get reviewStatusRejectedMsg =>
      'Sua avaliação não foi aprovada. Você pode editar e enviá-la novamente.';

  @override
  String get reviewFormHeaderEyebrow => 'Avaliar';

  @override
  String get reviewFormDetailLabel => 'Detalhe sua avaliação (opcional)';

  @override
  String get reviewFormCommentHint => 'Conte sua experiência...';

  @override
  String get reviewFormSubmit => 'Enviar avaliação';

  @override
  String get reviewFormSaveEdits => 'Salvar alterações';

  @override
  String get reviewRating0 => 'Toque pra avaliar';

  @override
  String get reviewRating1 => 'Péssimo';

  @override
  String get reviewRating2 => 'Ruim';

  @override
  String get reviewRating3 => 'Regular';

  @override
  String get reviewRating4 => 'Bom';

  @override
  String get reviewRating5 => 'Ótimo';

  @override
  String get reviewSubmitSuccess => 'Avaliação publicada com sucesso ⭐';

  @override
  String get reviewSubmitPending => 'Sua avaliação está em análise.';

  @override
  String get reviewSubmitDuplicate =>
      'Você já avaliou esse lugar. Atualize a tela e edite a partir dela.';

  @override
  String get reviewSubmitError => 'Erro ao enviar. Tente de novo.';

  @override
  String get reviewPendingOverlayBody => 'Sua avaliação aparecerá em breve.';

  @override
  String get reportTitle => 'Denunciar avaliação';

  @override
  String get reportPrompt => 'Por que você quer denunciar essa avaliação?';

  @override
  String get reportNotesHint => 'Conte o que aconteceu...';

  @override
  String get reportSubmit => 'Enviar denúncia';

  @override
  String get reportError => 'Erro ao enviar denúncia.';

  @override
  String get reportSuccessTitle => 'Denúncia recebida';

  @override
  String get reportSuccessBody => 'Vamos analisar.';

  @override
  String starsSemantics(int value, int count) {
    return 'Nota: $value de $count estrelas';
  }

  @override
  String starsSemanticsLabeled(String label, int value, int count) {
    return '$label: nota $value de $count estrelas';
  }

  @override
  String starsDisplaySemantics(String rating) {
    return 'Nota: $rating de 5';
  }

  @override
  String get authSignInWithGoogle => 'Entre com Google';

  @override
  String get authSignInWithGoogleShort => 'Entrar com Google';

  @override
  String get authLoginPromptTitle => 'Faça login pra salvar favoritos';

  @override
  String get authLoginPromptBody =>
      'Entre com sua conta Google pra montar sua lista de lugares favoritos em Parintins.';

  @override
  String get dateJustNow => 'agora há pouco';

  @override
  String dateMinutesAgo(int count) {
    return 'há $count min';
  }

  @override
  String dateHoursAgo(int count) {
    return 'há ${count}h';
  }

  @override
  String dateDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'há $count dias',
      one: 'há 1 dia',
    );
    return '$_temp0';
  }

  @override
  String dateWeeksAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'há $count semanas',
      one: 'há 1 semana',
    );
    return '$_temp0';
  }

  @override
  String dateMonthsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'há $count meses',
      one: 'há 1 mês',
    );
    return '$_temp0';
  }

  @override
  String dateYearsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'há $count anos',
      one: 'há 1 ano',
    );
    return '$_temp0';
  }
}
