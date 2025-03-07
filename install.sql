CREATE TABLE IF NOT EXISTS `splg_hunting_users` (
    `user_id` VARCHAR(100) NOT NULL,
    `tasks_completed` INT(11) UNSIGNED NOT NULL DEFAULT 0,
    `level` INT(11) NOT NULL DEFAULT 1,
    `xp` INT(11) NOT NULL DEFAULT 0,
    PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `splg_hunting_tasks` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` VARCHAR(100) NOT NULL,
    `title` VARCHAR(100) NOT NULL,
    `xp_reward` INT(11) UNSIGNED NOT NULL,
    `cash_reward` INT(11) UNSIGNED NOT NULL,
    `requirements` LONGTEXT NOT NULL COLLATE utf8mb4_bin DEFAULT JSON_OBJECT() CHECK (JSON_VALID(`requirements`)),
    `progress` LONGTEXT NOT NULL COLLATE utf8mb4_bin DEFAULT JSON_OBJECT() CHECK (JSON_VALID(`progress`)),
    `completed` TINYINT(1) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    CONSTRAINT `user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `splg_hunting_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TRIGGER IF NOT EXISTS after_task_completed
AFTER UPDATE ON `splg_hunting_tasks`
FOR EACH ROW
BEGIN
    IF NEW.completed = 1 AND OLD.completed = 0 THEN
        UPDATE `splg_hunting_users`
        SET `tasks_completed` = `tasks_completed` + 1
        WHERE `user_id` = NEW.user_id;
    END IF;
END;