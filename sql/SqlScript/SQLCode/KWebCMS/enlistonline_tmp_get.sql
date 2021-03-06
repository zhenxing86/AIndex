USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[enlistonline_tmp_get]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--针对1422 2014-7-7  
CREATE proc [dbo].[enlistonline_tmp_get]  
@siteid int  
as  
    
declare @enlst_tmpcount int  
  select @enlst_tmpcount=COUNT(1) from enlistonline_tmp  
  if(@enlst_tmpcount>0)  
  begin  
   insert into enlistonline(siteid,name,sex,birthday,contactaddress,contactphone,funit,memo,createdatetime)  
select top 1 @siteid,name,sex,birthday,contactaddress,contactphone,condition,memo,GETDATE() from enlistonline_tmp   where siteid=@siteid
delete from dbo.enlistonline_tmp where id in(select top 1 id from enlistonline_tmp  where siteid=@siteid) and siteid=@siteid  
  
end  
 IF @@ERROR <> 0    
    BEGIN  
		
        RETURN 0    
    END    
    ELSE    
    BEGIN   
		
        RETURN 1  
    END    


GO
