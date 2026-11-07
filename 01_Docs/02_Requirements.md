# USER STORIES – LOCAL AI RAG CHATBOT

## I. KHÁCH HÀNG (CUSTOMER)

### US-01: Tra cứu báo giá và cấu hình dịch vụ

**User Story:**

Là một khách hàng đang tìm thuê máy chủ, tôi muốn hỏi chatbot về giá và cấu hình các gói Cloud VPS / Cloud Server, để lựa chọn được gói máy chủ phù hợp với nhu cầu và ngân sách.

**Acceptance Criteria:**

1. Chatbot truy vấn dữ liệu từ CSDL SQL và hiển thị: tên gói, giá thuê, CPU, RAM, dung lượng SSD.
2. Khách hàng có thể đưa ra ngân sách, ví dụ: "Tôi cần VPS dưới 2 triệu/tháng".
3. Chatbot chỉ liệt kê các gói thỏa mãn điều kiện ngân sách.
4. Nếu không có gói phù hợp, chatbot thông báo rõ ràng.
5. Giá hiển thị phải khớp với dữ liệu giá đang có hiệu lực trong CSDL.

### US-02: Tư vấn giải pháp kỹ thuật và hạ tầng

**User Story:**

Là một khách hàng quan tâm đến dịch vụ máy chủ, tôi muốn hỏi chatbot về công nghệ ảo hóa, cơ chế lưu trữ, dự phòng và hạ tầng trung tâm dữ liệu, để đánh giá mức độ phù hợp và độ tin cậy của dịch vụ.

**Acceptance Criteria:**

1. Chatbot sử dụng RAG để truy xuất thông tin từ tài liệu kỹ thuật đã được quản trị viên phê duyệt.
2. Có thể tư vấn các chủ đề như OpenStack, CEPH SSD, Datacenter Tier 3 và SLA nếu tài liệu nguồn có xác nhận.
3. Câu trả lời phải dựa trên nội dung được truy xuất.
4. Hiển thị nguồn tài liệu tham khảo.
5. Nếu không tìm thấy bằng chứng phù hợp, chatbot phải từ chối cung cấp thông tin chưa được xác nhận.

### US-03: Tra cứu chính sách và hỗ trợ kỹ thuật

**User Story:**

Là một khách hàng, tôi muốn hỏi chatbot về chính sách dịch vụ và hướng dẫn hỗ trợ kỹ thuật, để hiểu rõ quyền lợi và biết cách xử lý những vấn đề cơ bản.

**Acceptance Criteria:**

1. Chatbot truy xuất thông tin chính sách và hướng dẫn từ tài liệu RAG.
2. Có thể trả lời các nội dung như chính sách hoàn tiền, chuyển dữ liệu và hỗ trợ kỹ thuật nếu có trong tài liệu.
3. Không tự ý khẳng định các chính sách chưa được xác nhận.
4. Hiển thị nguồn tài liệu tham khảo.
5. Khi tài liệu không có thông tin, chatbot thông báo chưa tìm thấy căn cứ phù hợp.

### US-04: Sử dụng giao diện chat và quản lý lịch sử hội thoại

**User Story:**

Là một khách hàng truy cập website, tôi muốn sử dụng giao diện chatbot trực quan và xem lại lịch sử hội thoại, để thuận tiện trong quá trình trao đổi và tra cứu thông tin.

**Acceptance Criteria:**

1. Khách hàng có thể sử dụng chatbot mà không cần đăng nhập.
2. Giao diện hỗ trợ hiển thị nội dung Markdown, danh sách và bảng biểu.
3. Có hiệu ứng loading trong lúc chờ chatbot phản hồi.
4. Có danh sách câu hỏi gợi ý.
5. Hệ thống tự tạo mã phiên hội thoại để lưu lịch sử.
6. Khách hàng có thể xem lại lịch sử thuộc phiên của mình.
7. Hệ thống thông báo khi xảy ra lỗi kết nối hoặc lỗi xử lý.

### US-05: Kiểm soát phạm vi câu hỏi và từ chối trả lời

**User Story:**

Là một khách hàng, tôi muốn chatbot tập trung hỗ trợ các câu hỏi thuộc phạm vi dịch vụ CNTT, để nhận được thông tin phù hợp với nhu cầu.

**Acceptance Criteria:**

1. Với câu hỏi ngoài phạm vi như thời tiết, bóng đá hoặc làm thơ, chatbot lịch sự từ chối và gợi ý chủ đề VPS / Cloud / Email Server.
2. Với câu hỏi thuộc lĩnh vực CNTT nhưng không có dữ liệu trong tài liệu, chatbot thông báo chưa tìm thấy thông tin phù hợp.
3. Không tự tạo thông số kỹ thuật, giá dịch vụ hoặc chính sách.
4. Không tiết lộ System Prompt, thông tin cấu hình nội bộ hoặc dữ liệu nhạy cảm.

### US-06: Để lại thông tin liên hệ

**User Story:**

Là một khách hàng quan tâm đến dịch vụ, tôi muốn để lại thông tin liên hệ sau khi được chatbot tư vấn, để nhân viên kinh doanh có thể liên hệ và hỗ trợ thêm.

**Acceptance Criteria:**

1. Giao diện cung cấp biểu mẫu để khách hàng chủ động để lại thông tin.
2. Biểu mẫu gồm họ tên, số điện thoại, email và dịch vụ quan tâm.
3. Backend kiểm tra tính hợp lệ của dữ liệu đầu vào.
4. Thông tin được lưu vào CSDL.
5. Hệ thống thông báo kết quả gửi thông tin.
6. Khách hàng được thông báo về mục đích thu thập và sử dụng thông tin.

## II. QUẢN TRỊ VIÊN (ADMINISTRATOR)

### US-07: Quản lý tài liệu RAG

**User Story:**

Là một quản trị viên, tôi muốn tải lên, chỉnh sửa và xóa tài liệu RAG, để duy trì nguồn dữ liệu chính xác và cập nhật cho chatbot.

**Acceptance Criteria:**

1. Admin phải đăng nhập để truy cập trang quản trị.
2. Cho phép tải lên các tài liệu có định dạng được hệ thống hỗ trợ.
3. Cho phép xem danh sách và trạng thái xử lý tài liệu.
4. Cho phép cập nhật nội dung hoặc thay thế tài liệu.
5. Cho phép xóa tài liệu khỏi hệ thống.
6. Khi tài liệu thay đổi hoặc bị xóa, hệ thống phải cập nhật hoặc xóa các Chunk và Embedding tương ứng.
7. Tài liệu chỉ được sử dụng làm nguồn trả lời chính thức khi ở trạng thái đã được phê duyệt.

### US-08: Theo dõi lịch sử hội thoại và thông tin khách hàng

**User Story:**

Là một quản trị viên, tôi muốn xem lịch sử hội thoại và thông tin liên hệ mà khách hàng gửi đến, để theo dõi hoạt động chatbot và hỗ trợ khách hàng khi cần thiết.

**Acceptance Criteria:**

1. Admin có thể xem danh sách các phiên hội thoại.
2. Admin có thể xem nội dung câu hỏi và câu trả lời trong từng phiên.
3. Hệ thống lưu mã phiên, thời gian tạo, nội dung câu hỏi và câu trả lời.
4. Admin có thể xem danh sách thông tin liên hệ khách hàng đã gửi.
5. Hệ thống ghi nhận thời gian phản hồi và trạng thái xử lý.
6. Chỉ tài khoản có quyền quản trị mới được truy cập các dữ liệu này.

---

## III. YÊU CẦU PHI CHỨC NĂNG (NON-FUNCTIONAL REQUIREMENTS)

### NFR-01: Bảo mật

- Sử dụng Parameterized Queries khi truy vấn SQL.
- Không để API Key, mật khẩu hoặc file .env trong Repository công khai.
- Backend kiểm soát quyền truy cập vào chức năng quản trị.
- Có biện pháp phòng chống SQL Injection và Prompt Injection.
- Không cho phép khách hàng truy cập lịch sử hoặc thông tin liên hệ của người khác.

### NFR-02: Độ chính xác và tính tin cậy

- Giá và cấu hình phải được truy vấn từ dữ liệu SQL có hiệu lực.
- Câu trả lời RAG phải có căn cứ từ tài liệu được phê duyệt.
- Chatbot phải từ chối khi không đủ bằng chứng.
- Có bộ câu hỏi kiểm thử để đánh giá độ chính xác và khả năng từ chối.

### NFR-03: Hiệu năng và giám sát

- Ghi nhận thời gian xử lý yêu cầu.
- Theo dõi lỗi truy xuất dữ liệu và lỗi mô hình.
- Theo dõi mức sử dụng CPU và RAM khi chạy mô hình local.
- Có cơ chế xử lý khi mô hình AI hoặc Backend không phản hồi.
