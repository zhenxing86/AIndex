USE [BasicData]
GO
/****** Object:  Trigger [dbo].[trg_class]    Script Date: 12/26/2014 10:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      Master谭    
-- Create date:     
-- Description:     
-- Memo:      
*/    
ALTER TRIGGER [dbo].[trg_class] ON [dbo].[class]                                
  for INSERT, UPDATE, DELETE                           
AS    
BEGIN               
 if @@RowCount <= 0 Return                    
 set nocount on      
     
 declare @DelCnt int, @InsCnt int    
 DECLARE @DoUserID int, @DoProc varchar(50)  --读取上下文信息    
 EXEC commonfun.dbo.GetDoInfo @DoUserID OUTPUT, @DoProc OUTPUT    
     
 SELECT @DelCnt = COUNT(1) FROM deleted    
 SELECT @InsCnt = COUNT(1) FROM inserted    
 IF @DelCnt > 0 and @InsCnt > 0    
 BEGIN     
     
 if not UPDATE([deletetag])    
 begin    
  --同步修改class_all    
  ;With Data as (      
  select CommonFun.dbo.fn_getCurrentTerm(kid,GETDATE(),1) term,*    
   from inserted     
  )      
  Merge class_all ca     
  Using Data b On ca.cid = b.cid and ca.term=b.term and ca.deletetag=1    
  When Matched Then      
  Update Set cname = b.cname, grade = b.grade, [order] = b.[order]    
  When not Matched Then      
  Insert (cid, kid, cname, grade, [order], [deletetag],sname,actiondate,iscurrent,subno,term,isgraduate)     
   Values(b.cid, b.kid, b.cname, b.grade, b.[order], 1,b.sname,b.actiondate,b.iscurrent,b.subno,b.term,0);     
 end    
 else     
 begin    
      
  --删除    
  ;with cet as    
  ( select kid,CommonFun.dbo.fn_getCurrentTerm(i.kid,GETDATE(),1) term    
     from inserted i where deletetag=0)    
  update ca set deletetag=0     
   from class_all ca     
    inner join inserted i on ca.cid = i.cid     
    inner join cet c on c.kid = ca.kid and c.term=ca.term    
        
  --还原    
  ;With Data as (      
  select CommonFun.dbo.fn_getCurrentTerm(kid,GETDATE(),1) term,*    
   from inserted where deletetag=1    
  )      
  Merge class_all ca     
  Using Data b On ca.cid = b.cid and ca.term=b.term     
  When Matched and ca.deletetag=0 Then      
  Update Set deletetag=1    
  When not Matched Then      
  Insert (cid, kid, cname, grade, [order], [deletetag],sname,actiondate,iscurrent,subno,term,isgraduate)     
   Values(b.cid, b.kid, b.cname, b.grade, b.[order], 1,b.sname,b.actiondate,b.iscurrent,b.subno,b.term,0);     
       
 end    
 
  --升班同步修改user表的updatetime
  if UPDATE([cname]) or UPDATE([grade])  
  BEGIN  
	update u set updatetime=getdate() 
	  from [User] u
	   inner join user_class uc on u.userid=uc.userid
	   inner join deleted d on uc.cid=d.cid
  END
     
 --插入修改日志      
    
  if UPDATE([cname])    
  BEGIN    
   INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)    
   SELECT Db_Name(), 'class', i.[cid], 1, 'cname', d.[cname], i.[cname], @DoProc, @DoUserID    
    from inserted i     
     inner join deleted d     
      on  i.[cid] = d.[cid]    
      and  ISNULL(i.[cname],0) <> ISNULL(d.[cname],0)    
  END    
    
  if UPDATE([grade])    
  BEGIN    
   INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)    
   SELECT Db_Name(), 'class', i.[cid], 1, 'grade', d.[grade], i.[grade], @DoProc, @DoUserID    
    from inserted i     
     inner join deleted d     
      on  i.[cid] = d.[cid]    
      and  ISNULL(i.[grade],0) <> ISNULL(d.[grade],0)    
  END    
    
  if UPDATE([order])    
  BEGIN    
   INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)    
   SELECT Db_Name(), 'class', i.[cid], 1, 'order', d.[order], i.[order], @DoProc, @DoUserID    
    from inserted i     
     inner join deleted d     
      on  i.[cid] = d.[cid]    
      and  ISNULL(i.[order],0) <> ISNULL(d.[order],0)    
  END    
    
  if UPDATE([deletetag])    
  BEGIN    
   INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)    
   SELECT Db_Name(), 'class', i.[cid], 1, 'deletetag', d.[deletetag], i.[deletetag], @DoProc, @DoUserID    
    from inserted i     
     inner join deleted d     
      on  i.[cid] = d.[cid]    
      and  ISNULL(i.[deletetag],0) <> ISNULL(d.[deletetag],0)    
  END    
 END     
 ELSE IF @DelCnt = 0 and @InsCnt > 0     
 --插入新增日志       
 BEGIN    
  ----如果是7-9月或者12-2月做的新增班级。那么需要自动将学期切换到下一学期。 (统一在切换学期或者升班时再处理)    
  -- declare @term nvarchar(6),@next_term nvarchar(6)    
  -- select @next_term = CommonFun.dbo.fn_getCurrentTerm(0,DATEADD(mm,2,getdate()),0)      
       
  -- --确保BasicData.dbo.kid_term当前学期有一条记录            
  -- declare  @bgndate datetime ,@enddate datetime            
  -- exec commonfun.dbo.Calkidterm 0, @next_term, @bgndate output, @enddate output          
       
  -- update kt set iscurrent=0     
  --  from BasicData.dbo.kid_term kt    
  --   inner join inserted b on kt.kid = b.kid     
  --   where kt.iscurrent =1 and kt.term<>@next_term    
       
  -- ;With Data as (      
  --  select distinct b.kid kid,@next_term term    
  --   from inserted b     
  -- )      
  -- Merge BasicData.dbo.kid_term kt     
  -- Using Data b On kt.kid = b.kid and kt.term=b.term    
  -- When Matched Then      
  --  Update Set iscurrent=1,douserid=@douserid,dotime=getdate()    
  -- When not Matched Then      
  --  Insert (kid,term,bgndate,enddate,iscurrent,douserid,dotime,hasriseterm)         
  --   Values (b.kid,b.term,@bgndate,@enddate,1,@douserid,GETDATE(),1);    
                
  --新增到class_all    
  insert into class_all(cid, kid, cname, grade, [order], [deletetag],sname,actiondate,iscurrent,subno,term,isgraduate)     
  select b.cid, b.kid, b.cname, b.grade, b.[order], 1,b.sname,b.actiondate,b.iscurrent,b.subno,CommonFun.dbo.fn_getCurrentTerm(b.kid,GETDATE(),1),0    
  from inserted b    
      
  INSERT INTO AppLogs.dbo.EditLog(DbName, TbName, [keycol], DoType, DoWhere, DoUserID)    
  SELECT Db_Name(),'class', [cid], 0, @DoProc, @DoUserID    
   from inserted     
 END    
 ELSE IF @DelCnt > 0 and @InsCnt = 0     
 --插入删除日志       
 BEGIN    
  --删除class_all    
  ;with cet as    
  ( select kid,CommonFun.dbo.fn_getCurrentTerm(d.kid,GETDATE(),1) term    
     from deleted d)    
  update ca set deletetag=0     
   from class_all ca     
    inner join deleted d on ca.cid = d.cid     
    inner join cet c on c.kid = ca.kid and c.term=ca.term    
        
  INSERT INTO AppLogs.dbo.EditLog(DbName, TbName, [keycol], DoType, DoWhere, DoUserID)    
  SELECT Db_Name(), 'class', [cid], 2, @DoProc, @DoUserID    
   from deleted     
  INSERT INTO AppLogs.dbo.DelLog(DbName, TbName, DoWhere, DoUserID, Col1, Col2, Col3, Col4, Col5, Col6, Col7, Col8, Col9, Col10)    
  SELECT Db_Name(), 'class', @DoProc, @DoUserID, [cid], [kid], [cname], [grade], [order], [deletetag], [sname], [actiondate], [iscurrent], [subno]    
   from deleted     
 END    
END 