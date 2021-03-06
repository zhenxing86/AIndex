USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[tcf_setting_Add]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		xzx
-- Project: com.zgyey.ossapp
-- Create date: 2013-07-22
-- Description:	新增晨检枪参数设备信息
-- =============================================
CREATE PROCEDURE [dbo].[tcf_setting_Add]
@id	int
,@serialno	varchar(50)
,@kid	int
,@xmsj	varchar(50)
,@lsavesj	varchar(50)
,@gunnum	varchar(50)
,@devid	varchar(50)
,@alarmt	varchar(50)
,@tox	varchar(50)
,@tax	varchar(50)
,@tx0A	varchar(50)
,@tx0B	varchar(50)
,@t5A	varchar(50)
,@t5B	varchar(50)
,@t10A	varchar(50)
,@t10B	varchar(50)
,@t15A	varchar(50)
,@t15B	varchar(50)
,@t20A	varchar(50)
,@t20B	varchar(50)
,@t25A	varchar(50)
,@t25B	varchar(50)
,@t30A	varchar(50)
,@t30B	varchar(50)
,@t35A	varchar(50)
,@t35B	varchar(50)
,@t40A	varchar(50)
,@t40B	varchar(50)
,@td40A	varchar(50)
,@td40B	varchar(50)

,@tx0C	varchar(50)
,@tx0	varchar(50)
,@t5C	varchar(50)
,@t5	varchar(50)
,@t10C	varchar(50)
,@t10	varchar(50)
,@t15C	varchar(50)
,@t15	varchar(50)
,@t20C	varchar(50)
,@t20	varchar(50)
,@t25C	varchar(50)
,@t25	varchar(50)
,@t30C	varchar(50)
,@t30	varchar(50)
,@t35C	varchar(50)
,@t35	varchar(50)
,@t40C	varchar(50)
,@t40	varchar(50)
,@td40C	varchar(50)
,@td40	varchar(50)
,@txMaxTW	varchar(50)
,@txMaxDif	varchar(50)
,@t25x1	varchar(50)
,@t25x2	varchar(50)
,@t25y1	varchar(50)
,@t25y2	varchar(50)
AS
BEGIN

insert into [mcapp]..[tcf_setting]([serialno],[kid],[xmsj],[lsavesj],[gunnum]
		,[devid],[alarmt],[tox],[tax],[tx0A],[tx0B],[t5A]
		,[t5B],[t10A],[t10B],[t15A],[t15B],[t20A],[t20B]
		,[t25A],[t25B],[t30A],[t30B],[t35A],[t35B],[t40A]
		,[t40B],[td40A],[td40B],[tx0C],[tx0],[t5C]
		,[t5],[t10C],[t10],[t15C],[t15],[t20C],[t20]
		,[t25C],[t25],[t30C],[t30],[t35C],[t35],[t40C]
		,[t40],[td40C],[td40],[txMaxTW],[txMaxDif],t25x1,t25x2,t25y1,t25y2)
	values(@serialno,@kid,@xmsj,@lsavesj,@gunnum
		,@devid,@alarmt,@tox,@tax,@tx0A,@tx0B,@t5A
		,@t5B,@t10A,@t10B,@t15A,@t15B,@t20A,@t20B
		,@t25A,@t25B,@t30A,@t30B,@t35A,@t35B,@t40A
		,@t40B,@td40A,@td40B,@tx0C,@tx0,@t5C
		,@t5,@t10C,@t10,@t15C,@t15,@t20C,@t20
		,@t25C,@t25,@t30C,@t30,@t35C,@t35,@t40C
		,@t40,@td40C,@td40,@txMaxTW,@txMaxDif,@t25x1,@t25x2,@t25y1,@t25y2)
END




GO
