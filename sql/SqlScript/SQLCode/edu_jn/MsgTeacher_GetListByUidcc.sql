USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[MsgTeacher_GetListByUidcc]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[MsgTeacher_GetListByUidcc]
@useridstr varchar(max)
,@page int
,@size int
as 


set @useridstr='0'+@useridstr

declare @pcount int
set @pcount=0

--select kid,[kname],uid,[uname],u_mobile,t_title  from 
--dbo.rep_kininfo

exec('select '+@pcount+','''','''',kid,[kname],uid,[uname],u_mobile,t_title job from rep_kininfo
where uid in ('+@useridstr +')')














GO
