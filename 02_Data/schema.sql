-- ============================================================================
-- PROJECT: Local AI RAG Chatbot for IT Services
-- DATABASE: PostgreSQL 15+ with pgvector extension
-- DESIGN: 7 Core Tables (3 Functional Groups)
-- ============================================================================

-- Kích hoạt extension pgvector cho tìm kiếm ngữ nghĩa
CREATE EXTENSION IF NOT EXISTS vector;

-- ============================================================================
-- NHÓM 1: QUẢN LÝ DỊCH VỤ (1 BẢNG)
-- ============================================================================

-- 1. Bảng lưu trữ 20 gói dịch vụ, giá niêm yết, thông số và ưu đãi (US-01)
CREATE TABLE service_plans (
    plan_code VARCHAR(30) PRIMARY KEY,
    service_category VARCHAR(30) NOT NULL CHECK (service_category IN ('CLOUD_SERVER', 'CLOUD_VPS', 'EMAIL_SERVER', 'COLOCATION')),
    plan_name VARCHAR(100) NOT NULL UNIQUE,
    price_vnd BIGINT NOT NULL CHECK (price_vnd > 0),
    cpu_model VARCHAR(100),
    vcpu INT CHECK (vcpu IS NULL OR vcpu > 0),
    ram_base_gb DECIMAL(5,2) CHECK (ram_base_gb IS NULL OR ram_base_gb > 0),
    ram_bonus_gb DECIMAL(5,2) DEFAULT 0 CHECK (ram_bonus_gb >= 0),
    storage_gb INT CHECK (storage_gb IS NULL OR storage_gb > 0),
    service_details TEXT,
    promotion TEXT,
    source_page INT NOT NULL
);

-- ============================================================================
-- NHÓM 2: QUẢN LÝ CHATBOT VÀ HỘI THOẠI (2 BẢNG)
-- ============================================================================

-- 2. Bảng lưu phiên trò chuyện ẩn danh của khách hàng trên trình duyệt (US-04)
CREATE TABLE conversation_sessions (
    session_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_token VARCHAR(64) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    last_activity TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 3. Bảng lưu lịch sử câu hỏi và câu trả lời trong từng phiên (US-04, US-08, NFR-03)
CREATE TABLE chat_messages (
    message_id SERIAL PRIMARY KEY,
    session_id UUID NOT NULL REFERENCES conversation_sessions(session_id) ON DELETE CASCADE,
    role VARCHAR(20) NOT NULL CHECK (role IN ('user', 'assistant')),
    content TEXT NOT NULL,
    intent_type VARCHAR(50),
    cited_sources JSONB DEFAULT '[]'::jsonb,
    latency_ms INT CHECK (latency_ms IS NULL OR latency_ms >= 0),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================================
-- NHÓM 3: QUẢN TRỊ VÀ RAG (4 BẢNG)
-- ============================================================================

-- 4. Bảng lưu tài khoản quản trị viên duy nhất (US-07, NFR-01)
CREATE TABLE admin_users (
    admin_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 5. Bảng quản lý thông tin tài liệu nguồn được tải lên (US-07)
CREATE TABLE rag_documents (
    document_id SERIAL PRIMARY KEY,
    uploaded_by INT REFERENCES admin_users(admin_id) ON DELETE SET NULL,
    file_name VARCHAR(255) NOT NULL,
    file_path VARCHAR(500) NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'draft' CHECK (status IN ('draft', 'approved', 'archived')),
    uploaded_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 6. Bảng lưu các đoạn văn bản (chunks) và vector embedding (US-02, US-03)
-- Khi xóa tài liệu ở rag_documents, toàn bộ chunks & embedding tự động xóa theo (ON DELETE CASCADE)
CREATE TABLE rag_chunks (
    chunk_id SERIAL PRIMARY KEY,
    document_id INT NOT NULL REFERENCES rag_documents(document_id) ON DELETE CASCADE,
    chunk_index INT NOT NULL,
    chunk_content TEXT NOT NULL,
    source_page INT,
    -- Khai báo kiểu vector (sẽ bổ sung số chiều cụ thể VD: vector(1024) hoặc vector(768) khi chốt model embedding)
    embedding vector,
    UNIQUE (document_id, chunk_index)
);

-- 7. Bảng lưu thông tin liên hệ khách hàng để lại (US-06, US-08)
CREATE TABLE contact_leads (
    lead_id SERIAL PRIMARY KEY,
    session_id UUID REFERENCES conversation_sessions(session_id) ON DELETE SET NULL,
    full_name VARCHAR(150) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(150) NOT NULL,
    service_interest VARCHAR(100),
    status VARCHAR(30) DEFAULT 'new' CHECK (status IN ('new', 'contacted', 'closed')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
