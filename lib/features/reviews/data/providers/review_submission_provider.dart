import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../establishments/data/providers/establishment_detail_provider.dart';
import '../models/review.dart';
import '../repositories/reviews_repository.dart';
import 'establishment_reviews_provider.dart';
import 'my_reviews_provider.dart';

/// Estados possíveis de uma submissão (create/update/delete).
///
/// `sealed` permite pattern matching exhaustivo no switch:
/// ```dart
/// switch (state) {
///   case ReviewSubmissionSuccess(:final review): ...
///   case ReviewSubmissionPending(:final review): ...
///   case ReviewSubmissionError(:final message): ...
///   ...
/// }
/// ```
/// O compilador avisa se uma variante for esquecida.
sealed class ReviewSubmissionState {
  const ReviewSubmissionState();
}

class ReviewSubmissionIdle extends ReviewSubmissionState {
  const ReviewSubmissionIdle();
}

class ReviewSubmissionSubmitting extends ReviewSubmissionState {
  const ReviewSubmissionSubmitting();
}

/// Review publicada — backend deixou `status: visible`. UI mostra
/// confetti e fecha o sheet.
class ReviewSubmissionSuccess extends ReviewSubmissionState {
  const ReviewSubmissionSuccess(this.review);
  final Review review;
}

/// Review criada/atualizada mas ficou em moderação (`pending`).
/// UI mostra ícone de relógio + "Em análise" e fecha o sheet.
class ReviewSubmissionPending extends ReviewSubmissionState {
  const ReviewSubmissionPending(this.review);
  final Review review;
}

class ReviewSubmissionError extends ReviewSubmissionState {
  const ReviewSubmissionError({
    this.message,
    this.duplicated = false,
    this.validation,
  });
  final String? message;
  final bool duplicated; // 409 — UI deve reabrir em modo edição
  final ValidationException? validation;
}

/// Notifier de submissão. Compartilhado entre o ReviewFormSheet e a
/// tela "Minhas Avaliações" (que usa o mesmo notifier pra delete).
///
/// COMO A UI USA: com `ref.listen` (NÃO watch). Watch reconstrói a tela
/// a cada transição de estado — desnecessário aqui. Listen executa um
/// callback nas mudanças, perfeito pra side effects (confetti, fechar
/// sheet, SnackBar).
class ReviewSubmissionNotifier extends Notifier<ReviewSubmissionState> {
  @override
  ReviewSubmissionState build() => const ReviewSubmissionIdle();

  /// Volta pra idle — chamar antes de abrir um sheet novo pra
  /// garantir estado limpo (senão o `ref.listen` recém-montado pode
  /// disparar com um estado antigo).
  void reset() {
    state = const ReviewSubmissionIdle();
  }

  /// Cria OU atualiza dependendo de `existing`. Após sucesso, invalida
  /// os providers relevantes pra que a UI reflita o estado fresco.
  Future<void> submit({
    required String slug,
    required ReviewInput input,
    Review? existing,
  }) async {
    state = const ReviewSubmissionSubmitting();
    try {
      final repo = ref.read(reviewsRepositoryProvider);
      final review = existing == null
          ? await repo.createReview(slug, input)
          : await repo.updateReview(existing.id, input);

      _invalidateRelated(slug);

      state = review.status == ReviewStatus.visible
          ? ReviewSubmissionSuccess(review)
          : ReviewSubmissionPending(review);
    } on DuplicateReviewException {
      state = const ReviewSubmissionError(duplicated: true);
    } on ValidationException catch (e) {
      state = ReviewSubmissionError(
        message: e.message,
        validation: e,
      );
    } catch (_) {
      state = const ReviewSubmissionError(
        message: 'Erro ao enviar. Tente de novo.',
      );
    }
  }

  /// DELETE — chamado da tela "Minhas Avaliações". `slug` é opcional
  /// (pode não estar disponível); se vier, invalida a lista pública
  /// daquele estabelecimento também.
  Future<void> delete({required int reviewId, String? slug}) async {
    state = const ReviewSubmissionSubmitting();
    try {
      final repo = ref.read(reviewsRepositoryProvider);
      await repo.deleteReview(reviewId);
      _invalidateRelated(slug);
      // Pra delete não há "review" pra carregar — voltamos pra idle
      // (a UI já removeu localmente via Dismissible / removeLocally).
      state = const ReviewSubmissionIdle();
    } catch (_) {
      state = const ReviewSubmissionError(
        message: 'Erro ao excluir. Tente de novo.',
      );
    }
  }

  /// Invalida providers afetados pra a UI refletir o backend fresco.
  /// - lista pública daquele estabelecimento
  /// - detail (agregado + user_review mudaram)
  /// - lista "Minhas avaliações"
  void _invalidateRelated(String? slug) {
    if (slug != null) {
      ref.invalidate(establishmentReviewsProvider(slug));
      ref.invalidate(establishmentDetailProvider(slug));
    }
    ref.invalidate(myReviewsProvider);
  }
}

final reviewSubmissionProvider =
    NotifierProvider<ReviewSubmissionNotifier, ReviewSubmissionState>(
  ReviewSubmissionNotifier.new,
);
