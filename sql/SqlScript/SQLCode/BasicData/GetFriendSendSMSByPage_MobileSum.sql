

alter PROC [dbo].[GetFriendSendSMSByPage_MobileSum]
 @Userid int, 
 @page int,  
 @size int  
AS  
BEGIN  
 SET NOCOUNT ON  

 select u.userid,u.name,COUNT(1) msgcount,lastmsg.msgcon,lastmsg.msgtype,lastmsg.CrtDate 
	into #temp
	from FriendSMS f 
	outer apply
	(
		select top 1 msgcon,msgtype,CrtDate from FriendSMS 
			where Userid=@Userid or Touserid=@Userid 
				order by CrtDate desc
	) as lastmsg
	inner join BasicData..[user] u
		on f.Userid=u.userid and u.deletetag=1
	where Touserid=@Userid and IsRead=0
	group by u.userid,u.name,lastmsg.msgcon,lastmsg.CrtDate,lastmsg.msgtype
		order by lastmsg.CrtDate desc
 
 exec	sp_MutiGridViewByPager
		@fromstring = '#temp ',      --数据集
		@selectstring = 
		'userid,name,msgcount,msgcon,msgtype,CrtDate',      --查询字段
		@returnstring = 
		'userid,name,msgcount,msgcon,msgtype,CrtDate',      --返回字段
		@pageSize = @Size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' CrtDate desc',          --排序条件
		@IsRecordTotal = 1,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号
		@D1 = @Userid
		
 drop table #temp
 
 end
 GO
 [GetFriendSendSMSByPage_MobileSum] 653612,1,2