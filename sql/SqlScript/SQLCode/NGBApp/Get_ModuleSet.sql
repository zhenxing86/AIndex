USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[Get_ModuleSet]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:      along      
-- Create date: 2013-09-16      
-- Description:       
-- Memo:  exec [Get_ModuleSet] 12913  

select * from [NGBApp].[dbo].[ModuleSet] where kid =12913  
select *from basicdata..kid_term where kid =12913   
select commonfun.dbo.fn_getCurrentTerm(12913,getdate(),1)
*/      
CREATE PROC [dbo].[Get_ModuleSet]      
@kid int      
AS      
--SELECT top 1  ms.[kid]      
--      ,[term]      
--      ,[hbModList]      
--      ,[gbModList]      
--      ,[Monadvset]      
--      ,ms.[celltype],ms.cellset      
--  FROM [NGBApp].[dbo].[ModuleSet] ms    
      
--  where ms.kid=@kid order by convert(datetime,left(term,4)+'-1'+right(term,1)+'-01') desc      
    
  declare @term nvarchar(10) = commonfun.dbo.fn_getCurrentTerm(@kid,getdate(),1)
  
  if not exists(select*from [ModuleSet] where kid=@kid and term=@term)
  begin
	  --如果上个学期有，而这个学期还没有生成，就是用上学期的配置，并插入到数据库
	  insert into [NGBApp].[dbo].[ModuleSet](kid, term,hbmodlist,gbmodlist,monadvset,celltype,cellset)
	   SELECT top 1  kid, @term,hbmodlist,gbmodlist,
	   case when isnull(monadvset,'')<>'' and right(@term,1)=1 then '9,10,11,12' 
	    when isnull(monadvset,'')<>'' and right(@term,1)=0 then '3,4,5,6' else '' end monadvset,celltype,
	   case when celltype=4 then 
	    case when right(@term,1)=1 then '9,10,11,12' else '3,4,5,6' end 
	   else cellset end  cellset  
        FROM [NGBApp].[dbo].[ModuleSet] ms       
        where ms.kid=@kid order by convert(datetime,left(term,4)+'-1'+right(term,1)+'-01') desc  
	  
  end
  
  select ms.[kid],[term],[hbModList],[gbModList],[Monadvset] ,ms.[celltype],ms.cellset    
   FROM fn_ModuleSet(@kid,@term) ms  



     
  
    
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'返回用户配置' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Get_ModuleSet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Get_ModuleSet', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
