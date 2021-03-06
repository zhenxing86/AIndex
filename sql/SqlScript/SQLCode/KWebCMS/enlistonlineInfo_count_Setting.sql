USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[enlistonlineInfo_count_Setting]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--设置报名人数限制和是否开启在线报名设置    
CREATE proc [dbo].[enlistonlineInfo_count_Setting]      
@siteid int ,      
@enlistcount int,    
@enliston int=1,
@openenlistset int =1    
as      
begin      
update dbo.site_config      
set enlistcount=@enlistcount,enliston=@enliston,openenlistset=@openenlistset    
 where siteid=@siteid      
     IF @@ERROR <> 0        
    BEGIN        
        RETURN 0        
    END        
    ELSE        
    BEGIN        
        RETURN 1        
    END        
end
GO
