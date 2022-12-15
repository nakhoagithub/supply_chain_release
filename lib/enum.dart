enum ProductStatus { initialize, loading, success, failure }

enum TransferStatus { initialize, loading, success, failure }

enum UserPageStatus { initialize, loading, success, failure, logout }

enum AppStatus { initialize, authentication, unauthentication }

enum AuthenticationStatus { authentication, unAuthentication }

enum ChangeInfoStatus { init, initData, loading, success, failure }

enum DescriptionStatus { init, valid, invalid }

enum LinkImageStatus { initialize, valid, invalid }

enum CompanyStatus { initialize, loading, success, failure }

enum AddressStatus { init, valid, invalid }

enum EmailStatus { init, emailValid, emailInvalid }

enum GenerateStatus { init, loading, success, failure }

enum NameStatus { initialize, valid, invalid }

enum CodeStatus { initialize, valid, codeInvalid }

enum LoginStatus { init, success, fail }

enum PrivateKeyStatus { init, valid, invalid }

enum ReceivePKStatus { inititalize, loading, success, failure }

enum UserJoinBlockchainStatus { initialize, loading, susscess, failure }

enum PriceStatus { initialize, valid, invalid }

enum DeleteStatus { initialize, success, failure }

enum ProcessingProductStatus { initialize, success, failure }

enum CountStatus { initialize, valid, invalid }

enum CountingUnitStatus { initialize, valid, invalid }

enum AddressEtherStatus { initilaize, valid, invalid }

enum HomeStatus { initialize, loading, succcess, failure }

enum HistoryStatus { initialize, loading, success, failure }

enum ScanStatus { initialize, loading, success, failure }

enum BarcodeStatus {
  initialize,
  loading,
  success,
  failure,
  permissionFailure,
  scanSuccess
}
