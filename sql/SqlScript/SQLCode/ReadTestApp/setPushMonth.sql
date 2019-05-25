USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[setPushMonth]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[setPushMonth]  
@ids varchar(1000)  
as  
begin  
 declare @tb table(id int)  
 insert into @tb(id)   
 select col1              
    from CommonFun.dbo.fn_MutiSplitTSQL(@ids,',','#') where col1 is not null  
      
  if exists(select *from @tb)  
  begin  
 update  Push set iscurpush=1 where  ID in(select ID from @tb )  
 end  
 if(@@ERROR<>0)  
 return -1  
else  
 return 1  
end
GO
