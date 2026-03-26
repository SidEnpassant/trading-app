import 'package:equatable/equatable.dart';

class AccountDetails extends Equatable {
  final String accountNumber;
  final double balance;
  final bool panVerified;
  final String kycStatus;

  const AccountDetails({
    required this.accountNumber,
    required this.balance,
    required this.panVerified,
    required this.kycStatus,
  });

  @override
  List<Object?> get props => [accountNumber, balance, panVerified, kycStatus];
}
