USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[user_right_UpdateRight]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      xie  
-- Create date: 2014-04-02    
-- Description: 根据userid批量修改用户权限   
-- Memo:      
exec user_right_UpdateRight 295768,1,61,134  
  
user_right_UpdateRight  
@userid =null  
,@readRight=1     
,@lqRight=2  
,@douserid =134    
,@kid =12511  
,@flag  =1  
  
select readright,lqright,* from basicdata..[user] where kid =12511 and usertype>0 and deletetag=1  
*/    
     
CREATE PROCEDURE [dbo].[user_right_UpdateRight]    
@userid int =null  
,@readRight int     
,@lqRight int  
,@douserid int    
,@kid int =null  
,@flag int =0   --0:更新个人，1：更新全园老师（非离园）  
 AS     
begin    
 set nocount on  
 declare @TmpTable table(userid int, readoldvalue int,readnewvalue int, lqoldvalue int,lqnewvalue int)   
 declare @oldvalue int,@newvalue int  
 declare @DoProc nvarchar(50)= 'user_right_UpdateRight'  
 EXEC commonfun.dbo.SetDoInfo @DoUserID = @douserid, @DoProc = @DoProc --设置上下文标志      
   
 IF (@flag=0)  
 BEGIN  
  update basicdata..[user]   
   set readRight=@readRight,lqRight=@lqRight  
    output Inserted.userid,deleted.ReadRight,inserted.ReadRight,deleted.lqRight,inserted.lqRight into @TmpTable  
   where userid=@userid   
 END  
 ELSE IF (@flag=1) --全园老师开通  
 BEGIN  
 update basicdata..[user]   
   set readRight=@readRight,lqRight=@lqRight  
    output Inserted.userid,deleted.ReadRight,inserted.ReadRight,deleted.lqRight,inserted.lqRight into @TmpTable  
   where kid=@kid and usertype>0 and deletetag=1   
 END  
   
  if exists (select 1 from @TmpTable where isnull(readoldvalue,0) <> readnewvalue and userid= @userid)  
  begin  
  INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)  
   SELECT 'BasicData', 'user', @userid, 1, 'readRight', readoldvalue, readnewvalue, @DoProc, @douserid  
    from @TmpTable  
  end  
  
  if exists (select 1 from @TmpTable where isnull(lqoldvalue,0) <> lqnewvalue and userid= @userid)  
  begin      
 INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)  
   SELECT 'BasicData', 'user', @userid, 1, 'lqRight', lqoldvalue, lqnewvalue, @DoProc, @douserid  
    from @TmpTable  
  end  
  
 --  declare @str nvarchar(100)  
 --select @str = 'userid:' + cast(userid as varchar)   
 --    + ',readRight oldvalue:' +cast(isnull(readoldvalue,0) as varchar) +', newvalue:'+ cast(isnull(readnewvalue,0) as varchar)  
 -- + ',lqRight oldvalue:' +cast(isnull(lqoldvalue,0) as varchar) +', newvalue:'+ cast(isnull(lqnewvalue,0) as varchar)  
 --from @TmpTable  
   
 --print @str  
   
 EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志    
 if @@ERROR<>0  
  return -1  
 else return 1  
end 
GO
