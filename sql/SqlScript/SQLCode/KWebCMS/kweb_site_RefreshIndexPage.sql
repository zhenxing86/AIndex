USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_site_RefreshIndexPage]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		along
-- Create date: 2012-04-24
-- Description:	是否是要更新首页
-- =============================================
CREATE PROCEDURE [dbo].[kweb_site_RefreshIndexPage]
@siteid int
AS
BEGIN
	
	IF EXISTS(SELECT indexpage FROM htmlupdate WHERE siteid=@siteid)
	begin
		update htmlupdate set indexpage=1,updatetime=getdate() where siteid=@siteid
	end
	else
	begin
		insert into htmlupdate(siteid,indexpage) values(@siteid,1)
	end

	return 1

END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_site_RefreshIndexPage', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
