USE [AndroidApp]
GO
/****** Object:  StoredProcedure [and_msg_GetListSend]    Script Date: 2014/11/24 19:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [and_msg_GetListSend]   
AS  
  
SELECT distinct m.ID,m.msg_code,m.[param],m.title,m.contents  
   ,case when m.msg_type=0 then d.channel_id else u.channel_id end channel_id  
   ,case when m.msg_type=0 then d.device_user_id else u.device_user_id end device_user_id  
   ,m.msg_type,m.push_type,d.tag,u.userid
   ,Case When m.msg_type = 0 Then 0 Else 1 End IOSAnd
,ROW_NUMBER() OVER (PARTITION BY u.userid ORDER BY m.[sent_time] desc) as xid  
into #temp  
  FROM [AndroidApp].[dbo].[and_msg] m  
    inner join [AndroidApp].dbo.and_msg_detail d  
  on d.sms_id=m.ID  
 inner join [AndroidApp].[dbo].and_userinfo u  
  on u.userid=d.userid   
   and m.push_type=1  
 where   
 m.[sent_time]<GETDATE()   
  and m.send_status=0  
  and u.deletetag=1  
  and m.msg_code<>401  
  
--将401的信息插入数据  
/*
insert into #temp(ID,msg_code,[param],title,contents,channel_id,device_user_id,msg_type,push_type,tag,userid,IOSAnd,xid)  
SELECT distinct m.ID,m.msg_code,m.[param],m.title,m.contents  
   ,case when m.msg_type=0 then d.channel_id else u.channel_id end channel_id  
   ,case when m.msg_type=0 then d.device_user_id else u.device_user_id end device_user_id  
   ,m.msg_type,m.push_type,d.tag,u.userid  
   ,Case When m.msg_type = 0 Then 0 Else 1 End IOSAnd
   ,1  
  
  FROM [AndroidApp].[dbo].[and_msg] m  
    inner join [AndroidApp].dbo.and_msg_detail d  
  on d.sms_id=m.ID  
 inner join [AndroidApp].[dbo].and_userinfo u  
  on u.userid=d.userid   
   and m.push_type=1  
 where   
 m.[sent_time]<GETDATE()   
  and m.send_status=0  
  and u.deletetag=2  
  and m.msg_code=401  */
insert into #temp(ID,msg_code,[param],title,contents,channel_id,device_user_id,msg_type,push_type,tag,userid,IOSAnd,xid)  
SELECT distinct m.ID,m.msg_code,m.[param],m.title,m.contents  
   ,d.channel_id
   ,d.device_user_id
   ,m.msg_type,m.push_type,d.tag,d.userid  
   ,Case When m.msg_type = 0 Then 0 Else 1 End IOSAnd
   ,1  
  
  FROM [AndroidApp].[dbo].[and_msg] m  
    inner join [AndroidApp].dbo.and_msg_detail d  
  on d.sms_id=m.ID  
 where   
 m.[sent_time]<GETDATE()   
  and m.send_status=0  
  and m.msg_code=401
  and m.push_type=1  
 
--非401的获取第一条来推送  
select t.ID,t.msg_code,t.[param],t.title,t.contents,t.channel_id,  
    t.device_user_id,t.msg_type,t.push_type,t.tag,t.userid,t.xid  
 from #temp t  
 where t.xid=1 and t.channel_id <> '0'
 Order by t.IOSAnd Desc, Case When t.msg_code = 401 then 0 Else 1 End
 
--将非401的然后不是第一条的通知，自动变成已发送状态  
update m set send_status=1   
 FROM [AndroidApp].[dbo].[and_msg] m  
 inner join #temp t on t.ID=m.ID  
  where xid>1 and m.msg_code<>401  
    
--等于2说明是要踢掉的，所以要修改为0   
--update [AndroidApp].[dbo].and_userinfo   
-- set deletetag=0 where deletetag=2  
  
drop table #temp  

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'<p>
	推送监控使用，同一个人有多条信息需要推送的时候，只推送第1条，自动把其他的条目设置为推送成功。
</p>
<p>
	401标识踢人的消息
</p>' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'and_msg_GetListSend'
GO
