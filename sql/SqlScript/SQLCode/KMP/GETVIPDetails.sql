USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GETVIPDetails]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











-- =============================================
--exec getvipdetails 2625
-- =============================================
CREATE PROCEDURE [dbo].[GETVIPDetails] 
@kid int
AS
BEGIN
	select t1.name as classname, t2.name as name,t2.vipstatus,t3.startdate,t3.enddate
 from t_child t2 left join t_class t1
on t1.id=t2.classid left join vipdetails t3 on t3.userid=t2.userid  where t2.vipstatus=1
and t1.kindergartenid=@kid and t3.iscurrent=1 and t2.status=1
order by t1.id
END



GO
