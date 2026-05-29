// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Sabores de Parintins';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonRetry => 'Intentar de nuevo';

  @override
  String get commonTryAgain => 'Intentar de nuevo';

  @override
  String get commonComingSoon => 'Próximamente';

  @override
  String get commonNotNow => 'Ahora no';

  @override
  String get commonAllow => 'Permitir';

  @override
  String get commonOpen => 'ABRIR';

  @override
  String get commonEdit => 'Editar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonSeeMore => 'Ver más';

  @override
  String get commonSeeLess => 'Ver menos';

  @override
  String get navHome => 'Inicio';

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
  String get profileLanguageSubtitle => 'Idioma de la aplicación';

  @override
  String get profileFavorites => 'Mis favoritos';

  @override
  String get profileFavoritesSubtitle => 'Tu lista personal';

  @override
  String get profileReviews => 'Mis reseñas';

  @override
  String get profileReviewsSubtitle => 'Tus reseñas aquí';

  @override
  String get profileSettings => 'Ajustes';

  @override
  String get profileSettingsSubtitle => 'Próximamente';

  @override
  String get profileSignOut => 'Cerrar sesión';

  @override
  String get profileSignOutConfirmTitle => '¿Cerrar sesión?';

  @override
  String get profileSignOutConfirmBody =>
      'Tendrás que iniciar sesión de nuevo para usar las funciones personalizadas.';

  @override
  String get profileSignOutCancel => 'Cancelar';

  @override
  String get profileSignOutConfirm => 'Cerrar sesión';

  @override
  String get profileSignedOutToast => 'Sesión cerrada.';

  @override
  String get profileLoggedOutHeadline =>
      'Inicia sesión para una experiencia personalizada';

  @override
  String get profileLoggedOutBody =>
      'Guarda favoritos, deja reseñas y mucho más.';

  @override
  String get profileLoggedOutTerms =>
      'Al continuar, aceptas nuestros Términos de Uso y Política de Privacidad.';

  @override
  String get languagePickerTitle => 'Idioma';

  @override
  String get languageSystemDefault => 'Predeterminado del sistema';

  @override
  String get languageSystemDefaultSubtitle => 'Usar el idioma del teléfono';

  @override
  String get languagePortuguese => 'Portugués (Brasil)';

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get languageSpanish => 'Español';

  @override
  String get homeSearchHint => 'Busca restaurantes, platos o categorías';

  @override
  String get homeCategoriesTitle => 'Categorías';

  @override
  String get homeCategoryAll => 'Todos';

  @override
  String get homeCategoriesError => 'No se pudieron cargar las categorías';

  @override
  String get homeEstablishmentsTitle => 'Lugares';

  @override
  String get homeEstablishmentsError => 'No se pudieron cargar los lugares';

  @override
  String get homeEstablishmentsEmpty => 'No se encontraron lugares';

  @override
  String get bannerHeadline => 'Sabores destacados';

  @override
  String get bannerSubtitle => 'Descubre lo mejor de Parintins';

  @override
  String get favoritesTitle => 'Mis favoritos';

  @override
  String get favoritesEmptyTitle => 'Aún no tienes favoritos';

  @override
  String get favoritesEmptySubtitle =>
      'Toca el corazón en los lugares para guardarlos aquí.';

  @override
  String get favoriteAddSemantics => 'Añadir a favoritos';

  @override
  String get favoriteRemoveSemantics => 'Quitar de favoritos';

  @override
  String get favoriteToggleError => 'No se pudo guardar. Intenta de nuevo.';

  @override
  String get statusOpen => 'Abierto';

  @override
  String get statusClosed => 'Cerrado';

  @override
  String get statusOpenNow => 'Abierto ahora';

  @override
  String get detailSectionAbout => 'Acerca de';

  @override
  String get detailSectionHours => 'Horarios';

  @override
  String get detailSectionAddress => 'Dirección';

  @override
  String get detailSectionAmenities => 'Servicios';

  @override
  String get detailDescriptionEmpty =>
      'El lugar aún no ha agregado una descripción.';

  @override
  String get detailErrorTitle => 'No se pudo cargar este lugar.';

  @override
  String get hoursEmpty => 'El lugar no informó sus horarios';

  @override
  String get amenitiesEmpty => 'Sin servicios registrados';

  @override
  String get addressNotProvided => 'Dirección no informada';

  @override
  String get addressOpenMap => 'Abrir en Mapas';

  @override
  String get actionWhatsApp => 'WhatsApp';

  @override
  String get actionInstagram => 'Instagram';

  @override
  String get actionMap => 'Mapa';

  @override
  String get actionShare => 'Compartir';

  @override
  String get actionWhatsAppMissing => 'Este lugar aún no configuró WhatsApp.';

  @override
  String get actionInstagramMissing => 'Este lugar aún no configuró Instagram.';

  @override
  String get actionLocationMissing => 'Ubicación no disponible.';

  @override
  String actionOpenUrlError(String url) {
    return 'No se pudo abrir: $url';
  }

  @override
  String actionGenericError(String error) {
    return 'Error: $error';
  }

  @override
  String get actionWhatsAppGreeting => '¡Hola! Los vi en Sabores de Parintins.';

  @override
  String actionShareText(String name) {
    return '¡Mira $name en Sabores de Parintins!';
  }

  @override
  String actionShareError(String error) {
    return 'Error al compartir: $error';
  }

  @override
  String mapShowingCount(int shown, int total) {
    return 'Mostrando $shown de $total lugares';
  }

  @override
  String get mapNoLocations => 'Ningún lugar con ubicación registrada.';

  @override
  String mapDistanceMeters(int meters) {
    return '$meters m desde aquí';
  }

  @override
  String mapDistanceKilometers(String km) {
    return '$km km desde aquí';
  }

  @override
  String get mapViewDetails => 'Ver detalles →';

  @override
  String get locationGpsDisabled =>
      'GPS apagado. Activa la ubicación del teléfono.';

  @override
  String get locationFailed => 'No se pudo obtener tu ubicación.';

  @override
  String get locationDialogTitle => '¿Permitir acceso a la ubicación?';

  @override
  String get locationDialogBody =>
      'Para mostrar lugares cercanos en el mapa y calcular la distancia, necesitamos tu ubicación.';

  @override
  String get locationDeniedForever =>
      'Permiso denegado permanentemente. Actívalo en Ajustes.';

  @override
  String get reviewsSectionTitle => 'Reseñas';

  @override
  String get reviewActionAdd => 'Reseñar este lugar';

  @override
  String get reviewActionEdit => 'Editar mi reseña';

  @override
  String reviewSeeAll(int count) {
    return 'Ver todas las $count reseñas';
  }

  @override
  String reviewsAggregateCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count reseñas',
      one: '1 reseña',
      zero: 'Sin reseñas',
    );
    return '$_temp0';
  }

  @override
  String get reviewsEmptyTitle => 'Aún no hay reseñas';

  @override
  String get reviewsEmptySubtitleDetail =>
      '¡Sé el primero en reseñar este lugar!';

  @override
  String get reviewsListEmptySubtitle =>
      'Sé el primero en contar tu experiencia por aquí.';

  @override
  String get reviewAxisFood => 'Comida';

  @override
  String get reviewAxisService => 'Servicio';

  @override
  String get reviewAxisAmbience => 'Ambiente';

  @override
  String get reviewDefaultUserName => 'Usuario';

  @override
  String get reviewReportTooltip => 'Reportar';

  @override
  String get myReviewsTitle => 'Mis reseñas';

  @override
  String get myReviewsEmptyTitle => 'Aún no has reseñado ningún lugar';

  @override
  String get myReviewsEmptySubtitle =>
      '¡Encuentra tu próximo restaurante favorito! 🍽️';

  @override
  String get reviewDeleteConfirmTitle => '¿Eliminar reseña?';

  @override
  String get reviewDeleteConfirmBody =>
      'Podrás reseñar este lugar nuevamente cuando quieras.';

  @override
  String get reviewDeleteError => 'Error al eliminar.';

  @override
  String get reviewStatusPending => 'En revisión';

  @override
  String get reviewStatusHidden => 'Oculta';

  @override
  String get reviewStatusRejected => 'No aprobada';

  @override
  String get reviewStatusVisible => 'Publicada';

  @override
  String get reviewStatusPendingMsg =>
      'Tu reseña está siendo revisada por nuestro equipo y aparecerá pronto.';

  @override
  String get reviewStatusHiddenMsg =>
      'Tu reseña fue ocultada. Contáctanos si crees que fue un error.';

  @override
  String get reviewStatusRejectedMsg =>
      'Tu reseña no fue aprobada. Puedes editarla y enviarla de nuevo.';

  @override
  String get reviewFormHeaderEyebrow => 'Reseñar';

  @override
  String get reviewFormDetailLabel => 'Detalla tu reseña (opcional)';

  @override
  String get reviewFormCommentHint => 'Cuenta tu experiencia...';

  @override
  String get reviewFormSubmit => 'Enviar reseña';

  @override
  String get reviewFormSaveEdits => 'Guardar cambios';

  @override
  String get reviewRating0 => 'Toca para puntuar';

  @override
  String get reviewRating1 => 'Pésimo';

  @override
  String get reviewRating2 => 'Malo';

  @override
  String get reviewRating3 => 'Regular';

  @override
  String get reviewRating4 => 'Bueno';

  @override
  String get reviewRating5 => 'Excelente';

  @override
  String get reviewSubmitSuccess => '¡Reseña publicada con éxito ⭐!';

  @override
  String get reviewSubmitPending => 'Tu reseña está en revisión.';

  @override
  String get reviewSubmitDuplicate =>
      'Ya reseñaste este lugar. Actualiza la pantalla y edítala desde ahí.';

  @override
  String get reviewSubmitError => 'Error al enviar. Intenta de nuevo.';

  @override
  String get reviewPendingOverlayBody => 'Tu reseña aparecerá pronto.';

  @override
  String get reportTitle => 'Reportar reseña';

  @override
  String get reportPrompt => '¿Por qué quieres reportar esta reseña?';

  @override
  String get reportNotesHint => 'Cuéntanos qué pasó...';

  @override
  String get reportSubmit => 'Enviar reporte';

  @override
  String get reportError => 'Error al enviar el reporte.';

  @override
  String get reportSuccessTitle => 'Reporte recibido';

  @override
  String get reportSuccessBody => 'Lo revisaremos.';

  @override
  String starsSemantics(int value, int count) {
    return 'Puntuación: $value de $count estrellas';
  }

  @override
  String starsSemanticsLabeled(String label, int value, int count) {
    return '$label: puntuación $value de $count estrellas';
  }

  @override
  String starsDisplaySemantics(String rating) {
    return 'Puntuación: $rating de 5';
  }

  @override
  String get authSignInWithGoogle => 'Iniciar sesión con Google';

  @override
  String get authSignInWithGoogleShort => 'Iniciar con Google';

  @override
  String get authLoginPromptTitle => 'Inicia sesión para guardar favoritos';

  @override
  String get authLoginPromptBody =>
      'Inicia sesión con tu cuenta de Google para crear tu lista de lugares favoritos en Parintins.';

  @override
  String get dateJustNow => 'hace un momento';

  @override
  String dateMinutesAgo(int count) {
    return 'hace $count min';
  }

  @override
  String dateHoursAgo(int count) {
    return 'hace $count h';
  }

  @override
  String dateDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count días',
      one: 'hace 1 día',
    );
    return '$_temp0';
  }

  @override
  String dateWeeksAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count semanas',
      one: 'hace 1 semana',
    );
    return '$_temp0';
  }

  @override
  String dateMonthsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count meses',
      one: 'hace 1 mes',
    );
    return '$_temp0';
  }

  @override
  String dateYearsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count años',
      one: 'hace 1 año',
    );
    return '$_temp0';
  }
}
