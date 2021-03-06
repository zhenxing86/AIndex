USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_kmp_MoreNewKindergartenListSearch]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-02
-- Description:	搜索幼儿园
-- =============================================
CREATE PROCEDURE [dbo].[MH_kmp_MoreNewKindergartenListSearch]
@privince int,
@city int,
@name nvarchar(100),
@page int,
@size int
AS
BEGIN
	IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int
		
		SET @prep = @size * @page
		SET @ignore=@prep - @size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY (1, 1),
			tmptableid bigint
		)
		
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) 
		select t2.id 
		from kmp..t_kindergarten t2  where t2.status = 1 and t2.ispublish = 1 and privince=@privince and city=@city and name like '%'+@name+'%'

		SET ROWCOUNT @size
		select t2.id, t2.url,t2.privince, t2.name, t2.kindesc, t2.theme, t2.ispublish,
		(select accesscount from site where siteid = t2.id) as accesscount 
		from kmp..t_kindergarten t2,@tmptable where t2.id=tmptableid and row > @ignore and t2.status = 1 and t2.ispublish = 1 and privince=@privince and city=@city and name like '%'+@name+'%'
		order by accesscount desc
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		select t2.id, t2.url,t2.privince, t2.name, t2.kindesc, t2.theme, t2.ispublish,
		(select accesscount from site where siteid = t2.id) as accesscount 
		from kmp..t_kindergarten t2 where t2.status = 1 and t2.ispublish = 1 and privince=@privince and city=@city and name like '%'+@name+'%'
		order by accesscount desc
	END
	ELSE IF(@page=0)
	BEGIN
		select t2.id, t2.url,t2.privince, t2.name, t2.kindesc, t2.theme, t2.ispublish,
		(select accesscount from site where siteid = t2.id) as accesscount 
		from kmp..t_kindergarten t2 where t2.status = 1 and t2.ispublish = 1 and privince=@privince and city=@city and name like '%'+@name+'%'
		order by accesscount desc
	END	
END





GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_kmp_MoreNewKindergartenListSearch', @level2type=N'PARAMETER',@level2name=N'@page'
GO
