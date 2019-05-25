CREATE TABLE `and_userinfo` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `device_user_id` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `intime` datetime DEFAULT NULL,
  `relationship` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_and_userinfo` (`userid`,`device_user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=97041 DEFAULT CHARSET=gbk;

CREATE TABLE `clean_message_log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `begintime` datetime DEFAULT NULL,
  `endtime` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5980 DEFAULT CHARSET=gbk;

CREATE TABLE `demo_account` (
  `userid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `getuithreadstate` (
  `threadid` int(11) NOT NULL AUTO_INCREMENT,
  `pipe` int(11) DEFAULT NULL,
  `currentcount` int(11) DEFAULT NULL,
  `maxcount` int(11) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`threadid`)
) ENGINE=InnoDB AUTO_INCREMENT=15129 DEFAULT CHARSET=gbk;

CREATE TABLE `gtreglog` (
  `ID` bigint(20) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `device_user_id` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `relationship` smallint(6) DEFAULT NULL,
  `sysop` smallint(6) DEFAULT NULL,
  `action` smallint(6) DEFAULT NULL,
  `gtregdate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

CREATE TABLE `move_message_log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `begintime` datetime DEFAULT NULL,
  `endtime` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=119049 DEFAULT CHARSET=gbk;

CREATE TABLE `pmid_gettui` (
  `uuid` varchar(50) DEFAULT NULL,
  `pmid` bigint(20) NOT NULL,
  PRIMARY KEY (`pmid`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

CREATE TABLE `pmid_receivedate` (
  `pmid` bigint(20) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `receivedate` datetime DEFAULT NULL,
  `adddate` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

CREATE TABLE `pmid_receivedate_history` (
  `pmid` bigint(20) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `receivedate` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=gbk;
CREATE TABLE `pmid_senddate` (
  `pmid` bigint(20) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `senddate` datetime DEFAULT NULL,
  `adddate` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

CREATE TABLE `pmid_senddate_history` (
  `pmid` bigint(20) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `senddate` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

CREATE TABLE `push_log` (
  `userid` int(11) DEFAULT NULL,
  `channel_id` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `device_user_id` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `tag` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `pmid` bigint(20) DEFAULT NULL,
  `result` varchar(1000) CHARACTER SET latin1 DEFAULT NULL,
  `intime` datetime DEFAULT CURRENT_TIMESTAMP,
  `pcid` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `pmtype` smallint(6) DEFAULT NULL,
  KEY `idx_pmid` (`pmid`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

CREATE TABLE `push_log_history` (
  `userid` int(11) DEFAULT NULL,
  `channel_id` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `device_user_id` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `tag` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `pmid` bigint(20) DEFAULT NULL,
  `result` varchar(1000) CHARACTER SET latin1 DEFAULT NULL,
  `intime` datetime DEFAULT CURRENT_TIMESTAMP,
  `pcid` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `pmtype` smallint(6) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=gbk;

CREATE TABLE `push_message` (
  `pmid` bigint(20) NOT NULL DEFAULT '0',
  `userid` bigint(20) DEFAULT NULL,
  `publicid` int(11) DEFAULT NULL,
  `pcid` bigint(20) DEFAULT NULL,
  `msgtype` varchar(50) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `action` smallint(6) DEFAULT NULL,
  `adddate` datetime DEFAULT NULL,
  `receivedate` datetime DEFAULT NULL,
  `deletetag` smallint(6) DEFAULT NULL,
  `pctype` smallint(6) DEFAULT NULL,
  `senddate` datetime DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `file_url` varchar(200) DEFAULT NULL,
  `typeid` int(11) DEFAULT NULL,
  `optag` smallint(6) DEFAULT NULL,
  `pipe` smallint(6) DEFAULT NULL,
  `location` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`pmid`),
  KEY `idx_push_message` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

CREATE TABLE `push_message_00` (
  `pmid` bigint(20) NOT NULL DEFAULT '0',
  `userid` bigint(20) DEFAULT NULL,
  `publicid` int(11) DEFAULT NULL,
  `pcid` bigint(20) DEFAULT NULL,
  `msgtype` varchar(50) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `action` smallint(6) DEFAULT NULL,
  `adddate` datetime DEFAULT NULL,
  `receivedate` datetime DEFAULT NULL,
  `deletetag` smallint(6) DEFAULT NULL,
  `pctype` smallint(6) DEFAULT NULL,
  `senddate` datetime DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `file_url` varchar(200) DEFAULT NULL,
  `typeid` int(11) DEFAULT NULL,
  `optag` smallint(6) DEFAULT NULL,
  `pipe` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`pmid`),
  KEY `idx_push_message_00` (`userid`,`adddate`,`deletetag`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

CREATE TABLE `push_message_01` (
  `pmid` bigint(20) NOT NULL DEFAULT '0',
  `userid` bigint(20) DEFAULT NULL,
  `publicid` int(11) DEFAULT NULL,
  `pcid` bigint(20) DEFAULT NULL,
  `msgtype` varchar(50) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `action` smallint(6) DEFAULT NULL,
  `adddate` datetime DEFAULT NULL,
  `receivedate` datetime DEFAULT NULL,
  `deletetag` smallint(6) DEFAULT NULL,
  `pctype` smallint(6) DEFAULT NULL,
  `senddate` datetime DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `file_url` varchar(200) DEFAULT NULL,
  `typeid` int(11) DEFAULT NULL,
  `optag` smallint(6) DEFAULT NULL,
  `pipe` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`pmid`),
  KEY `idx_push_message_01` (`userid`,`adddate`,`deletetag`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

CREATE TABLE `push_message_history` (
  `pmid` bigint(20) NOT NULL DEFAULT '0',
  `userid` bigint(20) DEFAULT NULL,
  `publicid` int(11) DEFAULT NULL,
  `pcid` bigint(20) DEFAULT NULL,
  `msgtype` varchar(50) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `action` smallint(6) DEFAULT NULL,
  `adddate` datetime DEFAULT NULL,
  `receivedate` datetime DEFAULT NULL,
  `deletetag` smallint(6) DEFAULT NULL,
  `pctype` smallint(6) DEFAULT NULL,
  `senddate` datetime DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `file_url` varchar(200) DEFAULT NULL,
  `typeid` int(11) DEFAULT NULL,
  `optag` smallint(6) DEFAULT NULL,
  `pipe` smallint(6) DEFAULT NULL,
  `tb` smallint(6) DEFAULT NULL,
  `db` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

CREATE TABLE `push_message_move` (
  `pmid` bigint(20) NOT NULL DEFAULT '0',
  `userid` bigint(20) DEFAULT NULL,
  `publicid` int(11) DEFAULT NULL,
  `pcid` bigint(20) DEFAULT NULL,
  `msgtype` varchar(50) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `action` smallint(6) DEFAULT NULL,
  `adddate` datetime DEFAULT NULL,
  `receivedate` datetime DEFAULT NULL,
  `deletetag` smallint(6) DEFAULT NULL,
  `pctype` smallint(6) DEFAULT NULL,
  `senddate` datetime DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `file_url` varchar(200) DEFAULT NULL,
  `typeid` int(11) DEFAULT NULL,
  `optag` smallint(6) DEFAULT NULL,
  `pipe` smallint(6) DEFAULT NULL,
  `location` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`pmid`),
  KEY `idx_push_message_move` (`pmid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;


CREATE TABLE `runningcheck` (
  `pipe` int(11) DEFAULT NULL,
  `lastrun` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

CREATE TABLE `send_record` (
  `ID` int(20) NOT NULL AUTO_INCREMENT,
  `exectime` datetime DEFAULT NULL,
  `pmidbegin` bigint(20) DEFAULT NULL,
  `pmidend` bigint(1) DEFAULT NULL,
  `msgidbegin` bigint(20) DEFAULT NULL,
  `msgidend` bigint(20) DEFAULT NULL,
  `UUID` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `send` bit(1) DEFAULT NULL,
  `getuigetdate` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_uuid` (`UUID`,`send`,`getuigetdate`)
) ENGINE=InnoDB AUTO_INCREMENT=2367877 DEFAULT CHARSET=gbk;

CREATE TABLE `send_record_history` (
  `ID` int(20) NOT NULL,
  `exectime` datetime DEFAULT NULL,
  `pmidbegin` bigint(20) DEFAULT NULL,
  `pmidend` bigint(1) DEFAULT NULL,
  `msgidbegin` bigint(20) DEFAULT NULL,
  `msgidend` bigint(20) DEFAULT NULL,
  `UUID` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `send` bit(1) DEFAULT NULL,
  `getuigetdate` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;


CREATE TABLE `user_message` (
  `msgid` bigint(20) DEFAULT NULL,
  `userid` bigint(20) DEFAULT NULL,
  `msgtype` smallint(6) DEFAULT NULL,
  `content` varchar(8000) CHARACTER SET utf8 DEFAULT NULL,
  `senderid` bigint(20) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `action` smallint(6) DEFAULT NULL,
  `adddate` datetime DEFAULT NULL,
  `receivedate` datetime DEFAULT NULL,
  `file_server` char(10) CHARACTER SET utf8 DEFAULT NULL,
  `device_user_id` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `senddate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=gbk;
CREATE TABLE `user_sys_message` (
  `msgid` bigint(20) NOT NULL,
  `userid` bigint(20) DEFAULT NULL,
  `msgtype` varchar(50) DEFAULT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `adddate` datetime DEFAULT NULL,
  `receivedate` datetime DEFAULT NULL,
  `action` smallint(6) DEFAULT NULL,
  `senddate` datetime DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `crtdate` datetime DEFAULT NULL,
  `location` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`msgid`),
  KEY `idx_user_sys_message` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

CREATE TABLE `user_sys_message_00` (
  `msgid` bigint(20) NOT NULL,
  `userid` bigint(20) DEFAULT NULL,
  `msgtype` varchar(50) DEFAULT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `adddate` datetime DEFAULT NULL,
  `receivedate` datetime DEFAULT NULL,
  `action` smallint(6) DEFAULT NULL,
  `senddate` datetime DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `crtdate` datetime DEFAULT NULL,
  PRIMARY KEY (`msgid`),
  KEY `idx_user_sys_message_00` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;


CREATE TABLE `user_sys_message_01` (
  `msgid` bigint(20) NOT NULL,
  `userid` bigint(20) DEFAULT NULL,
  `msgtype` varchar(50) DEFAULT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `adddate` datetime DEFAULT NULL,
  `receivedate` datetime DEFAULT NULL,
  `action` smallint(6) DEFAULT NULL,
  `senddate` datetime DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `crtdate` datetime DEFAULT NULL,
  PRIMARY KEY (`msgid`),
  KEY `idx_user_sys_message_01` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

CREATE TABLE `user_sys_message_history` (
  `msgid` bigint(20) NOT NULL,
  `userid` bigint(20) DEFAULT NULL,
  `msgtype` varchar(50) DEFAULT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `adddate` datetime DEFAULT NULL,
  `receivedate` datetime DEFAULT NULL,
  `action` smallint(6) DEFAULT NULL,
  `senddate` datetime DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `crtdate` datetime DEFAULT NULL,
  `tb` smallint(6) DEFAULT NULL,
  `db` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=gbk;


CREATE TABLE `user_sys_message_move` (
  `msgid` bigint(20) NOT NULL,
  `userid` bigint(20) DEFAULT NULL,
  `msgtype` varchar(50) DEFAULT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `adddate` datetime DEFAULT NULL,
  `receivedate` datetime DEFAULT NULL,
  `action` smallint(6) DEFAULT NULL,
  `senddate` datetime DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `crtdate` datetime DEFAULT NULL,
  `location` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`msgid`),
  KEY `idx_user_sys_message_move` (`msgid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;


