

alter PROC [dbo].[GetFriendSendSMSByPage_MobileDetail]
 @Userid int,
 @frienduid int, 
 @page int,  
 @size int  
AS  
BEGIN  
 SET NOCOUNT ON  

--我发给对方
 select u.userid,u.name,msgcon,msgtype,CrtDate,0 msgfrom 
	into #temp
	from FriendSMS f 
	inner join BasicData..[user] u
		on f.Userid=u.userid and u.deletetag=1
	where (f.Touserid=@frienduid and f.Userid=@Userid)
		
--对方发给我
insert into #temp
 select u.userid,u.name,msgcon,msgtype,CrtDate,1 msgfrom
	from FriendSMS f 
	inner join BasicData..[user] u
		on f.Userid=u.userid and u.deletetag=1
	where (f.Touserid=@Userid and f.Userid=@frienduid)


 exec	sp_MutiGridViewByPager
		@fromstring = '#temp ',      --数据集
		@selectstring = 
		'userid,name,msgcon,msgtype,CrtDate,msgfrom',      --查询字段
		@returnstring = 
		'userid,name,msgcon,msgtype,CrtDate,msgfrom',      --返回字段
		@pageSize = @Size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' CrtDate desc',          --排序条件
		@IsRecordTotal = 1,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号
		@D1 = @Userid
		
 drop table #temp
 end
 GO
 [GetFriendSendSMSByPage_MobileDetail] 653612,567195,1,20