USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[attendance_GetListTag]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*              
-- Author:      蔡杰       
-- Create date: 2014-05-22            
-- Description:       
-- Memo:          
-- attendance_GetListTag 0, 12511, '2013-08-21', 0, -1, -1, -1    
*/             
CREATE Procedure [dbo].[attendance_GetListTag]      
@ftype int,--0:小朋友，1：老师    
@kid int,    
@cdate date,    
@did int,    
@grade Int,    
@cid int,    
@status int--正常1, 缺勤0    
as      
Set Nocount on       
    
if @ftype = 0    
begin    
  ;With Data as (    
  Select c.cname, b.ID, a.Userid, a.name Username, Case When a.gender = 2 Then '女' Else '男' End Sex, intime, outtime, b.reasoncode, d.caption,    
         Case WHen intime is Null Then '缺勤' Else '正常' End status    
    From basicdata.dbo.[user_child] a Left Join mcapp.dbo.stu_in_out_time b ON a.userid = b.userid and b.adddate = @cdate    
                                      Left Join basicdata..dict_xml d On b.reasoncode = d.code and d.Catalog='缺勤原因',     
         basicdata.dbo.class c    
    Where a.cid = c.cid and Case When @grade = -1 Then @grade Else a.grade End = @grade    
      and Case When @cid = -1 Then @cid Else a.cid End = @cid and a.kid = @kid    
  )    
  Select * From Data Where Case When @status = -1 Then - 1 Else status End = Case @status When 1 Then '正常' When 0 Then '缺勤' Else @status End Order by cname, reasoncode    
end    
    
if @ftype = 1    
begin    
  ;With Data as (    
  Select c.dname, b.ID, a.Userid, e.name Username, Case When e.gender = 2 Then '女' Else '男' End Sex, intime, outtime, b.reasoncode, d.caption,    
         Case WHen intime is Null Then '缺勤' Else '正常' End status    
    From basicdata.dbo.teacher a Left Join mcapp.dbo.stu_in_out_time b ON a.userid = b.userid and b.adddate = @cdate    
                                 Left Join basicdata..dict_xml d On b.reasoncode = d.code and d.Catalog='缺勤原因'   
                                 Left Join basicdata.dbo.department c On a.did = c.did,    
         basicdata.dbo.[user] e    
    Where Case When @did = -1 Then @did Else a.did End = @did and a.userid = e.userid    
      and e.kid = @kid and e.usertype = 1    
  )    
  Select * From Data Where Case When @status = -1 Then - 1 Else status End = Case @status When 1 Then '正常' When 0 Then '缺勤' Else @status End Order by reasoncode    
end    
GO
