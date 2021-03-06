USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[geterrormobile]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,新闻显示在门户>
-- =============================================
CREATE PROCEDURE [dbo].[geterrormobile] 
@st datetime,
@ed datetime
AS
BEGIN
select t1.classid,t1.kindergartenid,t1.name,t2.mobile,t3.name as classname,t4.name as kname
 From t_child t1 left join sms_usermobile t2 on t1.userid=t2.userid right join t_class t3 on t3.id=t1.classid
right join t_kindergarten t4 on t4.id=t1.kindergartenid
where t1.userid in 
(select userid from sms_usermobile where mobile in 
(select distinct recmobile From t_smsmessage_xw where status=2 and sendtime between @st and @ed ))
and len(t2.mobile)>0 and t2.mobile<>'02085803634' and len(t2.mobile)<>11 order by t1.kindergartenid,t1.classid
end

--select top 2 * From t_smsmessage_xw

--exec geterrormobile '2009-03-01','2009-03-31'





GO
