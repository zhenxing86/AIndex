USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[kindergarten_UpdateRight]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*        
-- Author:      xie      
-- Create date: 2014-04-02        
-- Description: 根据kid设置晨检入园、离园、正常短信发送权限       
-- Memo:          
      
exec kindergarten_UpdateRight      
@kid =12512      
,@sendSet=1       
,@douserid =134     
      
select sendSet,CommonFun.dbo.fn_RoleGet(sendSet,3),* from mcapp..kindergarten where kid =12511  
  
*/        
         
CREATE PROCEDURE [dbo].[kindergarten_UpdateRight]        
@kid int =null      
,@sendSet int      
,@douserid int        
 AS         
begin        
 set nocount on      
 declare @TmpTable table(kid int, oldvalue int,newvalue int)       
 declare @oldvalue int,@newvalue int      
 declare @DoProc nvarchar(50)= 'kindergarten_UpdateRight'      
 EXEC commonfun.dbo.SetDoInfo @DoUserID = @douserid, @DoProc = @DoProc --设置上下文标志          
     
  update mcapp..kindergarten     
   set sendSet=@sendSet   
    output Inserted.kid,deleted.sendSet,inserted.sendSet into @TmpTable      
   where kid=@kid        
    
  if @@ROWCOUNT<=0  
  begin  
   insert into mcapp..kindergarten(kid,sendSet)  
    output Inserted.kid,'',inserted.sendSet into @TmpTable     
    select @kid,@sendSet  
  end  
  
  select @oldvalue=oldvalue,@newvalue=newvalue from @TmpTable where kid=@kid 
  if (CommonFun.dbo.fn_RoleGet(@oldvalue,3)=1 or CommonFun.dbo.fn_RoleGet(@newvalue,3)=1 )
  begin
	 exec ossapp..config_manage_Update 10,1
  end
  
  if exists (select 1 from @TmpTable where isnull(oldvalue,0) <> newvalue and kid= @kid)      
  begin      
   INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)      
    SELECT DB_NAME(), 'kindergarten', @kid, 1, 'sendSet', oldvalue, newvalue, @DoProc, @douserid      
  from @TmpTable      
  end      
       
 EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志        
 if @@ERROR<>0      
  return -1      
 else return 1      
end    
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改晨检权限 sendset（1位：入园，2位：离园，3位：正常短信）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kindergarten_UpdateRight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'sendset（1位：入园，2位：离园，3位：正常短信）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kindergarten_UpdateRight', @level2type=N'PARAMETER',@level2name=N'@sendSet'
GO
