-- Reference data only. No user accounts or authentication tokens.
INSERT INTO `afk_configs` (`id`, `config_key`, `config_value`, `value_type`, `description`, `created_at`, `updated_at`) VALUES
(1, 'afk_base_exp_per_minute', '{\"exp\":\"base_exp * minutes\",\"gold\":\"base_gold * minutes\"}', 'json', 'Công thức tính thưởng', '2026-03-11 15:23:04', '2026-04-11 23:38:26');
INSERT INTO `genres` (`id`, `name`, `slug`, `description`, `created_at`, `updated_at`) VALUES
(0, 'Trinh Thám', 'trinhtham', NULL, '2026-04-02 11:29:16', '2026-04-02 11:29:16'),
(1, 'Tu luyện', 'tu-luyen', 'Truyện có hệ thống nhiệm vụ', '2026-03-11 14:59:47', '2026-04-02 11:29:09');
INSERT INTO `item_types` (`id`, `code`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'currency', 'Tiền tệ', 'Các vật phẩm dạng tiền tệ', '2026-03-11 15:33:53', '2026-03-25 17:08:49'),
(2, 'consumable', 'Tiêu hao', 'Vật phẩm dùng một lần', '2026-03-11 15:33:53', '2026-03-11 15:33:53'),
(3, 'equipment', 'Trang bị', 'Vật phẩm có thể trang bị', '2026-03-11 15:33:53', '2026-03-11 15:33:53'),
(4, 'boost', 'Hỗ trợ', 'Vật phẩm tăng chỉ số hoặc bonus', '2026-03-11 15:33:53', '2026-03-27 22:42:04');
INSERT INTO `levels` (`id`, `level_number`, `exp_required`, `reward_gold`, `reward_premium`, `created_at`, `updated_at`) VALUES
(1, 1, 5000, 100.00, 0.00, '2026-03-11 17:41:37', '2026-03-11 17:41:37'),
(2, 2, 12000, 200.00, 0.00, '2026-03-11 17:41:37', '2026-03-11 17:41:37'),
(3, 3, 25000, 350.00, 10.00, '2026-03-11 17:41:37', '2026-03-11 17:41:37'),
(4, 4, 50000, 500.00, 20.00, '2026-03-11 17:41:37', '2026-03-11 17:41:37'),
(5, 5, 100000, 800.00, 50.00, '2026-03-11 17:41:37', '2026-03-11 17:41:37');
INSERT INTO `missions` (`id`, `code`, `title`, `description`, `mission_type`, `target_type`, `target_value`, `reward_gold`, `reward_exp`, `reward_item_id`, `reward_item_qty`, `is_active`, `start_at`, `end_at`, `created_at`, `updated_at`) VALUES
(1, '1', 'Đọc Truyện', 'Đọc nhiều được nhiều ', 'daily', 'read_chapter', 1, 100.00, 10000, 2, 1, 1, '2026-03-28 08:55:00', '2026-03-29 08:55:00', '2026-03-28 08:56:02', '2026-04-02 11:36:30'),
(2, '2', 'Check', 'Tặng thưởng', 'event', 'chat', 1, 100.00, 1000, 2, 1, 1, '2026-04-02 11:37:00', '2026-04-03 11:37:00', '2026-04-02 11:37:49', '2026-04-02 11:38:49'),
(3, '3', 'eeee', NULL, 'event', 'read_chapter', 1, 11.00, 11, NULL, 11, 1, '2026-04-02 11:38:00', '2026-04-03 11:38:00', '2026-04-02 11:38:52', '2026-04-11 23:47:48');
INSERT INTO `payment_packages` (`id`, `code`, `name`, `price_amount`, `currency_code`, `premium_reward`, `vip_exp_reward`, `bonus_percent`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'GOI_100', 'Gói 100 Premium', 10000.00, 'VND', 100.00, 10.00, 0.00, 1, '2026-04-11 11:45:23', '2026-04-11 23:45:49');
INSERT INTO `realms` (`id`, `name`, `realm_order`, `description`, `base_power_bonus`, `created_at`, `updated_at`) VALUES
(1, 'Luyện Khí', 1, 'Cảnh giới khởi đầu', 0, '2026-03-11 16:10:42', '2026-03-11 16:10:42'),
(2, 'Trúc Cơ', 2, 'Bắt đầu ổn định nền tảng', 100, '2026-03-11 16:10:42', '2026-03-11 16:10:42'),
(3, 'Kim Đan', 3, 'Đột phá mạnh về nội lực', 300, '2026-03-11 16:10:42', '2026-03-11 16:10:42'),
(4, 'Nguyên Anh', 4, 'Bước sang tầng cao hơn', 700, '2026-03-11 16:10:42', '2026-03-11 16:10:42'),
(5, 'Hóa Thần', 5, 'Cường giả hiếm gặp', 1500, '2026-03-11 16:10:42', '2026-03-11 16:10:42');
INSERT INTO `roles` (`id`, `code`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'user', 'user', NULL, '2026-03-10 15:57:11', '2026-03-10 16:08:37'),
(4, 'admin', 'admin', NULL, '2026-03-10 16:07:59', '2026-03-10 16:07:59');
INSERT INTO `vip_levels` (`id`, `level_number`, `name`, `required_topup_amount`, `badge_name`, `badge_color`, `description`, `created_at`, `updated_at`) VALUES
(1, 0, 'VIP 0', 0.00, 'Người mới', 'gray', 'Cấp mặc định cho người chơi mới', '2026-03-11 17:42:36', '2026-03-11 17:42:36'),
(2, 1, 'VIP 1', 100000.00, 'Tân VIP', 'green', 'Mở khóa quyền lợi VIP cơ bản', '2026-03-11 17:42:36', '2026-03-11 17:42:36'),
(3, 2, 'VIP 2', 300000.00, 'Cao VIP', 'blue', 'Nhận thêm ưu đãi và phần thưởng', '2026-03-11 17:42:36', '2026-03-11 17:42:36'),
(4, 3, 'VIP 3', 1000000.00, 'Thượng VIP', 'purple', 'Gói VIP cao cấp', '2026-03-11 17:42:36', '2026-03-11 17:42:36');
