CREATE
DATABASE db_app_log_alarm;
set global innodb_large_prefix=1;
set global innodb_file_format=BARRACUDA;
use db_app_log_alarm;
CREATE TABLE `t_log_app_error_alarm_164`
(
    `related_app_id` int(11) NOT NULL DEFAULT '0',
    `child_app`      varchar(200)         DEFAULT NULL,
    `summary`        text,
    `level`          int(11) NOT NULL DEFAULT '0',
    `ip`             varchar(200)         DEFAULT NULL,
    `cnt`            varchar(200)         DEFAULT NULL COMMENT 'calculate the detail of count()',
    `mdate`          varchar(50) NOT NULL DEFAULT '',
    `mtime`          int(11) unsigned NOT NULL DEFAULT '0',
    UNIQUE KEY `UNIQUE_INDEX` (`mdate`,`mtime`,`related_app_id`,`child_app`,`summary`(255),`level`,`ip`),
    KEY              `MTIME_INDEX` (`mtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
CREATE TABLE `t_log_fcm_error_alarm_178`
(
    `result` int(11) NOT NULL DEFAULT '0',
    `detail` varchar(200)         DEFAULT NULL,
    `cnt`    varchar(200)         DEFAULT NULL COMMENT 'calculate the real_name of count()',
    `mdate`  varchar(50) NOT NULL DEFAULT '',
    `mtime`  int(11) unsigned NOT NULL DEFAULT '0',
    UNIQUE KEY `UNIQUE_INDEX` (`mdate`,`mtime`,`result`,`detail`),
    KEY      `MTIME_INDEX` (`mtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
