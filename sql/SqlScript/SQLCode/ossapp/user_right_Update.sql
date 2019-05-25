use ossapp
go
/*  
-- Author:      xie
-- Create date: 2014-04-02  
-- Description: 根据userid批量修改用户权限 
-- Memo:    
exec user_right_Update 295765,1,1 
*/  
alter PROCEDURE [dbo].[user_right_Update]  
@userid int 
,@readRight int   
,@lqRight int
,@douserid int   
 AS   
begin  
 set nocount on
 declare @TmpTable table(userid int, readoldvalue int,readnewvalue int, lqoldvalue int,lqnewvalue int) 
 declare @DoProc nvarchar(50)= 'user_right_Update'
 EXEC commonfun.dbo.SetDoInfo @DoUserID = @douserid, @DoProc = @DoProc --设置上下文标志    
 
 
 update basicdata..[user] 
  set readRight=@readRight,lqRight=@lqRight
   output Inserted.userid,deleted.ReadRight,inserted.ReadRight,deleted.lqRight,inserted.lqRight into @TmpTable
  where userid=@userid 

 INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT Db_Name(), 'user', @userid, 1, 'readRight', readoldvalue, readnewvalue, @DoProc, @douserid
				from @TmpTable
				
 INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)
			SELECT Db_Name(), 'user', @userid, 1, 'lqRight', lqoldvalue, lqnewvalue, @DoProc, @douserid
				from @TmpTable

 EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志  
 if @@ERROR<>0
  return -1
 else return 1
end  