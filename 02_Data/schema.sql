
-- ============================================================================
-- PROJECT: Local AI RAG Chatbot for IT Services
-- DATABASE: PostgreSQL 15+ with pgvector extension
-- DESIGN: 7 Core Tables
-- ============================================================================

-- Kich hoat pgvector
CREATE EXTENSION IF NOT EXISTS vector;

-- ============================================================================
-- NHOM 1: QUAN LY DICH VU
-- ============================================================================

-- 1. Luu thong tin 20 goi dich vu (US-01)
CREATE TABLE service_plans (
    plan_code VARCHAR(30) PRIMARY KEY,
    service_category VARCHAR(30) NOT NULL
        CHECK (service_category IN (
            'CLOUD_SERVER', 'CLOUD_VPS', 'EMAIL_SERVER', 'COLOCATION'
        )),
    plan_name VARCHAR(100) NOT NULL UNIQUE,
    price_vnd BIGINT NOT NULL CHECK (price_vnd > 0),
    cpu_model VARCHAR(100),
    vcpu INT,
    ram_base_gb DECIMAL(5,2),
    ram_bonus_gb DECIMAL(5,2) DEFAULT 0,
    storage_gb INT,
    service_details TEXT,
    promotion TEXT,
    source_page INT NOT NULL
);

-- ============================================================================
-- NHOM 2: QUAN LY CHATBOT VA HOI THOAI
-- ============================================================================

-- 2. Luu phien tro chuyen cua khach hang (US-04)
CREATE TABLE conversation_sessions (
    session_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_token VARCHAR(64) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    last_activity TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 3. Luu lich su cau hoi va cau tra loi (US-04, US-08)
CREATE TABLE chat_messages (
    message_id SERIAL PRIMARY KEY,
    session_id UUID NOT NULL
        REFERENCES conversation_sessions(session_id) ON DELETE CASCADE,
    role VARCHAR(20) NOT NULL CHECK (role IN ('user', 'assistant')),
    content TEXT NOT NULL,
    intent_type VARCHAR(50),
    cited_sources JSONB DEFAULT '[]'::jsonb,
    latency_ms INT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================================
-- NHOM 3: QUAN TRI VA RAG
-- ============================================================================

-- 4. Luu tai khoan quan tri vien (US-07)
CREATE TABLE admin_users (
    admin_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 5. Quan ly tai lieu RAG (US-07)
CREATE TABLE rag_documents (
    document_id SERIAL PRIMARY KEY,
    uploaded_by INT
        REFERENCES admin_users(admin_id) ON DELETE SET NULL,
    file_name VARCHAR(255) NOT NULL,
    file_path VARCHAR(500) NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'draft'
        CHECK (status IN ('draft', 'approved', 'archived')),
    uploaded_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 6. Luu cac chunks va vector embedding (US-02, US-03)
CREATE TABLE rag_chunks (
    chunk_id SERIAL PRIMARY KEY,
    document_id INT NOT NULL
        REFERENCES rag_documents(document_id) ON DELETE CASCADE,
    chunk_index INT NOT NULL,
    chunk_content TEXT NOT NULL,
    source_page INT,
    embedding vector(1024),
    UNIQUE (document_id, chunk_index)
);

-- 7. Luu thong tin lien he khach hang (US-06, US-08)
CREATE TABLE contact_leads (
    lead_id SERIAL PRIMARY KEY,
    session_id UUID
        REFERENCES conversation_sessions(session_id) ON DELETE SET NULL,
    full_name VARCHAR(150) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(150) NOT NULL,
    service_interest VARCHAR(100),
    status VARCHAR(30) DEFAULT 'new'
        CHECK (status IN ('new', 'contacted', 'closed')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================================
-- INDEXES: Ho tro cac truy van thuong dung
-- ============================================================================

CREATE INDEX idx_chat_messages_session
ON chat_messages(session_id);

CREATE INDEX idx_rag_chunks_document
ON rag_chunks(document_id);

CREATE INDEX idx_contact_leads_session
ON contact_leads(session_id);
