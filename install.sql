CREATE TABLE IF NOT EXISTS `splg_hunting_users` (
    `identifier` VARCHAR(100) NOT NULL,
    `tasks_completed` INT(11) NOT NULL DEFAULT 0,
    `level` INT(11) NOT NULL DEFAULT 1,
    `xp` INT(11) NOT NULL DEFAULT 0,
    PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `splg_hunting_tasks` (
    `id` INT(11) NOT NULL,
    `identifier` VARCHAR(100) NOT NULL PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `description` TEXT NOT NULL,
    `xp_reward` INT(11) UNSIGNED NOT NULL DEFAULT 0,
    `money_reward` INT(11) UNSIGNED NOT NULL DEFAULT 0,
    `requirements` LONGTEXT NOT NULL COLLATE utf8mb4_bin DEFAULT JSON_OBJECT() CHECK (JSON_VALID(`requirements`)),
    `completed` TINYINT(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DELIMITER //

CREATE TRIGGER after_task_completed
AFTER UPDATE ON `splg_hunting_tasks`
FOR EACH ROW
BEGIN
    IF NEW.completed = 1 AND OLD.completed = 0 THEN
        UPDATE `splg_hunting_users`
        SET `tasks_completed` = `tasks_completed` + 1
        WHERE `identifier` = NEW.identifier;
    END IF;
END//

DELIMITER ;
