USE [ResourceApp]
GO
/****** Object:  StoredProcedure [dbo].[GetKinStatus]    Script Date: 2014/11/24 23:26:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
      
------------------------------------      
--用途：      
--项目名称：CLASSHOMEPAGE      
--说明：      
--时间：2009-3-29 22:30:07   
------------------------------------      
CREATE PROCEDURE [dbo].[GetKinStatus]      
@kid int,    
@userid int=0      
AS      
       
declare @status varchar(10),@result int=0,@isvip varchar(20)      
select @status=status from  ossapp..kinbaseinfo k where kid=@kid      
select @isvip=describe from ossapp..addservice where [uid]=@userid and deletetag=1    
    
--select top 1* from BasicData..[user] where usertype>0 and deletetag=1 and userid=@userid   



if(@status='正常缴费')      
begin      
 set @result= 1      
end     
if(@isvip='开通')    
begin      
 set @result= 1      
end      
--针对成都代理商王三东，家长收费情况是标准版的，互动学堂一个都不可以看(与家长是否开通VIP无关)。 2014-7-28    
declare @ccount int
select @ccount=count(1) from ossapp..kinbaseinfo where kid=@kid and deletetag=1 and abid=27 and parentpay= '标准版' and infofrom='代理'
 if @ccount>0   
begin
	set @result=5
end     
return @result    
      
GO
