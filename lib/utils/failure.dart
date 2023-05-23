enum FailureReason { authError, normalError }

class Failure {
  final String message;
  final FailureReason reason;
  Failure(this.message, {this.reason = FailureReason.normalError});
}