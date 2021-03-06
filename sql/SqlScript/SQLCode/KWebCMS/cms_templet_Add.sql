USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_templet_Add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		xnl
-- Create date: 2014-05-15
-- Description:	添加报名控件模版表
-- =============================================
CREATE PROCEDURE [dbo].[cms_templet_Add]
		@siteid int,
        @title nvarchar(100),
        @type nvarchar(50),
        @procname nvarchar(200),
        @prams nvarchar(50),
        @orderno int,
        @deletetag int,
        @cssclass nvarchar(100),
        @isrequired int,
        @procparam varchar(5000),
        @procparamvalue varchar(5000),
        @defaultvalue varchar(5000),
        @singleselect int,
        @ishide int
        
AS
BEGIN
	insert into dbo.enlistonline_templet values(@siteid,@title,@type,@procname,@prams,@orderno,@deletetag,@cssclass,@isrequired,@procparam,@procparamvalue,@defaultvalue,@singleselect,@ishide)
IF @@error<>0
    BEGIN
     RETURN 0
    END 
    ELSE
    BEGIN
      RETURN @@identity
    END	
END
GO
