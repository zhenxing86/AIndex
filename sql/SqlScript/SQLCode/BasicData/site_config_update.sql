USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[site_config_update]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		lx
-- Create date: 20110712
-- Description:更新幼儿园基础信息表
-- =============================================
CREATE PROCEDURE [dbo].[site_config_update]
@siteid int,
@code varchar(50),
@memo varchar(200),
@sumnum int,
@ispublish int,
@ptshortname varchar(100),
@theme varchar(50),
@linkman  varchar(50),
@status int
AS
BEGIN

  update kwebcms..site_config set code=@code,memo=@memo,
  smsnum=@sumnum,ispublish=@ispublish,ptshotname=@ptshortname,theme=@theme,linkman=@linkman
  ,[status]=@status where siteid=@siteid

END




GO
