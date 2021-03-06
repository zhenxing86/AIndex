USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[addservice_vip_Add_Excel]    Script Date: 02/12/2014 17:26:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[addservice_vip_Add_Excel]
@kid int
,@cname varchar(200)
,@cuname varchar(300)
,@p1name varchar(200)
,@ftime datetime
,@ltime datetime
,@ispay int
,@isopen int
,@paytime datetime
,@isproxy int
,@uid int
as


INSERT INTO [dbo].[addservice_vip_Excel]
           ([kid]
           ,[cname]
           ,[cuname]
           ,[p1name]
           ,[ftime]
           ,[ltime]
           ,[ispay]
           ,[isopen]
           ,[paytime]
           ,[isproxy]
           ,[uid]
           ,[intime])
     VALUES
(
@kid
,@cname
,@cuname
,@p1name
,@ftime
,@ltime
,@ispay
,@isopen
,@paytime
,@isproxy
,@uid
,getdate()
)


begin tran 


declare @typename varchar(100),@cid int,@p1 int
set @typename='child'
--获取班级ID
select @cid=cid from BasicData..class where kid=@kid and replace(cname,' ','')=@cname and deletetag=1
--获取套餐ID 
select @p1=f.ID from feestandard  f
inner join dbo.dict d on d.ID=f.a1
where kid=@kid and f.deletetag=1 and info = @p1name
--

declare @temp table 
(
tuid int
)

if(@typename= 'child')
begin

insert into @temp(tuid) 
select top 1 u.userid from BasicData..[user] u
inner join BasicData..user_class uc on  uc.userid=u.userid
inner join BasicData..class c on c.cid=uc.cid
where replace(u.[name],' ','') =@cuname and c.kid=@kid and c.cname=@cname

end
else if(@typename= 'class')
begin

insert into @temp(tuid) 
select u.userid from BasicData..[user] u
inner join BasicData..user_class c on u.userid=c.userid 
where u.usertype=0 and u.deletetag=1 and c.cid=@cid 

end
else if(@typename= 'kin')
begin

insert into @temp(tuid) 
select u.userid from BasicData..[user] u
inner join BasicData..user_class uc on u.userid=uc.userid 
inner join BasicData..class c on c.cid=uc.cid
where usertype=0 and u.deletetag=1 and c.deletetag=1 and u.kid=@kid

end

update zgyey_om..vipdetails set IsCurrent=0 
FROM zgyey_om..vipdetails
INNER JOIN @temp ON UserID =tuid
where IsCurrent=1

if(@isopen=1)
begin
insert into zgyey_om..vipdetails(UserID,IsCurrent,StartDate,EndDate,FeeAmount) 
select tuid,1,@ftime,@ltime,'0.00' from @temp
end

update  basicdata..child  set vipstatus=@isopen 
FROM basicdata..child
INNER JOIN @temp ON UserID =tuid

update [addservice] set [deletetag]=0 
FROM [addservice]
INNER JOIN @temp ON uid =tuid
where [deletetag]=1

INSERT INTO [addservice](
  [kid],[cid],[uid],[pname],[describe],[isfree],[normalprice],[discountprice],[paytime],[ftime],
 [ltime],vippaystate,[isproxy],[proxymoney],[proxystate],[proxytime],[proxycid],[a1],[a2],[a3],[a4],
 [a5],[a6],[a7],[a8],[deletetag],userid,dotime,a9,[a10],[a11],[a12],[a13])
 select f.kid,uc.cid,u.userid
,(select top 1 info from dbo.dict where ID=a1)
,(case when @isopen=1 then '开通' else '关闭' end),0,f.price,0,@paytime,@ftime,@ltime,@ispay,@isproxy,f.proxyprice,0,@paytime,0
,f.a1,f.a2,f.a3,f.a4,f.a5,f.a6,f.a7,f.a8,1,@uid,getdate(),f.a9,f.[a10],f.[a11],f.[a12],f.[a13]
 from dbo.feestandard f
 inner join BasicData..[user] u on u.userid in (select tuid from @temp)
 inner join BasicData..user_class uc on uc.userid=u.userid 
 where f.ID=@p1 


if @@error<>0 --判断如果有任何一条出现错误
begin rollback tran 
end
else  
begin commit tran 
end

