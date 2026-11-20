-- Kiem tra tong so goi dich vu
SELECT COUNT(*) AS total_plans
FROM service_plans;

-- Dem so goi theo tung nhom dich vu
SELECT
    service_category,
    COUNT(*) AS total_plans
FROM service_plans
GROUP BY service_category
ORDER BY service_category;

--Tra cứu thông tin một gói dịch vụ
SELECT
    plan_name,
    price_vnd,
    vcpu,
    ram_base_gb,
    ram_bonus_gb,
    storage_gb,
    promotion
FROM service_plans
WHERE plan_code = 'VPS_B';
--Tìm các gói dịch vụ theo ngân sách
SELECT
    plan_name,
    price_vnd,
    vcpu,
    ram_base_gb,
    ram_bonus_gb,
    storage_gb
FROM service_plans
WHERE service_category = 'CLOUD_VPS'
  AND price_vnd <= 500000
ORDER BY price_vnd ASC;
--Liệt kê các gói dịch vụ theo nhóm
SELECT
    plan_code,
    plan_name,
    price_vnd,
    vcpu,
    ram_base_gb,
    ram_bonus_gb,
    storage_gb,
    promotion
FROM service_plans
WHERE service_category = 'CLOUD_SERVER'
ORDER BY price_vnd ASC;
