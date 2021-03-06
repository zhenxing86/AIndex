USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetXTAccessReport]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2008-04-13>
-- Description:	<Description,,学堂访问>
-- =============================================
CREATE PROCEDURE [dbo].[GetXTAccessReport] 
	@sd nvarchar(30),
	@ed nvarchar(30)
AS
BEGIN
	SET NOCOUNT ON;
select '总数' as 幼儿园,'' as 网址, (select count(stat.id) from statdb..accesssource stat left join t_kindergarten k on
stat.accessurl =k.url+'/xt.aspx' 
  where substring(stat.accessurl,len(stat.accessurl)-6,7)='xt.aspx' and stat.accessdatetime between @sd and @ed
and k.status=1) as 访问次数
union
select k.name as 幼儿园,stat.accessurl as 网址 ,count(stat.id) as 访问次数 from statdb..accesssource stat left join t_kindergarten k on
stat.accessurl=k.url+'/xt.aspx'
  where substring(stat.accessurl,len(stat.accessurl)-6,7)='xt.aspx' and stat.accessdatetime between @sd and @ed
and k.status=1
group by k.name,stat.accessurl
order by 访问次数 desc

END


GO
