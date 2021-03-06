USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[ModuleSet_Edit]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*          
-- Author:      along          
-- Create date: 2013-09-15          
-- Description: 更新moduleset表          
-- Memo:            
exec [ModuleSet_Edit] 12511,'2013-1',          
'GartenInfo,AdvForeword,ClassInfo,Section,AdvCell,LifePhoto,WorkPhoto,KidView,ZLAssess,Summary',          
 '','',2          
 select * from ModuleSet where kid=12511          
 select * from cellset where kid=12511          
 select * from diary where pagetplid=2          
 delete growthbook where gbid=89          
           
*/          
CREATE PROC [dbo].[ModuleSet_Edit]        
 @kid int,          
 @term varchar(6),          
 @hbModList varchar(200),          
 @gbModList varchar(200),          
 @Monadvset varchar(200),          
 @celltype int,        
 @DoUserID INT = 0          
AS          
BEGIN          
        
 SET @term= CommonFun.dbo.fn_getCurrentTerm(@kid,getdate(),1)    
 SET NOCOUNT ON          
 EXEC commonfun.dbo.SetDoInfo @DoUserID = @DoUserID, @DoProc = 'ModuleSet_Edit' --设置上下文标志        
         
 Begin tran             
 BEGIN TRY           
        
  DECLARE @cellset VARCHAR(50)          
  IF(@celltype=1)          
   SET @cellset='1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20'          
  ELSE IF(@celltype=2)          
   SET @cellset='1,3,5,7,9,11,13,15,17,19'          
  ELSE IF(@celltype=3)          
   SET @cellset='2,4,6,8,10,12,14,16,18,20'          
  ELSE IF(@celltype=4)      
  begin        
   SET @cellset=case when right(@term,1)= '1' then '9,10,11,12' else '3,4,5,6' end     
  end     
  
  if @kid=4246
  begin
	set @hbModList = Replace(@hbModList,'AdvCell','XHAdvCell')
	set @gbModList = Replace(@gbModList,'AdvCell','XHAdvCell')
  end
             
  ;MERGE ModuleSet AS ms          
  USING (SELECT @kid kid, @term term, @hbModList hbmodlist,          
    @gbModList gbModList,@Monadvset Monadvset,@celltype celltype,@cellset cellset)AS mu          
  ON (ms.kid = mu.kid and ms.term = mu.term)          
  WHEN MATCHED THEN          
  UPDATE SET           
   ms.hbModList = mu.hbmodlist,          
   ms.gbModList = mu.gbModList,          
   ms.Monadvset = mu.Monadvset,          
   ms.celltype = mu.celltype,      
   ms.cellset = mu.cellset           
  WHEN NOT MATCHED THEN          
  INSERT (kid, term,hbmodlist,gbmodlist,monadvset,celltype,cellset)          
  VALUES (@kid, @term, @hbModList,@gbModList,@Monadvset,@celltype,@cellset);           
            
  IF(@hbModList like '%AdvCell%')          
  begin          
   update d set d.pagetplid=2 from growthbook gb           
    left join diary d on gb.gbid=d.gbid          
   where           
    gb.kid=@kid and gb.term=@term and d.pagetplid=1          
              
  end          
  else          
  begin          
   update d set d.pagetplid=1 from growthbook gb           
    left join diary d on gb.gbid=d.gbid          
   where           
    gb.kid=@kid and gb.term=@term and d.pagetplid=2          
  end          
            
  Commit tran          
 End Try                
 Begin Catch                
  Rollback tran           
  EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志               
  Return -1                  
 end Catch           
 EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志                 
  RETURN 1          
END 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑ModuleSet' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'ModuleSet_Edit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'ModuleSet_Edit', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'ModuleSet_Edit', @level2type=N'PARAMETER',@level2name=N'@term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'家园联系册模块配置' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'ModuleSet_Edit', @level2type=N'PARAMETER',@level2name=N'@hbModList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'成长档案模块配置' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'ModuleSet_Edit', @level2type=N'PARAMETER',@level2name=N'@gbModList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'月进步配置' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'ModuleSet_Edit', @level2type=N'PARAMETER',@level2name=N'@Monadvset'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'填写周期(1每周 2单周 3双周 4每月)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'ModuleSet_Edit', @level2type=N'PARAMETER',@level2name=N'@celltype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作人用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'ModuleSet_Edit', @level2type=N'PARAMETER',@level2name=N'@DoUserID'
GO
