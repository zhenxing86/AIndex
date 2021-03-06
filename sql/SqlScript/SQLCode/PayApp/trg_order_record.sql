use payapp
go
/*    
-- Author:      Master谭    
-- Create date:     
-- Description:     
-- Memo:      
*/    
alter TRIGGER [dbo].[trg_order_record] ON [dbo].[order_record]                                
  for INSERT, UPDATE, DELETE                           
AS    
BEGIN               
 if @@RowCount <= 0 Return                    
 set nocount on    
 declare @userid nvarchar(50),@kid int,@feeid int,@paytime datetime,@termtype int ,    
 @ftime datetime,@ltime datetime,@termstr varchar(20)    
    
 declare @DelCnt int, @InsCnt int    
 DECLARE @DoUserID int, @DoProc varchar(50)  --读取上下文信息    
 EXEC commonfun.dbo.GetDoInfo @DoUserID OUTPUT, @DoProc OUTPUT    
     
 SELECT @DelCnt = COUNT(1) FROM deleted    
 SELECT @InsCnt = COUNT(1) FROM inserted    
 IF @DelCnt > 0 and @InsCnt > 0    
 BEGIN     
 --插入修改日志      
    
  if UPDATE([plus_amount])    
  BEGIN    
   INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)    
   SELECT Db_Name(), 'order_record', i.[orderid], 1, 'plus_amount', d.[plus_amount], i.[plus_amount], @DoProc, @DoUserID    
    from inserted i     
     inner join deleted d     
      on  i.[orderid] = d.[orderid]    
      and  ISNULL(i.[plus_amount],0) <> ISNULL(d.[plus_amount],0)    
  END    
    
  if UPDATE([status])    
  BEGIN    
   INSERT INTO AppLogs.dbo.EditLog(DbName,TbName, [keycol], DoType, ColName, OldValue, NewValue, DoWhere, DoUserID)    
   SELECT Db_Name(), 'order_record', i.[orderid], 1, 'status', d.[status], i.[status], @DoProc, @DoUserID    
    from inserted i     
     inner join deleted d     
      on  i.[orderid] = d.[orderid]    
      and  ISNULL(i.[status],0) <> ISNULL(d.[status],0)    
   IF exists(select * from inserted where status = 1 and [from] = '809')    
   BEGIN       
    UPDATE u     
     SET u.ReadRight = Commonfun.dbo.fn_RoleAdd(u.ReadRight,     
       CASE WHEN g.gtype in(1,2,3,4) THEN 2 * g.gtype ELSE 2 END - Commonfun.dbo.fn_GetTermSemester(u.kid, i.actiondatetime))     
     from BasicData..[User] u     
      INNER JOIN inserted i on u.userid = i.userid    
      INNER JOIN BasicData..user_class uc on u.userid = uc.userid and u.usertype = 0    
      INNER JOIN BasicData..class c on uc.cid = c.cid    
      INNER JOIN BasicData..grade g ON c.grade = g.gid    
     WHERE i.status = 1     
      and i.[from] = '809'    
         
    INSERT INTO sbapp..EnterRead(UserID, Kid, Name)    
     select u.UserID, u.Kid, u.Name     
      FROM BasicData..[User] u     
      INNER JOIN inserted i on u.userid = i.userid    
       WHERE i.status = 1     
        and i.[from] = '809'    
        and i.PayType = 0    
        
     --将更新等于1的自动插入到结算表，这里只针对线上过来的。    
     declare @M_ID bigint=0,@orderid int =0,@Amount int =0    
     select @M_ID=m.StatementID,@orderid=i.orderid,@Amount=i.plus_amount from dbo.Statement_M m      
        INNER JOIN BasicData..[User] u on u.kid=m.Kid    
        INNER JOIN inserted i on u.userid = i.userid     
        WHERE i.[status] = 1     
        and i.[from] = '809'    
        and m.[status]=0    
        and i.PayType = 0    
            
     IF @M_ID>0    
     BEGIN     
      insert into dbo.Statement_D(StatementID,OrderID,Amount)    
      values(@M_ID,@OrderID,@Amount)    
     end    
     else     
     begin    
         
      insert into Statement_M (Kid,CrtDate,OperName,Receiver,ReceiverMobile,FinalAmount,[Status],FromCode)    
      select u.kid,GETDATE(),u.name,'','',0,0,'线上' from inserted i    
       INNER JOIN BasicData..[User] u on u.userid = i.userid     
      SET @M_ID = ident_current('Statement_M')     
          
      insert into dbo.Statement_D(StatementID,OrderID,Amount)    
      select m.StatementID,i.orderid,i.plus_amount from dbo.Statement_M m      
        INNER JOIN BasicData..[User] u on u.kid=m.Kid    
        INNER JOIN inserted i on u.userid = i.userid     
      where m.StatementID=@M_ID     
          
     end    
        
        
   END    
   ELSE IF exists(select * from inserted where status = 1 and [from] = '10000')    
   BEGIN     
    --开通对应业务        
    select @kid = u.kid,@userid=cast(i.userid as nvarchar(50)),@feeid=i.PayType    
    from inserted i    
       INNER JOIN BasicData..[User] u on u.userid = i.userid     
        
    set @termstr=healthapp.dbo.getTerm_New(@kid,getdate())     
    set @termstr=right(@termstr,1)    
    if(@termstr='1')    
     set @ltime=cast(CONVERT(varchar(4),getdate(),120)+'-03-01' as datetime)    
    else    
     set @ltime=cast(CONVERT(varchar(4),getdate(),120)+'-09-01' as datetime)    
    set @ftime = GETDATE()    
      
    exec ossapp..[addservice_vip_Add_child]       
    @typename='child'    
    ,@kid =@kid --幼儿园ID，必须有      
    ,@cid=-1 --班级ID（可有可无）      
    ,@cuid=@userid --开通的userid(例如：295765,295766)      
    ,@p1=@feeid --套餐ID（feeid）      
    ,@ftime=@ftime --开始时间      
    ,@ltime=@ltime --结束时间      
    ,@ispay=1 --是否已付款（1：已付款)      
    ,@isopen=1 --是否开通（1：开通）      
    ,@paytime=@paytime --付款时间      
    ,@isproxy =0 --是否代理=0      
    ,@uid = 152 --操作人 默认wlzf     
    ,@Statement =0 --是否结算，默认已结算1      
      
    if ( ossapp.dbo.addservice_vip_GetRule(@userid,804)=1 )--乐奇 VIP套餐（家长学校） 只开通当前学期  
    begin  
  UPDATE u     
   SET u.LqRight = Commonfun.dbo.fn_RoleAdd(u.LqRight,i.termtype)     
   from BasicData..[User] u     
    INNER JOIN inserted i on u.userid = i.userid    
    INNER JOIN BasicData..user_class uc on u.userid = uc.userid and u.usertype = 0    
    INNER JOIN BasicData..class c on uc.cid = c.cid    
    INNER JOIN BasicData..grade g ON c.grade = g.gid    
   WHERE i.status = 1     
    and i.[from] = '10000'    
    end     
   END    
   ELSE IF exists(select * from inserted where status = 1 and [from] = '10001')    
   BEGIN  
 --开通对应业务    
    select @kid = u.kid,@userid=i.userid,@feeid=i.PayType,@termtype=i.termtype   
    from inserted i    
       INNER JOIN BasicData..[User] u on u.userid = i.userid     
       
 ----------------------------------------------------------------------------------------------------------------------------------------------------  
  
     declare @now datetime,@term VARCHAR(100)  
  set @now=getdate()  
    
  if(@kid=24170 and @now<'2015-5-1')  
  begin  
    exec ossapp..[addservice_vip_Add_child]       
   @typename='child'    
   ,@kid =@kid --幼儿园ID，必须有      
   ,@cid=-1 --班级ID（可有可无）      
   ,@cuid=@userid --开通的userid(例如：295765,295766)      
   ,@p1=@feeid --套餐ID（feeid）      
   ,@ftime='2014-9-1' --开始时间      
   ,@ltime='2015-9-1' --结束时间      
   ,@ispay=1 --是否已付款（1：已付款)      
   ,@isopen=1 --是否开通（1：开通）      
   ,@paytime=@now --付款时间      
   ,@isproxy =0 --是否代理=0      
   ,@uid = 152 --操作人 默认wlzf     
   ,@Statement =0 --是否结算，默认已结算1    
  end  
  else  
  begin  
  
  select @term = CommonFun.dbo.fn_getCurrentTerm(@kid,@now,0)    
  exec CommonFun.dbo.Calkidterm @kid, @term, @ftime output,@ltime output    
  
    exec ossapp..[addservice_vip_Add_child]       
   @typename='child'    
   ,@kid =@kid --幼儿园ID，必须有      
   ,@cid=-1 --班级ID（可有可无）      
   ,@cuid=@userid --开通的userid(例如：295765,295766)      
   ,@p1=@feeid --套餐ID（feeid）      
   ,@ftime=@ftime --开始时间      
   ,@ltime=@ltime --结束时间      
   ,@ispay=1 --是否已付款（1：已付款)      
   ,@isopen=1 --是否开通（1：开通）      
   ,@paytime=@now --付款时间      
   ,@isproxy =0 --是否代理=0      
   ,@uid = 152 --操作人 默认wlzf     
   ,@Statement =0 --是否结算，默认已结算1    
  end  
    
      ;With Data as (    
    select @userid userid,@feeid feeid,@termtype termtype,'家长在线缴费' infofrom,@ftime ftime,@ltime ltime  
   )   
   Merge ossapp..payapp_userstate p   
  Using Data b On p.userid = b.userid and p.termtype = b.termtype and p.feeid=b.feeid  
  When Matched Then    
   Update Set userid = b.userid, termtype = b.termtype, feeid = b.feeid, infofrom = b.infofrom,state=1,p.ftime= b.ftime,p.ltime= b.ltime  
  When not Matched Then    
   Insert (userid, termtype, feeid, infofrom, state,ftime,ltime) Values(b.userid, b.termtype, b.feeid, b.infofrom, 1,b.ftime,b.ltime);    
    
    
  ---------------------------------------------------------------------------------------------------------------------------------------------  
 END 
     
  END    
 END     
 ELSE IF @DelCnt = 0 and @InsCnt > 0     
 --插入新增日志       
 BEGIN    
  INSERT INTO AppLogs.dbo.EditLog(DbName, TbName, [keycol], DoType, DoWhere, DoUserID)    
  SELECT Db_Name(),'order_record', [orderid], 0, @DoProc, @DoUserID    
   from inserted     
 END    
 ELSE IF @DelCnt > 0 and @InsCnt = 0     
 --插入删除日志       
 BEGIN    
  INSERT INTO AppLogs.dbo.EditLog(DbName, TbName, [keycol], DoType, DoWhere, DoUserID)    
  SELECT Db_Name(), 'order_record', [orderid], 2, @DoProc, @DoUserID    
   from deleted     
  INSERT INTO AppLogs.dbo.DelLog(DbName, TbName, DoWhere, DoUserID, Col1, Col2, Col3, Col4, Col5, Col6, Col7, Col8, Col9)    
  SELECT Db_Name(), 'order_record', @DoProc, @DoUserID, [orderid], [userid], [plus_amount], [plus_bean], [actiondatetime], [orderno], [status], [from], [PayType]    
   from deleted     
 END    
END 