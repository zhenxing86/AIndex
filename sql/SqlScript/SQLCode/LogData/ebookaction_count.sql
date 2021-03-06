USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[ebookaction_count]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		gaolao
-- Create date: 2011-3-9
-- Description:	我的电子书明细数量
-- =============================================
CREATE PROCEDURE [dbo].[ebookaction_count]
@account nvarchar(50),
@actionmodul int,
@begindate datetime,
@enddate datetime
AS
   declare @count int
     SELECT @count=count(*)         
        FROM ebook_logs e
         INNER JOIN kmp..t_users u on e.actionuserid=u.ID
        WHERE 
        LoginName like '%'+@account+'%'
        AND actionmodul=CASE @actionmodul WHEN 0 THEN actionmodul ELSE @actionmodul END
        AND actiondatetime BETWEEN @begindate AND @enddate
RETURN @count


GO
