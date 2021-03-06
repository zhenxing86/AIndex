USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_Recover]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		gaolao
-- Create date: 2011-4-7
-- Description:	恢复删除站点
-- =============================================
CREATE PROCEDURE [dbo].[site_Recover]
@siteid int
AS
BEGIN
	BEGIN TRANSACTION

	UPDATE site SET status=1 WHERE siteid=@siteid
	update kmp..t_kindergarten set status=1 where id=@siteid
    declare  @sys  int
    select   @sys=dbo.IsSyncKindergarten(@siteid );  
    if @sys=1
    begin
       insert into kmp..T_SyncKindergarten(siteid,[action],actiondatetime,issync) values(@siteid,1,getdate(),0)
    end
    
	IF @@Error<>0
	BEGIN
		ROLLBACK TRANSACTION
		RETURN (-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN (1)
	END
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_Recover', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
