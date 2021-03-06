use NGBApp
go
/*  
-- Author:      Master谭  
-- Create date: 2013-08-17  
-- Description: 编辑组件值，page_public表  
-- Memo:   
DECLARE @I INT  
exec @I = page_public_Edit 1,'Txt1', '文字编辑测试'  
SELECT @I  
SELECT * FROM page_public  
*/  
alter PROC page_public_Edit  
 @diaryid bigint,  
 @ckey varchar(20),  
 @cvalue varchar(1000),  
 @CrtDate datetime = null  
AS  
BEGIN  
 SET NOCOUNT ON  
 Begin tran     
 BEGIN TRY  
 
   if @CrtDate is not null and right(Convert(varchar(19),@CrtDate,120),8)='00:00:00'
   set @CrtDate =cast( Convert(varchar(11),@CrtDate,120) + right(Convert(varchar(19),GETDATE(),120),8) as datetime)
   
   UPDATE page_public   
    set cvalue = @cvalue  
    WHERE diaryid = @diaryid   
     AND ckey = @ckey   
   UPDATE diary   
    set CrtDate = ISNULL(@CrtDate,CrtDate)  
    WHERE diaryid = @diaryid   
  Commit tran                                
 End Try        
 Begin Catch        
  Rollback tran     
  Return -1          
 end Catch       
  RETURN 1  
END  
  