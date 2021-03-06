USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[teacherinfo_GetList]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      xie    
-- Create date: 2013-05-22    
-- Description:     
-- Paradef: roletype(1：园长，2：校医，3：主班老师)    
-- Memo:    
teacherinfo_GetList 12511,-1,3  
*/    
CREATE PROCEDURE [dbo].[teacherinfo_GetList]    
@kid int,    
@cid int,    
@roletype int    
 AS     
    
declare @excuteSql nvarchar(2000),    
@ParmDefinition nvarchar(200)    
    
set @excuteSql = 'select ut.kid,ut.userid,uc.cid,c.cname,ut.mobile,ut.name,    
     isnull(sm.roletype,0) roletype,ut.title    
     from  basicdata..User_Teacher ut    
     inner join BasicData..user_class uc     
      on uc.userid=ut.userid    
     inner join BasicData..class c    
      on c.cid=uc.cid    
     inner join BlogApp..permissionsetting p   
      on p.kid =c.kid and p.ptype=90  
     LEFT join mcapp..sms_man_kid sm     
      on sm.kid = ut.kid and sm.cid =uc.cid and sm.userid=ut.userid     
     where ut.usertype<>98'    
         
if @kid<>-1 set @excuteSql = @excuteSql+' and ut.kid = @kid'    
if @cid<>-1 set @excuteSql = @excuteSql+' and uc.cid = @cid'    
if @roletype<>-1 set @excuteSql = @excuteSql+' and sm.roletype = @roletype'    
    
SET @ParmDefinition =     
    N'@kid INT = NULL,    
      @cid INT = NULL,     
         @roletype INT = NULL';    
             
PRINT @excuteSql              
exec SP_EXECUTESQL @excuteSql,@ParmDefinition,    
     @kid = @kid,    
     @cid = @cid,    
     @roletype = @roletype;     
    
GO
