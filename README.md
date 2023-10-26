Supply Chain (Luận văn tốt nghiệp - Nguyễn Anh Khoa)
============

![Dribble Supply Chain](https://github.com/nakhoagithub/supply_chain_release/blob/main/assets/images/suppychain.png?raw=true)

### Ngôn ngữ lập trình
- [Dart](https://dart.dev/)
- [Framework Flutter](https://flutter.dev/)

### Người lập trình
- B1809593 - Nguyễn Anh Khoa (Sinh viên trường Đại học Cần Thơ)

### Mô tả ứng dụng
- Ứng dụng **Supply Chain** cho phép người dùng tham gia trao đổi các mặt hàng và các mặt hàng này khi giao dịch sẽ được [Blockchain](https://vi.wikipedia.org/wiki/Blockchain) xác nhận.
- Ứng dụng demo trên hệ thống **Blockchain** của **Ethereum** với mạng **Mumbai - Polygon Testnet**
- Ứng dụng sử dụng cơ sở dữ liệu **NoSQL** [Firebase Database Realtime](https://firebase.google.com/) để quản lý người dùng.
- Ứng dụng sử dụng một [Private Key](https://ethereum.org/vi/developers/docs/accounts/) để đăng nhập, **Private Key** được tạo thông qua thư viện [web3dart](https://pub.dev/packages/web3dart) hổ trợ của ngôn ngữ Dart.
- Sử dụng công nghệ [Web3](https://vi.wikipedia.org/wiki/Web_3.0) và [Smart Contract](https://ethereum.org/vi/developers/docs/smart-contracts/)

### Các chức năng chính của ứng dụng
- Tạo người dùng (nhà máy, nhà cung cấp, công ty,...)
- Quản lý thông tin người dùng
- Tạo sản phẩm
- Vận chuyển
- Tạo và quét mã vạch truy xuất chuỗi cung ứng

#### Ưu nhược điểm của ứng dụng

- Ưu điểm
    * Người dùng sản phẩm có thể quét mã vạch để truy xuất nguồn gốc của sản phẩm.
    * Người tham gia hệ thống sẽ tìm được các công ty thành viên để biết họ cung cấp cho mình được những gì.

- Nhược điểm
    * Với việc sử dụng **Blockchain** xác nhận giao dịch, người dùng sẽ cần một khoảng phí để trả cho việc xác nhận các block trên **Blockchain** và sẽ tốn thời gian cho việc xác nhận giao dịch nếu **Blockchain** sử dụng **Cơ chế đồng thuận PoW ([_Proof of Work_](https://ethereum.org/en/developers/docs/consensus-mechanisms/pow/))**.
    * Ứng dụng có giao diện chưa đẹp mắt.
    * Ứng dụng cần nâng cấp và kết nối với các thiết bị **IoT** để cho các sản phẩm không được giả mạo trong quá trình sản xuất, vận chuyển.

### Một số hình ảnh về giao diện

- Giao diện Đăng nhập
![Đăng nhập](https://github.com/nakhoagithub/supply_chain_release/blob/main/docs/images/Screenshot_20221023-142514.png?raw=true)

- Giao diện Quét mã vạch
![Mã vạch](https://github.com/nakhoagithub/supply_chain_release/blob/main/docs/images/Screenshot_20221023-142510.png?raw=true)

- Giao diện Trang chủ
![Trang chủ](https://github.com/nakhoagithub/supply_chain_release/blob/main/docs/images/Screenshot_20221023-142438.png?raw=true)

- Giao diện Thông tin
![Thông Tin](https://github.com/nakhoagithub/supply_chain_release/blob/main/docs/images/Screenshot_20221023-142442.png?raw=true)

- Giao diện Truy xuất nguồn gốc sản phẩm
![Truy xuất nguồn gốc](https://github.com/nakhoagithub/supply_chain_release/blob/main/docs/images/Screenshot_20221023-142429.png?raw=true)
