USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[GetSMSSendReport]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2008-09-11>
-- Description:	<Description,,短信发送表>
-- =============================================
create PROCEDURE [dbo].[GetSMSSendReport] 
	@sd nvarchar(30),
	@end nvarchar(30),
	@Cid int,
	@Kid int
AS
BEGIN
	SET NOCOUNT ON;
if (@Cid = 0)
begin
	select t2.name as classname,t3.name as sendername, t1.recmobile,t1.content,
	t4.name as recusername,t1.sendtime,t1.status From t_smsmessage_xw t1 
	left join t_class t2 on t1.cid=t2.id
	left join t_staffer t3 on t3.userid=t1.sender
	left join t_child t4 on t1.recuserid=t4.userid
	where t1.kid=@Kid and t1.sendtime between @sd and @end order by t1.sendtime desc
end
else
begin
	select t2.name as classname,t3.name as sendername, t1.recmobile,t1.content,
	t4.name as recusername,t1.sendtime,t1.status From t_smsmessage_xw t1 
	left join t_class t2 on t1.cid=t2.id
	left join t_staffer t3 on t3.userid=t1.sender
	left join t_child t4 on t1.recuserid=t4.userid
	where t1.kid=@Kid and t1.cid=@Cid and t1.sendtime between @sd and @end order by t1.sendtime desc


end
end




--exec GetWebSiteEdit '2007-07-01', '2008-02-24', '2007-07-01', '2008-02-24'


GO
