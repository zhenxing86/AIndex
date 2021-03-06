USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetGDKinAccessWeekTotal]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,幼儿园周访问报表前10名>
-- =============================================
create PROCEDURE [dbo].[GetGDKinAccessWeekTotal] 
AS
BEGIN
	SET NOCOUNT ON;
select top 20 t2.url, t2.name as name,t2.ptshotname,
(select count(*)+1000 from siteaccessdetail where kid = t2.id and DateDiff(d,createtime,getdate())<=30) as accesscount
from t_kindergarten t2  where t2.status = 1 and t2.privince=245
 order by accesscount desc
END
GO
