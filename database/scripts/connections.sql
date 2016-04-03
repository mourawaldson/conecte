-- VERIFICATIONS

-- Check my status with a specific member (connection member in this case is the current member), what's the status from member 1 to member 2
EXPLAIN SELECT *
FROM `connection` AS `c`
WHERE (`c`.`member_id_main` = 2 AND `c`.`member_id_connection` = 1);

-- List of people I'm connected
EXPLAIN SELECT *
FROM `connection` AS `c`
WHERE (`c`.`member_id_main` = 1 AND `c`.`status` = 'CONNECTED');

-- List of people I'm pending accept
EXPLAIN SELECT *
FROM `connection` AS `c`
WHERE (`c`.`member_id_main` = 2 AND `c`.`status` = 'PENDING_ACCEPT');

-- List of people where my request is pending
EXPLAIN SELECT *
FROM `connection` AS `c`
WHERE (`c`.`member_id_main` = 1 AND `c`.`status` = 'PENDING_REQUEST');

-- List of custom labels for address
EXPLAIN SELECT DISTINCT `label`
FROM `address` AS `a`
INNER JOIN `member_address` AS `ma` ON `ma`.`address_id` = `a`.`id` AND `ma`.`member_id` = 1;

-- ------------------------------------------------

-- ACTIONS (faster than using OR with one statement)

-- Send request (member 1 send invitation to member 2)
START TRANSACTION;
INSERT INTO `connection` (`member_id_main`, `status`, `member_id_connection`) VALUES (1, 'PENDING_REQUEST', 2);
INSERT INTO `connection` (`member_id_main`, `status`, `member_id_connection`) VALUES (2, 'PENDING_ACCEPT', 1);
COMMIT;

-- Accept request
START TRANSACTION;
UPDATE `connection` AS `c` SET `c`.`status` = 'CONNECTED'
WHERE (`c`.`member_id_main` = 2 AND `c`.`member_id_connection` = 3);
UPDATE `connection` AS `c` SET `c`.`status` = 'CONNECTED'
WHERE (`c`.`member_id_main` = 3 AND `c`.`member_id_connection` = 2);
COMMIT;

-- Delete request
START TRANSACTION;
DELETE FROM `connection`
WHERE (`member_id_main` = 2 AND `member_id_connection` = 1);
DELETE FROM `connection`
WHERE (`member_id_main` = 1 AND `member_id_connection` = 2);
COMMIT;

-- Mark as spam (avoid receive more requests from specific member), member 2 spammed member 1
START TRANSACTION;
UPDATE `connection` AS `c` SET `c`.`status` = 'SPAMMED'
WHERE (`c`.`member_id_main` = 2 AND `c`.`member_id_connection` = 1);
DELETE FROM `connection`
WHERE (`member_id_main` = 1 AND `member_id_connection` = 2);
COMMIT;