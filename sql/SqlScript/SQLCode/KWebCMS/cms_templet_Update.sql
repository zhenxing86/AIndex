USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_templet_Update]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		xnl	
-- Create date: 2014-05-15
-- Description:	更新控件模版表
-- =============================================
CREATE PROCEDURE [dbo].[cms_templet_Update]
           @id int,
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
	UPDATE enlistonline_templet
	SET siteid =@siteid,
        title=@title,
        type=@type,
        procname=@procname,
        prams=@prams,
        orderno=@orderno,
        deletetag=@deletetag,
        cssclass=@cssclass,
        isrequired= @isrequired,
        procparam=@procparam,
        procparamvalue=@procparamvalue,
        defaultvalue=@defaultvalue,
        singleselect=@singleselect,
        ishide=@ishide 
	WHERE ID=@id

	IF @@ERROR <> 0
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		RETURN 1
	END
END

GO
