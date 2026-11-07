# PROJECT PROPOSAL
## Local AI RAG Chatbot for IT Services

### 1. Giới thiệu dự án

Dự án xây dựng hệ thống chatbot chăm sóc khách hàng ứng dụng trí tuệ nhân tạo (AI), sử dụng kiến trúc Retrieval-Augmented Generation (RAG).

Hệ thống sử dụng dữ liệu riêng của doanh nghiệp cung cấp dịch vụ CNTT như VPS, Cloud Server, Email Server và các dịch vụ hạ tầng mạng để trả lời câu hỏi của khách hàng.

Điểm đặc biệt là mô hình ngôn ngữ được triển khai cục bộ trên máy tính, không phụ thuộc vào API LLM bên ngoài trong quá trình sinh câu trả lời.

### 2. Lý do chọn đề tài

- Nhu cầu hỗ trợ khách hàng trong lĩnh vực CNTT ngày càng tăng.
- Nhân viên phải trả lời nhiều câu hỏi lặp lại về dịch vụ và xử lý sự cố.
- Chatbot thông thường có thể trả lời sai nếu không được cung cấp dữ liệu phù hợp.
- RAG cho phép chatbot truy xuất thông tin từ tài liệu riêng trước khi tạo câu trả lời.
- Triển khai mô hình local giúp chủ động hơn trong việc quản lý dữ liệu và chi phí sử dụng API.

### 3. Mục tiêu dự án

1. Xây dựng giao diện chatbot trên nền tảng Web.
2. Xây dựng Backend xử lý yêu cầu và quản lý dữ liệu.
3. Thiết kế cơ sở dữ liệu quan hệ.
4. Triển khai mô hình AI local.
5. Xây dựng hệ thống RAG để truy xuất dữ liệu doanh nghiệp.
6. Hiển thị nguồn tài liệu được sử dụng để trả lời.
7. Từ chối trả lời khi không tìm thấy thông tin phù hợp trong dữ liệu được phép sử dụng.
8. Xây dựng giao diện quản trị tài liệu và theo dõi hội thoại.

### 4. Phạm vi dự án

**Đối tượng sử dụng:**
- Khách hàng.
- Nhân viên chăm sóc khách hàng.
- Quản trị viên.

**Nhóm dịch vụ mô phỏng:**
- Cloud VPS.
- Cloud Server.
- Email Server.
- Dịch vụ mạng và hạ tầng CNTT.
- Hỗ trợ kỹ thuật.

**Chức năng khách hàng:**
- Đặt câu hỏi với chatbot.
- Tra cứu thông tin dịch vụ.
- Nhận hướng dẫn kỹ thuật.
- Xem nguồn tài liệu tham khảo.
- Xem lịch sử hội thoại.

**Chức năng quản trị:**
- Đăng nhập và phân quyền.
- Quản lý tài liệu.
- Nạp và xử lý dữ liệu RAG.
- Quản lý thông tin dịch vụ.
- Theo dõi lịch sử hội thoại.

### 5. Công nghệ dự kiến

| Thành phần | Công nghệ |
|---|---|
| Frontend | React, TypeScript |
| Backend | Python, FastAPI |
| Database | PostgreSQL |
| Vector Database | PostgreSQL + pgvector |
| Local LLM | Ollama |
| Embedding | Mô hình embedding hỗ trợ tiếng Việt |
| Deployment | Docker |

Các công nghệ sẽ được kiểm chứng và điều chỉnh trong quá trình thực hiện.

### 6. Kiến trúc tổng quan

Luồng xử lý dự kiến:

1. Khách hàng gửi câu hỏi từ giao diện Web.
2. Backend tiếp nhận và kiểm tra yêu cầu.
3. Hệ thống xác định loại câu hỏi.
4. Nếu là thông tin có cấu trúc, hệ thống truy vấn PostgreSQL.
5. Nếu là câu hỏi kiến thức, hệ thống tìm kiếm tài liệu liên quan thông qua RAG.
6. Backend chuyển ngữ cảnh và câu hỏi đến mô hình local thông qua Ollama.
7. Mô hình tạo câu trả lời dựa trên dữ liệu được cung cấp.
8. Backend kiểm tra kết quả và trả lời khách hàng kèm nguồn tham khảo.

### 7. Quy trình RAG dự kiến

- Thu thập tài liệu.
- Kiểm tra và chuẩn hóa dữ liệu.
- Trích xuất nội dung.
- Chia tài liệu thành các đoạn nhỏ (Chunking).
- Tạo Embedding.
- Lưu trữ Vector.
- Truy xuất các đoạn liên quan.
- Đưa ngữ cảnh vào mô hình ngôn ngữ.
- Sinh câu trả lời và hiển thị nguồn.

### 8. Nguyên tắc trả lời

- Ưu tiên thông tin từ dữ liệu đã được kiểm duyệt.
- Không tự ý tạo giá dịch vụ, thông số kỹ thuật hoặc chính sách.
- Hiển thị nguồn tham khảo khi có thể.
- Từ chối trả lời khi không tìm thấy bằng chứng phù hợp.
- Không sử dụng tài liệu ở trạng thái bản nháp làm nguồn thông tin chính thức.

### 9. Phạm vi chưa thực hiện

Trong phiên bản đầu tiên, dự án chưa tập trung vào:

- Tích hợp Facebook và Zalo.
- Thanh toán trực tuyến.
- Tự động điều khiển máy chủ.
- Tự động thay đổi cấu hình Firewall.
- Giám sát hạ tầng thời gian thực.

### 10. Kết quả dự kiến

- Website chatbot hoạt động.
- Backend API.
- Cơ sở dữ liệu quan hệ.
- Hệ thống RAG sử dụng dữ liệu riêng.
- Mô hình AI chạy local.
- Giao diện quản trị tài liệu.
- Bộ câu hỏi kiểm thử và báo cáo đánh giá.
- Tài liệu hướng dẫn cài đặt và triển khai.
