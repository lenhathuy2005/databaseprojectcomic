-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th4 14, 2026 lúc 05:57 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `comic_cultivation_system`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `afk_claim_logs`
--

CREATE TABLE `afk_claim_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `afk_session_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `claimed_exp` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `claimed_gold` decimal(18,2) NOT NULL DEFAULT 0.00,
  `claimed_at` datetime NOT NULL DEFAULT current_timestamp(),
  `note` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `afk_claim_logs`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `afk_configs`
--

CREATE TABLE `afk_configs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `config_key` varchar(100) NOT NULL,
  `config_value` varchar(255) NOT NULL,
  `value_type` enum('string','int','decimal','json','bool') NOT NULL DEFAULT 'string',
  `description` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `afk_configs`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `afk_sessions`
--

CREATE TABLE `afk_sessions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `started_at` datetime NOT NULL,
  `ended_at` datetime DEFAULT NULL,
  `duration_seconds` int(11) NOT NULL DEFAULT 0,
  `base_exp_earned` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `bonus_exp_earned` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `total_exp_earned` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `claim_status` enum('pending','claimed','expired') NOT NULL DEFAULT 'pending',
  `session_status` enum('running','finished','cancelled') NOT NULL DEFAULT 'running',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `afk_sessions`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `actor_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `action_module` varchar(100) NOT NULL,
  `action_type` varchar(100) NOT NULL,
  `target_table` varchar(100) DEFAULT NULL,
  `target_id` bigint(20) UNSIGNED DEFAULT NULL,
  `old_data_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_data_json`)),
  `new_data_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_data_json`)),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `authors`
--

CREATE TABLE `authors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `bio` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `authors`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_tokens`
--

CREATE TABLE `auth_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `token_type` enum('verify_email','reset_password','refresh_token','session_token') NOT NULL,
  `token_value` varchar(255) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  `used_at` datetime DEFAULT NULL,
  `revoked_at` datetime DEFAULT NULL,
  `ip_address` varchar(64) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `meta_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta_json`)),
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `auth_tokens`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chapters`
--

CREATE TABLE `chapters` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `comic_id` bigint(20) UNSIGNED NOT NULL,
  `chapter_number` decimal(10,2) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `summary` text DEFAULT NULL,
  `access_type` enum('free','vip_required','premium_required') NOT NULL DEFAULT 'free',
  `publish_status` enum('draft','published','hidden') NOT NULL DEFAULT 'draft',
  `view_count` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `released_at` datetime DEFAULT NULL,
  `created_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `chapters`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chapter_images`
--

CREATE TABLE `chapter_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `chapter_id` bigint(20) UNSIGNED NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `display_order` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `chapter_images`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chat_messages`
--

CREATE TABLE `chat_messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `room_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `reply_to_message_id` bigint(20) UNSIGNED DEFAULT NULL,
  `message_type` enum('text','image','system') NOT NULL DEFAULT 'text',
  `content` text NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  `sent_at` datetime NOT NULL DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `chat_messages`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chat_rooms`
--

CREATE TABLE `chat_rooms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `room_type` enum('global','guild','vip','system','custom') NOT NULL DEFAULT 'global',
  `name` varchar(150) NOT NULL,
  `code` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `linked_guild_id` bigint(20) UNSIGNED DEFAULT NULL,
  `min_vip_level_id` bigint(20) UNSIGNED DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `chat_rooms`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chat_room_members`
--

CREATE TABLE `chat_room_members` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `room_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `member_role` enum('owner','moderator','member') NOT NULL DEFAULT 'member',
  `joined_at` datetime NOT NULL DEFAULT current_timestamp(),
  `muted_until` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `chat_room_members`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `comics`
--

CREATE TABLE `comics` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `author_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `cover_image_url` varchar(255) DEFAULT NULL,
  `banner_image_url` varchar(255) DEFAULT NULL,
  `summary` text DEFAULT NULL,
  `publication_status` enum('ongoing','completed','hiatus','draft') NOT NULL DEFAULT 'draft',
  `visibility_status` enum('public','private','hidden') NOT NULL DEFAULT 'public',
  `age_rating` enum('all','teen','mature') NOT NULL DEFAULT 'all',
  `total_views` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `total_follows` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `created_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `comics`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `comic_genres`
--

CREATE TABLE `comic_genres` (
  `comic_id` bigint(20) UNSIGNED NOT NULL,
  `genre_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `comic_genres`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `comments`
--

CREATE TABLE `comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `comic_id` bigint(20) UNSIGNED DEFAULT NULL,
  `chapter_id` bigint(20) UNSIGNED DEFAULT NULL,
  `parent_comment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `content` text NOT NULL,
  `comment_status` enum('visible','hidden','deleted') NOT NULL DEFAULT 'visible',
  `like_count` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `report_count` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `comments`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cultivation_breakthrough_rules`
--

CREATE TABLE `cultivation_breakthrough_rules` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `from_realm_id` bigint(20) UNSIGNED NOT NULL,
  `to_realm_id` bigint(20) UNSIGNED NOT NULL,
  `required_level_number` int(11) NOT NULL,
  `required_power_score` bigint(20) NOT NULL DEFAULT 0,
  `required_item_id` bigint(20) UNSIGNED DEFAULT NULL,
  `required_item_quantity` int(11) NOT NULL DEFAULT 0,
  `required_gold` decimal(18,2) NOT NULL DEFAULT 0.00,
  `success_rate_percent` decimal(5,2) NOT NULL DEFAULT 100.00,
  `description` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `daily_checkins`
--

CREATE TABLE `daily_checkins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `checkin_date` date NOT NULL,
  `streak_count` int(11) NOT NULL DEFAULT 1,
  `reward_gold` decimal(18,2) NOT NULL DEFAULT 0.00,
  `reward_exp` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `daily_checkins`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `equipment_slots`
--

CREATE TABLE `equipment_slots` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `follows`
--

CREATE TABLE `follows` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `comic_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `genres`
--

CREATE TABLE `genres` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(120) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `genres`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `guilds`
--

CREATE TABLE `guilds` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `slug` varchar(150) NOT NULL,
  `logo_url` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `announcement` text DEFAULT NULL,
  `leader_user_id` bigint(20) UNSIGNED NOT NULL,
  `member_limit` int(11) NOT NULL DEFAULT 30,
  `level` int(11) NOT NULL DEFAULT 1,
  `contribution_points` bigint(20) NOT NULL DEFAULT 0,
  `guild_power` bigint(20) NOT NULL DEFAULT 0,
  `guild_status` enum('active','locked','disbanded') NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `guilds`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `guild_announcements`
--

CREATE TABLE `guild_announcements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `guild_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(150) NOT NULL,
  `content` text NOT NULL,
  `posted_by_user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `guild_donations`
--

CREATE TABLE `guild_donations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `guild_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `donation_type` enum('gold','premium_currency','item','spirit_stone') NOT NULL DEFAULT 'gold',
  `item_id` bigint(20) UNSIGNED DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  `donated_at` datetime NOT NULL DEFAULT current_timestamp(),
  `note` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `guild_donations`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `guild_join_requests`
--

CREATE TABLE `guild_join_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `guild_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `request_message` varchar(255) DEFAULT NULL,
  `request_status` enum('pending','approved','rejected','cancelled') NOT NULL DEFAULT 'pending',
  `reviewed_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `guild_join_requests`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `guild_logs`
--

CREATE TABLE `guild_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `guild_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `action_type` enum('create','join','approve_join','reject_join','leave','kick','promote','demote','donate','announcement','disband') NOT NULL,
  `target_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `details` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `guild_logs`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `guild_members`
--

CREATE TABLE `guild_members` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `guild_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `guild_role_id` bigint(20) UNSIGNED NOT NULL,
  `join_status` enum('active','left','kicked') NOT NULL DEFAULT 'active',
  `contribution_points` bigint(20) NOT NULL DEFAULT 0,
  `joined_at` datetime NOT NULL DEFAULT current_timestamp(),
  `left_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `guild_members`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `guild_roles`
--

CREATE TABLE `guild_roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `hierarchy_level` int(11) NOT NULL,
  `can_manage_members` tinyint(1) NOT NULL DEFAULT 0,
  `can_approve_join` tinyint(1) NOT NULL DEFAULT 0,
  `can_post_notice` tinyint(1) NOT NULL DEFAULT 0,
  `can_manage_chat` tinyint(1) NOT NULL DEFAULT 0,
  `can_promote_members` tinyint(1) NOT NULL DEFAULT 0,
  `can_manage_guild` tinyint(1) NOT NULL DEFAULT 0,
  `description` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `guild_roles`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `items`
--

CREATE TABLE `items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `item_type_id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `icon_url` varchar(255) DEFAULT NULL,
  `rarity` enum('common','rare','epic','legendary','mythic') NOT NULL DEFAULT 'common',
  `is_stackable` tinyint(1) NOT NULL DEFAULT 1,
  `max_stack` int(11) NOT NULL DEFAULT 999,
  `usable_instantly` tinyint(1) NOT NULL DEFAULT 0,
  `equippable` tinyint(1) NOT NULL DEFAULT 0,
  `exp_bonus` bigint(20) NOT NULL DEFAULT 0,
  `power_bonus` bigint(20) NOT NULL DEFAULT 0,
  `afk_bonus_percent` decimal(5,2) NOT NULL DEFAULT 0.00,
  `vip_required_level` int(11) NOT NULL DEFAULT 0,
  `sellable` tinyint(1) NOT NULL DEFAULT 1,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `items`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `item_transactions`
--

CREATE TABLE `item_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `item_id` bigint(20) UNSIGNED NOT NULL,
  `transaction_type` enum('buy_from_shop','sell_to_system','reward','use_item','admin_grant','admin_remove') NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `unit_price_gold` decimal(18,2) NOT NULL DEFAULT 0.00,
  `unit_price_premium` decimal(18,2) NOT NULL DEFAULT 0.00,
  `total_price_gold` decimal(18,2) NOT NULL DEFAULT 0.00,
  `total_price_premium` decimal(18,2) NOT NULL DEFAULT 0.00,
  `note` varchar(255) DEFAULT NULL,
  `created_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `item_transactions`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `item_types`
--

CREATE TABLE `item_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `item_types`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `levels`
--

CREATE TABLE `levels` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `level_number` int(11) NOT NULL,
  `exp_required` bigint(20) UNSIGNED NOT NULL,
  `reward_gold` decimal(18,2) NOT NULL DEFAULT 0.00,
  `reward_premium` decimal(18,2) NOT NULL DEFAULT 0.00,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `levels`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `message_reports`
--

CREATE TABLE `message_reports` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `message_id` bigint(20) UNSIGNED NOT NULL,
  `reported_by_user_id` bigint(20) UNSIGNED NOT NULL,
  `reason` varchar(255) NOT NULL,
  `report_status` enum('pending','reviewed','dismissed','action_taken') NOT NULL DEFAULT 'pending',
  `reviewed_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `missions`
--

CREATE TABLE `missions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(50) NOT NULL,
  `title` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `mission_type` enum('daily','weekly','event','story') NOT NULL DEFAULT 'daily',
  `target_type` enum('read_chapter','login','comment','afk','buy_item','join_guild','chat','custom') NOT NULL,
  `target_value` int(11) NOT NULL DEFAULT 1,
  `reward_gold` decimal(18,2) NOT NULL DEFAULT 0.00,
  `reward_exp` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `reward_item_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reward_item_qty` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `start_at` datetime DEFAULT NULL,
  `end_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `missions`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment_packages`
--

CREATE TABLE `payment_packages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(150) NOT NULL,
  `price_amount` decimal(18,2) NOT NULL,
  `currency_code` varchar(10) NOT NULL DEFAULT 'VND',
  `premium_reward` decimal(18,2) NOT NULL DEFAULT 0.00,
  `vip_exp_reward` decimal(18,2) NOT NULL DEFAULT 0.00,
  `bonus_percent` decimal(5,2) NOT NULL DEFAULT 0.00,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `payment_packages`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment_transactions`
--

CREATE TABLE `payment_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `payment_package_id` bigint(20) UNSIGNED DEFAULT NULL,
  `external_txn_code` varchar(100) DEFAULT NULL,
  `payment_method` varchar(50) NOT NULL,
  `request_amount` decimal(18,2) NOT NULL,
  `amount` decimal(18,2) NOT NULL,
  `currency_code` varchar(10) NOT NULL DEFAULT 'VND',
  `payment_status` enum('pending','success','failed','cancelled','refunded') NOT NULL DEFAULT 'pending',
  `premium_granted` decimal(18,2) NOT NULL DEFAULT 0.00,
  `vip_exp_granted` decimal(18,2) NOT NULL DEFAULT 0.00,
  `completed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `payment_type` enum('package','topup') NOT NULL DEFAULT 'topup'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `payment_transactions`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `ranking_snapshots`
--

CREATE TABLE `ranking_snapshots` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ranking_type` enum('power','level','vip','guild_power') NOT NULL,
  `entity_type` enum('user','guild') NOT NULL DEFAULT 'user',
  `entity_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `score_value` bigint(20) NOT NULL,
  `payload_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`payload_json`)),
  `snapshot_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `rank_position` int(11) NOT NULL,
  `snapshot_date` date NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `ranking_snapshots`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `reading_history`
--

CREATE TABLE `reading_history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `comic_id` bigint(20) UNSIGNED NOT NULL,
  `chapter_id` bigint(20) UNSIGNED NOT NULL,
  `last_page_number` int(11) NOT NULL DEFAULT 1,
  `progress_percent` decimal(5,2) NOT NULL DEFAULT 0.00,
  `last_read_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `realms`
--

CREATE TABLE `realms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `realm_order` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `base_power_bonus` bigint(20) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `realms`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `roles`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `shop_items`
--

CREATE TABLE `shop_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `item_id` bigint(20) UNSIGNED NOT NULL,
  `price_gold` decimal(18,2) NOT NULL DEFAULT 0.00,
  `price_premium` decimal(18,2) NOT NULL DEFAULT 0.00,
  `stock_quantity` int(11) DEFAULT NULL,
  `daily_purchase_limit` int(11) DEFAULT NULL,
  `vip_required_level` int(11) NOT NULL DEFAULT 0,
  `start_at` datetime DEFAULT NULL,
  `end_at` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `shop_items`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `system_configs`
--

CREATE TABLE `system_configs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `config_key` varchar(100) NOT NULL,
  `config_value` text NOT NULL,
  `value_type` enum('string','int','decimal','json','bool') NOT NULL DEFAULT 'string',
  `description` text DEFAULT NULL,
  `updated_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `system_notifications`
--

CREATE TABLE `system_notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(150) NOT NULL,
  `content` text NOT NULL,
  `target_scope` enum('all','vip_only','guild_only','specific_users') NOT NULL DEFAULT 'all',
  `sent_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `scheduled_at` datetime DEFAULT NULL,
  `sent_at` datetime DEFAULT NULL,
  `notification_status` enum('draft','scheduled','sent','cancelled') NOT NULL DEFAULT 'draft',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `system_notifications`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `display_name` varchar(100) NOT NULL,
  `avatar_url` varchar(255) DEFAULT NULL,
  `account_status` enum('active','banned','suspended','pending') NOT NULL DEFAULT 'active',
  `is_verified` tinyint(1) NOT NULL DEFAULT 0,
  `last_login_at` datetime DEFAULT NULL,
  `current_guild_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  `status` enum('active','inactive','suspended','banned') NOT NULL DEFAULT 'active',
  `is_email_verified` tinyint(1) NOT NULL DEFAULT 0,
  `email_verified_at` datetime DEFAULT NULL,
  `last_login_ip` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user_cultivation`
--

CREATE TABLE `user_cultivation` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `current_level_id` bigint(20) UNSIGNED NOT NULL,
  `current_realm_id` bigint(20) UNSIGNED NOT NULL,
  `current_exp` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `total_exp_earned` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `breakthrough_count` int(11) NOT NULL DEFAULT 0,
  `spirit_stones` decimal(18,2) NOT NULL DEFAULT 0.00,
  `reputation_points` bigint(20) NOT NULL DEFAULT 0,
  `combat_power` bigint(20) NOT NULL DEFAULT 0,
  `last_breakthrough_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `user_cultivation`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user_equipment`
--

CREATE TABLE `user_equipment` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `slot_id` bigint(20) UNSIGNED NOT NULL,
  `item_id` bigint(20) UNSIGNED NOT NULL,
  `equipped_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user_inventory`
--

CREATE TABLE `user_inventory` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `item_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `is_bound` tinyint(1) NOT NULL DEFAULT 0,
  `obtained_from` varchar(100) DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `user_inventory`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user_missions`
--

CREATE TABLE `user_missions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `mission_id` bigint(20) UNSIGNED NOT NULL,
  `progress_value` int(11) NOT NULL DEFAULT 0,
  `mission_status` enum('in_progress','completed','claimed','expired') NOT NULL DEFAULT 'in_progress',
  `assigned_date` date NOT NULL,
  `completed_at` datetime DEFAULT NULL,
  `claimed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `user_missions`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user_notifications`
--

CREATE TABLE `user_notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `system_notification_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(150) NOT NULL,
  `content` text NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `read_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `user_notifications`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user_profiles`
--

CREATE TABLE `user_profiles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `full_name` varchar(150) DEFAULT NULL,
  `phone_number` varchar(30) DEFAULT NULL,
  `gender` enum('male','female','other','unknown') NOT NULL DEFAULT 'unknown',
  `birth_date` date DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `gold_balance` decimal(18,2) NOT NULL DEFAULT 0.00,
  `premium_currency` decimal(18,2) NOT NULL DEFAULT 0.00,
  `energy` int(11) NOT NULL DEFAULT 100,
  `stamina` int(11) NOT NULL DEFAULT 100,
  `power_score` bigint(20) NOT NULL DEFAULT 0,
  `current_title` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `user_profiles`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user_status_logs`
--

CREATE TABLE `user_status_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `old_status` enum('active','banned','suspended','pending') DEFAULT NULL,
  `new_status` enum('active','banned','suspended','pending') NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `changed_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `user_status_logs`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user_vip`
--

CREATE TABLE `user_vip` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `current_vip_level_id` bigint(20) UNSIGNED NOT NULL,
  `total_topup_amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  `vip_exp` decimal(18,2) NOT NULL DEFAULT 0.00,
  `vip_started_at` datetime DEFAULT NULL,
  `last_level_up_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `user_vip`
--


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `vip_benefits`
--

CREATE TABLE `vip_benefits` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vip_level_id` bigint(20) UNSIGNED NOT NULL,
  `benefit_code` varchar(100) NOT NULL,
  `benefit_name` varchar(150) NOT NULL,
  `benefit_value` varchar(150) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `vip_feature_unlocks`
--

CREATE TABLE `vip_feature_unlocks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `feature_code` varchar(100) NOT NULL,
  `feature_name` varchar(150) NOT NULL,
  `required_vip_level_id` bigint(20) UNSIGNED NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `vip_levels`
--

CREATE TABLE `vip_levels` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `level_number` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `required_topup_amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  `badge_name` varchar(100) DEFAULT NULL,
  `badge_color` varchar(30) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `vip_levels`
--


--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `afk_claim_logs`
--
ALTER TABLE `afk_claim_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_afk_claim_logs_session` (`afk_session_id`),
  ADD KEY `fk_afk_claim_logs_user` (`user_id`);

--
-- Chỉ mục cho bảng `afk_configs`
--
ALTER TABLE `afk_configs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `config_key` (`config_key`);

--
-- Chỉ mục cho bảng `afk_sessions`
--
ALTER TABLE `afk_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_afk_sessions_user_status` (`user_id`,`session_status`,`claim_status`);

--
-- Chỉ mục cho bảng `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_audit_logs_actor` (`actor_user_id`),
  ADD KEY `idx_audit_logs_module_type` (`action_module`,`action_type`);

--
-- Chỉ mục cho bảng `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Chỉ mục cho bảng `auth_tokens`
--
ALTER TABLE `auth_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_auth_tokens_value` (`token_value`),
  ADD KEY `idx_auth_tokens_user_id` (`user_id`),
  ADD KEY `idx_auth_tokens_type` (`token_type`),
  ADD KEY `idx_auth_tokens_expires_at` (`expires_at`),
  ADD KEY `idx_auth_tokens_used_at` (`used_at`),
  ADD KEY `idx_auth_tokens_revoked_at` (`revoked_at`);

--
-- Chỉ mục cho bảng `chapters`
--
ALTER TABLE `chapters`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_chapter_slug_per_comic` (`comic_id`,`slug`),
  ADD UNIQUE KEY `uk_chapter_number_per_comic` (`comic_id`,`chapter_number`),
  ADD KEY `fk_chapters_created_by` (`created_by_user_id`),
  ADD KEY `idx_chapters_comic_release` (`comic_id`,`released_at`);

--
-- Chỉ mục cho bảng `chapter_images`
--
ALTER TABLE `chapter_images`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_chapter_image_order` (`chapter_id`,`display_order`);

--
-- Chỉ mục cho bảng `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_chat_messages_user` (`user_id`),
  ADD KEY `fk_chat_messages_reply` (`reply_to_message_id`),
  ADD KEY `idx_chat_messages_room_sent` (`room_id`,`sent_at`);

--
-- Chỉ mục cho bảng `chat_rooms`
--
ALTER TABLE `chat_rooms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Chỉ mục cho bảng `chat_room_members`
--
ALTER TABLE `chat_room_members`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_room_member` (`room_id`,`user_id`),
  ADD KEY `fk_chat_room_members_user` (`user_id`);

--
-- Chỉ mục cho bảng `comics`
--
ALTER TABLE `comics`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `fk_comics_author` (`author_id`),
  ADD KEY `fk_comics_created_by` (`created_by_user_id`),
  ADD KEY `idx_comics_status` (`publication_status`,`visibility_status`),
  ADD KEY `idx_comics_title` (`title`);

--
-- Chỉ mục cho bảng `comic_genres`
--
ALTER TABLE `comic_genres`
  ADD PRIMARY KEY (`comic_id`,`genre_id`),
  ADD KEY `fk_comic_genres_genre` (`genre_id`);

--
-- Chỉ mục cho bảng `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_comments_user` (`user_id`),
  ADD KEY `fk_comments_parent` (`parent_comment_id`),
  ADD KEY `idx_comments_comic` (`comic_id`),
  ADD KEY `idx_comments_chapter` (`chapter_id`);

--
-- Chỉ mục cho bảng `cultivation_breakthrough_rules`
--
ALTER TABLE `cultivation_breakthrough_rules`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_breakthrough_pair` (`from_realm_id`,`to_realm_id`),
  ADD KEY `fk_breakthrough_to_realm` (`to_realm_id`);

--
-- Chỉ mục cho bảng `daily_checkins`
--
ALTER TABLE `daily_checkins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_user_checkin_date` (`user_id`,`checkin_date`);

--
-- Chỉ mục cho bảng `equipment_slots`
--
ALTER TABLE `equipment_slots`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Chỉ mục cho bảng `follows`
--
ALTER TABLE `follows`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_user_comic_follow` (`user_id`,`comic_id`),
  ADD KEY `fk_follows_comic` (`comic_id`);

--
-- Chỉ mục cho bảng `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Chỉ mục cho bảng `guilds`
--
ALTER TABLE `guilds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `fk_guilds_leader` (`leader_user_id`);

--
-- Chỉ mục cho bảng `guild_announcements`
--
ALTER TABLE `guild_announcements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_guild_announcements_guild` (`guild_id`),
  ADD KEY `fk_guild_announcements_posted_by` (`posted_by_user_id`);

--
-- Chỉ mục cho bảng `guild_donations`
--
ALTER TABLE `guild_donations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_guild_donations_guild` (`guild_id`),
  ADD KEY `fk_guild_donations_user` (`user_id`),
  ADD KEY `fk_guild_donations_item` (`item_id`);

--
-- Chỉ mục cho bảng `guild_join_requests`
--
ALTER TABLE `guild_join_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_user_pending_guild_request` (`guild_id`,`user_id`),
  ADD KEY `fk_guild_join_requests_user` (`user_id`),
  ADD KEY `fk_guild_join_requests_reviewed_by` (`reviewed_by_user_id`),
  ADD KEY `idx_guild_join_requests_status` (`request_status`);

--
-- Chỉ mục cho bảng `guild_logs`
--
ALTER TABLE `guild_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_guild_logs_user` (`user_id`),
  ADD KEY `fk_guild_logs_target_user` (`target_user_id`),
  ADD KEY `idx_guild_logs_guild_date` (`guild_id`,`created_at`);

--
-- Chỉ mục cho bảng `guild_members`
--
ALTER TABLE `guild_members`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_guild_member_active` (`guild_id`,`user_id`),
  ADD KEY `fk_guild_members_role` (`guild_role_id`),
  ADD KEY `idx_guild_members_user` (`user_id`);

--
-- Chỉ mục cho bảng `guild_roles`
--
ALTER TABLE `guild_roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD UNIQUE KEY `hierarchy_level` (`hierarchy_level`);

--
-- Chỉ mục cho bảng `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `idx_items_type_active` (`item_type_id`,`is_active`);

--
-- Chỉ mục cho bảng `item_transactions`
--
ALTER TABLE `item_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_item_transactions_item` (`item_id`),
  ADD KEY `fk_item_transactions_created_by` (`created_by_user_id`),
  ADD KEY `idx_item_transactions_user_type_date` (`user_id`,`transaction_type`,`created_at`);

--
-- Chỉ mục cho bảng `item_types`
--
ALTER TABLE `item_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Chỉ mục cho bảng `levels`
--
ALTER TABLE `levels`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `level_number` (`level_number`);

--
-- Chỉ mục cho bảng `message_reports`
--
ALTER TABLE `message_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_message_reports_message` (`message_id`),
  ADD KEY `fk_message_reports_reporter` (`reported_by_user_id`),
  ADD KEY `fk_message_reports_reviewer` (`reviewed_by_user_id`),
  ADD KEY `idx_message_reports_status` (`report_status`);

--
-- Chỉ mục cho bảng `missions`
--
ALTER TABLE `missions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Chỉ mục cho bảng `payment_packages`
--
ALTER TABLE `payment_packages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Chỉ mục cho bảng `payment_transactions`
--
ALTER TABLE `payment_transactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `external_txn_code` (`external_txn_code`),
  ADD KEY `fk_payment_transactions_package` (`payment_package_id`),
  ADD KEY `idx_payment_transactions_user_status` (`user_id`,`payment_status`);

--
-- Chỉ mục cho bảng `ranking_snapshots`
--
ALTER TABLE `ranking_snapshots`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_ranking_entity_snapshot` (`ranking_type`,`entity_type`,`entity_id`,`snapshot_at`),
  ADD KEY `fk_ranking_snapshots_user` (`user_id`),
  ADD KEY `idx_ranking_snapshots_type_date_rank` (`ranking_type`,`snapshot_date`,`rank_position`);

--
-- Chỉ mục cho bảng `reading_history`
--
ALTER TABLE `reading_history`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_user_chapter_history` (`user_id`,`chapter_id`),
  ADD KEY `fk_reading_history_comic` (`comic_id`),
  ADD KEY `fk_reading_history_chapter` (`chapter_id`),
  ADD KEY `idx_reading_history_user_last_read` (`user_id`,`last_read_at`);

--
-- Chỉ mục cho bảng `realms`
--
ALTER TABLE `realms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `realm_order` (`realm_order`);

--
-- Chỉ mục cho bảng `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Chỉ mục cho bảng `shop_items`
--
ALTER TABLE `shop_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_shop_item_item` (`item_id`),
  ADD KEY `idx_shop_items_active` (`is_active`,`vip_required_level`);

--
-- Chỉ mục cho bảng `system_configs`
--
ALTER TABLE `system_configs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `config_key` (`config_key`),
  ADD KEY `fk_system_configs_updated_by` (`updated_by_user_id`);

--
-- Chỉ mục cho bảng `system_notifications`
--
ALTER TABLE `system_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_system_notifications_sender` (`sent_by_user_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `fk_users_role` (`role_id`),
  ADD KEY `idx_users_status` (`account_status`),
  ADD KEY `idx_users_current_guild` (`current_guild_id`);

--
-- Chỉ mục cho bảng `user_cultivation`
--
ALTER TABLE `user_cultivation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `fk_user_cultivation_level` (`current_level_id`),
  ADD KEY `idx_user_cultivation_realm_level` (`current_realm_id`,`current_level_id`);

--
-- Chỉ mục cho bảng `user_equipment`
--
ALTER TABLE `user_equipment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_user_equipment_slot` (`user_id`,`slot_id`),
  ADD KEY `fk_user_equipment_slot` (`slot_id`),
  ADD KEY `fk_user_equipment_item` (`item_id`);

--
-- Chỉ mục cho bảng `user_inventory`
--
ALTER TABLE `user_inventory`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_user_inventory_item_bound` (`user_id`,`item_id`,`is_bound`),
  ADD KEY `fk_user_inventory_item` (`item_id`),
  ADD KEY `idx_user_inventory_user` (`user_id`);

--
-- Chỉ mục cho bảng `user_missions`
--
ALTER TABLE `user_missions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_user_mission_date` (`user_id`,`mission_id`,`assigned_date`),
  ADD KEY `fk_user_missions_mission` (`mission_id`),
  ADD KEY `idx_user_missions_status_date` (`user_id`,`mission_status`,`assigned_date`);

--
-- Chỉ mục cho bảng `user_notifications`
--
ALTER TABLE `user_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_notifications_system` (`system_notification_id`),
  ADD KEY `idx_user_notifications_user_read` (`user_id`,`is_read`);

--
-- Chỉ mục cho bảng `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `user_status_logs`
--
ALTER TABLE `user_status_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_status_logs_user` (`user_id`),
  ADD KEY `fk_user_status_logs_changed_by` (`changed_by_user_id`);

--
-- Chỉ mục cho bảng `user_vip`
--
ALTER TABLE `user_vip`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `idx_user_vip_level` (`current_vip_level_id`);

--
-- Chỉ mục cho bảng `vip_benefits`
--
ALTER TABLE `vip_benefits`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_vip_benefit_code_level` (`vip_level_id`,`benefit_code`);

--
-- Chỉ mục cho bảng `vip_feature_unlocks`
--
ALTER TABLE `vip_feature_unlocks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `feature_code` (`feature_code`),
  ADD KEY `fk_vip_feature_unlocks_level` (`required_vip_level_id`);

--
-- Chỉ mục cho bảng `vip_levels`
--
ALTER TABLE `vip_levels`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `level_number` (`level_number`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `afk_claim_logs`
--
ALTER TABLE `afk_claim_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `afk_configs`
--
ALTER TABLE `afk_configs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `afk_sessions`
--
ALTER TABLE `afk_sessions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `authors`
--
ALTER TABLE `authors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `auth_tokens`
--
ALTER TABLE `auth_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=313;

--
-- AUTO_INCREMENT cho bảng `chapters`
--
ALTER TABLE `chapters`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT cho bảng `chapter_images`
--
ALTER TABLE `chapter_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT cho bảng `chat_messages`
--
ALTER TABLE `chat_messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT cho bảng `chat_rooms`
--
ALTER TABLE `chat_rooms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `chat_room_members`
--
ALTER TABLE `chat_room_members`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT cho bảng `comics`
--
ALTER TABLE `comics`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT cho bảng `guilds`
--
ALTER TABLE `guilds`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `guild_donations`
--
ALTER TABLE `guild_donations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT cho bảng `guild_join_requests`
--
ALTER TABLE `guild_join_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `guild_logs`
--
ALTER TABLE `guild_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `guild_members`
--
ALTER TABLE `guild_members`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT cho bảng `guild_roles`
--
ALTER TABLE `guild_roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `items`
--
ALTER TABLE `items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `item_transactions`
--
ALTER TABLE `item_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `item_types`
--
ALTER TABLE `item_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `levels`
--
ALTER TABLE `levels`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `missions`
--
ALTER TABLE `missions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `payment_packages`
--
ALTER TABLE `payment_packages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `payment_transactions`
--
ALTER TABLE `payment_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `ranking_snapshots`
--
ALTER TABLE `ranking_snapshots`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=153;

--
-- AUTO_INCREMENT cho bảng `realms`
--
ALTER TABLE `realms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `shop_items`
--
ALTER TABLE `shop_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `system_notifications`
--
ALTER TABLE `system_notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT cho bảng `user_cultivation`
--
ALTER TABLE `user_cultivation`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT cho bảng `user_inventory`
--
ALTER TABLE `user_inventory`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `user_notifications`
--
ALTER TABLE `user_notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT cho bảng `user_profiles`
--
ALTER TABLE `user_profiles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT cho bảng `user_vip`
--
ALTER TABLE `user_vip`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT cho bảng `vip_levels`
--
ALTER TABLE `vip_levels`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `afk_claim_logs`
--
ALTER TABLE `afk_claim_logs`
  ADD CONSTRAINT `fk_afk_claim_logs_session` FOREIGN KEY (`afk_session_id`) REFERENCES `afk_sessions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_afk_claim_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `afk_sessions`
--
ALTER TABLE `afk_sessions`
  ADD CONSTRAINT `fk_afk_sessions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `fk_audit_logs_actor` FOREIGN KEY (`actor_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `auth_tokens`
--
ALTER TABLE `auth_tokens`
  ADD CONSTRAINT `fk_auth_tokens_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `chapters`
--
ALTER TABLE `chapters`
  ADD CONSTRAINT `fk_chapters_comic` FOREIGN KEY (`comic_id`) REFERENCES `comics` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_chapters_created_by` FOREIGN KEY (`created_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `chapter_images`
--
ALTER TABLE `chapter_images`
  ADD CONSTRAINT `fk_chapter_images_chapter` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD CONSTRAINT `fk_chat_messages_reply` FOREIGN KEY (`reply_to_message_id`) REFERENCES `chat_messages` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_chat_messages_room` FOREIGN KEY (`room_id`) REFERENCES `chat_rooms` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_chat_messages_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `chat_room_members`
--
ALTER TABLE `chat_room_members`
  ADD CONSTRAINT `fk_chat_room_members_room` FOREIGN KEY (`room_id`) REFERENCES `chat_rooms` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_chat_room_members_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `comics`
--
ALTER TABLE `comics`
  ADD CONSTRAINT `fk_comics_author` FOREIGN KEY (`author_id`) REFERENCES `authors` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_comics_created_by` FOREIGN KEY (`created_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `comic_genres`
--
ALTER TABLE `comic_genres`
  ADD CONSTRAINT `fk_comic_genres_comic` FOREIGN KEY (`comic_id`) REFERENCES `comics` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_comic_genres_genre` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `fk_comments_chapter` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_comments_comic` FOREIGN KEY (`comic_id`) REFERENCES `comics` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_comments_parent` FOREIGN KEY (`parent_comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_comments_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `cultivation_breakthrough_rules`
--
ALTER TABLE `cultivation_breakthrough_rules`
  ADD CONSTRAINT `fk_breakthrough_from_realm` FOREIGN KEY (`from_realm_id`) REFERENCES `realms` (`id`),
  ADD CONSTRAINT `fk_breakthrough_to_realm` FOREIGN KEY (`to_realm_id`) REFERENCES `realms` (`id`);

--
-- Các ràng buộc cho bảng `daily_checkins`
--
ALTER TABLE `daily_checkins`
  ADD CONSTRAINT `fk_daily_checkins_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `follows`
--
ALTER TABLE `follows`
  ADD CONSTRAINT `fk_follows_comic` FOREIGN KEY (`comic_id`) REFERENCES `comics` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_follows_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `guilds`
--
ALTER TABLE `guilds`
  ADD CONSTRAINT `fk_guilds_leader` FOREIGN KEY (`leader_user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `guild_announcements`
--
ALTER TABLE `guild_announcements`
  ADD CONSTRAINT `fk_guild_announcements_guild` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_guild_announcements_posted_by` FOREIGN KEY (`posted_by_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `guild_donations`
--
ALTER TABLE `guild_donations`
  ADD CONSTRAINT `fk_guild_donations_guild` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_guild_donations_item` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_guild_donations_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `guild_join_requests`
--
ALTER TABLE `guild_join_requests`
  ADD CONSTRAINT `fk_guild_join_requests_guild` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_guild_join_requests_reviewed_by` FOREIGN KEY (`reviewed_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_guild_join_requests_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `guild_logs`
--
ALTER TABLE `guild_logs`
  ADD CONSTRAINT `fk_guild_logs_guild` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_guild_logs_target_user` FOREIGN KEY (`target_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_guild_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `guild_members`
--
ALTER TABLE `guild_members`
  ADD CONSTRAINT `fk_guild_members_guild` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_guild_members_role` FOREIGN KEY (`guild_role_id`) REFERENCES `guild_roles` (`id`),
  ADD CONSTRAINT `fk_guild_members_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `fk_items_item_type` FOREIGN KEY (`item_type_id`) REFERENCES `item_types` (`id`);

--
-- Các ràng buộc cho bảng `item_transactions`
--
ALTER TABLE `item_transactions`
  ADD CONSTRAINT `fk_item_transactions_created_by` FOREIGN KEY (`created_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_item_transactions_item` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_item_transactions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `message_reports`
--
ALTER TABLE `message_reports`
  ADD CONSTRAINT `fk_message_reports_message` FOREIGN KEY (`message_id`) REFERENCES `chat_messages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_message_reports_reporter` FOREIGN KEY (`reported_by_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_message_reports_reviewer` FOREIGN KEY (`reviewed_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `payment_transactions`
--
ALTER TABLE `payment_transactions`
  ADD CONSTRAINT `fk_payment_transactions_package` FOREIGN KEY (`payment_package_id`) REFERENCES `payment_packages` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_payment_transactions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `ranking_snapshots`
--
ALTER TABLE `ranking_snapshots`
  ADD CONSTRAINT `fk_ranking_snapshots_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `reading_history`
--
ALTER TABLE `reading_history`
  ADD CONSTRAINT `fk_reading_history_chapter` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_reading_history_comic` FOREIGN KEY (`comic_id`) REFERENCES `comics` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_reading_history_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `shop_items`
--
ALTER TABLE `shop_items`
  ADD CONSTRAINT `fk_shop_items_item` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `system_configs`
--
ALTER TABLE `system_configs`
  ADD CONSTRAINT `fk_system_configs_updated_by` FOREIGN KEY (`updated_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `system_notifications`
--
ALTER TABLE `system_notifications`
  ADD CONSTRAINT `fk_system_notifications_sender` FOREIGN KEY (`sent_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_current_guild` FOREIGN KEY (`current_guild_id`) REFERENCES `guilds` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_users_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Các ràng buộc cho bảng `user_cultivation`
--
ALTER TABLE `user_cultivation`
  ADD CONSTRAINT `fk_user_cultivation_level` FOREIGN KEY (`current_level_id`) REFERENCES `levels` (`id`),
  ADD CONSTRAINT `fk_user_cultivation_realm` FOREIGN KEY (`current_realm_id`) REFERENCES `realms` (`id`),
  ADD CONSTRAINT `fk_user_cultivation_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `user_equipment`
--
ALTER TABLE `user_equipment`
  ADD CONSTRAINT `fk_user_equipment_item` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  ADD CONSTRAINT `fk_user_equipment_slot` FOREIGN KEY (`slot_id`) REFERENCES `equipment_slots` (`id`),
  ADD CONSTRAINT `fk_user_equipment_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `user_inventory`
--
ALTER TABLE `user_inventory`
  ADD CONSTRAINT `fk_user_inventory_item` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_user_inventory_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `user_missions`
--
ALTER TABLE `user_missions`
  ADD CONSTRAINT `fk_user_missions_mission` FOREIGN KEY (`mission_id`) REFERENCES `missions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_user_missions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `user_notifications`
--
ALTER TABLE `user_notifications`
  ADD CONSTRAINT `fk_user_notifications_system` FOREIGN KEY (`system_notification_id`) REFERENCES `system_notifications` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_user_notifications_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD CONSTRAINT `fk_user_profiles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `user_status_logs`
--
ALTER TABLE `user_status_logs`
  ADD CONSTRAINT `fk_user_status_logs_changed_by` FOREIGN KEY (`changed_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_user_status_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `user_vip`
--
ALTER TABLE `user_vip`
  ADD CONSTRAINT `fk_user_vip_level` FOREIGN KEY (`current_vip_level_id`) REFERENCES `vip_levels` (`id`),
  ADD CONSTRAINT `fk_user_vip_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `vip_benefits`
--
ALTER TABLE `vip_benefits`
  ADD CONSTRAINT `fk_vip_benefits_level` FOREIGN KEY (`vip_level_id`) REFERENCES `vip_levels` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `vip_feature_unlocks`
--
ALTER TABLE `vip_feature_unlocks`
  ADD CONSTRAINT `fk_vip_feature_unlocks_level` FOREIGN KEY (`required_vip_level_id`) REFERENCES `vip_levels` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
