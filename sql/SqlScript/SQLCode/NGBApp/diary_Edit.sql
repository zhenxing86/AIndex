use NGBApp
go
/*  
-- Author:      Master谭  
-- Create date: 2013-08-16  
-- Description: 编辑日记，diary表  --1新增日记，2删除日记，3更改模版， 4切换公开标志  
-- Memo:   
DECLARE @I INT  
exec @I = diary_Edit 1,11,null, 1,295765  
SELECT @I  
SELECT * FROM diary  
SELECT * FROM page_public  
*/  
alter PROC [dbo].[diary_Edit]  
 @gbid int,  
 @pagetplid int,  
 @diaryid bigint = -1,  
 @EditType int, --1新增日记，2删除日记，3更改模版， 4切换公开标志  
 @userid int,  
 @CrtDate datetime = null,  
 @Share int = 0,  
 @Src int = 0  
AS  
BEGIN  
 SET NOCOUNT ON   
 if(@gbid=0)  
 begin  
  select top 1 @gbid=gbid from growthbook where userid=@userid order by gbid desc  
 end  
   
 if @CrtDate is null or @CrtDate = '1900-01-01'  
   set @CrtDate = GETDATE() 
 
 if right(Convert(varchar(19),@CrtDate,120),8)='00:00:00'
   set @CrtDate =cast( Convert(varchar(11),@CrtDate,120) + right(Convert(varchar(19),GETDATE(),120),8) as datetime)
 
 Begin tran     
 BEGIN TRY  
  IF @EditType = 1  
  BEGIN  
   INSERT INTO diary(gbid,pagetplid, Author,CrtDate, Share, Src)  
    VALUES(@gbid,@pagetplid,@userid,@CrtDate,@Share,@Src)     
   SET @diaryid = ident_current('diary')   
     
   INSERT INTO page_public(diaryid,ckey,cvalue,ctype)  
    SELECT @diaryid, ckey, cvalue, ctype   
     FROM page_public_tpl   
     WHERE pagetplid = @pagetplid  
   IF @@ROWCOUNT = 0   
   SET @diaryid = -2  
  END  
  ELSE IF @EditType = 2  
  BEGIN  
   UPDATE diary SET deletetag = 0   
    WHERE diaryid = @diaryid  
  END  
  ELSE IF @EditType = 3  
  BEGIN  
  
   DELETE  page_public WHERE diaryid = @diaryid  
     
   UPDATE diary SET pagetplid = @pagetplid ,share=@share    
   WHERE diaryid = @diaryid      
         
   INSERT INTO page_public(diaryid,ckey,cvalue,ctype)    
   SELECT @diaryid, ckey, cvalue, ctype     
    FROM page_public_tpl     
    WHERE pagetplid = @pagetplid    
       
  END  
  ELSE IF @EditType = 4  
  BEGIN  
   UPDATE diary SET Share = Case ISNULL(Share,1) when 0 THEN 1 else 0 END   
    WHERE diaryid = @diaryid  
  END  
  Commit tran                                
 End Try        
 Begin Catch        
  Rollback tran     
  Return -1          
 end Catch       
  RETURN @diaryid -- -1失败， -2 未插入组件， >0 成功  
END  
  