USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[GetStuClassInfo]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*        
-- Author:      xie        
-- Create date: 2014-07-22        
-- Description: 根据kid、classid、level获取该班级学生信息（用于晨检平板）   
-- Memo:
[GetStuClassInfo] 
@kid = 12511
,@classid = null
,@level =0
 
[GetStuClassInfo] 
@kid = 12511
,@level =0
   
[GetStuClassInfo] 
@classid = 81185
,@level =1
 
*/        
CREATE PROCEDURE [dbo].[GetStuClassInfo]                   
@kid int = null
,@classid int = null
,@level int=0 --0：根据kid获取所有班级，1：根据classid获取所有小朋友信息        
 AS                    
                
if @level=0           
begin     
	--根据kid获取所有班级            
    select c.[cid],c.[cname]         
     from basicdata..class c  
     where kid=@kid and deletetag=1                
end                     
else if(@level =1)           
begin 
	 --根据classid获取所有小朋友信息            
	 select [userid],[name]      
	  from basicdata..User_Child uc                
	  where uc.cid=@classid            
end 

GO
