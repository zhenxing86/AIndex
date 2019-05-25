CREATE TABLE `msg_pmid` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `pmid` bigint(20) NOT NULL,
  `pcid` bigint(20) DEFAULT NULL,
  `crtdate` datetime DEFAULT NULL,
  `adddate` datetime DEFAULT NULL,
  `mysqldate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=3964758 DEFAULT CHARSET=utf8;

CREATE TABLE `msg_pmid_pc` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `pmid` bigint(20) NOT NULL,
  `pctype` smallint(6) DEFAULT NULL,
  `pcid` bigint(20) DEFAULT NULL,
  `crtdate` datetime DEFAULT NULL,
  `adddate` datetime DEFAULT NULL,
  `mysqldate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=38550 DEFAULT CHARSET=utf8;

CREATE TABLE `msg_statistics` (
  `pmid` bigint(20) NOT NULL,
  `pcid` bigint(20) DEFAULT NULL,
  `crtdate` datetime DEFAULT NULL,
  `adddate` datetime DEFAULT NULL,
  `mysqldate` datetime DEFAULT NULL,
  `getuigetdate` datetime DEFAULT NULL,
  `getuidate` datetime DEFAULT NULL,
  `senddate` datetime DEFAULT NULL,
  `receivedate` datetime DEFAULT NULL,
  `channel` varchar(10) DEFAULT NULL,
  `getuistatus` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`pmid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


CREATE TABLE `pmid_gettui_temp` (
  `uuid` varchar(50) DEFAULT NULL,
  `pmid` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=gbk;


CREATE TABLE `statistics_runlog` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `begintime` datetime DEFAULT NULL,
  `endtime` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1443 DEFAULT CHARSET=utf8;
