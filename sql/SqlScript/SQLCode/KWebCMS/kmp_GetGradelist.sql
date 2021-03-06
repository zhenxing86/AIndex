USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_GetGradelist]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
--[kmp_GetGradelist] 16370    
CREATE PROCEDURE [dbo].[kmp_GetGradelist]    
@siteid int    
AS    
BEGIN    
if(exists(select 1 from theme_kids where kid=@siteid))    
begin    
 SET @siteid=12511    
end    
    
select distinct K.gid,k.gname,'','',k.[order]  from basicdata..grade  k      
 inner  join basicdata..class  c on c.grade=k.gid      
where c.kid=@siteid and c.deletetag=1 and c.grade<>38  order by k.[order] asc  
END    
    
--select * from basicdata..class where kid=16370 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_GetGradelist', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
