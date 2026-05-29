import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/review.dart';
import '../repositories/reviews_repository.dart';

/// Estados de denúncia. Backend é idempotente — não há "duplicate".
sealed class ReportSubmissionState {
  const ReportSubmissionState();
}

class ReportSubmissionIdle extends ReportSubmissionState {
  const ReportSubmissionIdle();
}

class ReportSubmissionSubmitting extends ReportSubmissionState {
  const ReportSubmissionSubmitting();
}

class ReportSubmissionSuccess extends ReportSubmissionState {
  const ReportSubmissionSuccess();
}

class ReportSubmissionError extends ReportSubmissionState {
  const ReportSubmissionError({this.message, this.validation});
  final String? message;
  final ValidationException? validation;
}

class ReportSubmissionNotifier extends Notifier<ReportSubmissionState> {
  @override
  ReportSubmissionState build() => const ReportSubmissionIdle();

  void reset() {
    state = const ReportSubmissionIdle();
  }

  Future<void> submit({
    required int reviewId,
    required ReportInput input,
  }) async {
    state = const ReportSubmissionSubmitting();
    try {
      final repo = ref.read(reviewsRepositoryProvider);
      await repo.reportReview(reviewId, input);
      state = const ReportSubmissionSuccess();
    } on ValidationException catch (e) {
      // 422 típico: denunciar a própria review.
      state = ReportSubmissionError(message: e.message, validation: e);
    } catch (_) {
      state = const ReportSubmissionError(
        message: 'Erro ao enviar denúncia. Tente de novo.',
      );
    }
  }
}

final reportSubmissionProvider =
    NotifierProvider<ReportSubmissionNotifier, ReportSubmissionState>(
  ReportSubmissionNotifier.new,
);
