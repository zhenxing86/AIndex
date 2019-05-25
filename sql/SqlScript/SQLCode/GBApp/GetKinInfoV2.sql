use gbapp
go
/*
	-- Author:      xie     
	-- Create date: 2014-02-11        
	-- Description: 根据kid，term获取幼儿园信息 （新版成长档案使用）        
	-- Memo:use gbapp        
	select * from growthbook where userid=295765        
	[GetKinInfoV2] 79818,'2013-0' 
*/
CREATE PROCEDURE [dbo].[GetKinInfoV2]  
@kid int,
@term nvarchar(10)='2013-0'
 AS    
  
  declare @strTerm nvarchar(10)='上学期'
  set @strTerm = case when substring(@term,charindex('-',@term)+1,len(@term))='1' then '上学期' else '下学期' end
  
  select [kname],@strTerm ,'',kid 
   from BasicData..kindergarten  
   where deletetag =1
	and kid=@kid  