USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_GBApp_ChildrenInfo_UpFile]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[rep_GBApp_ChildrenInfo_UpFile]
@gbid int,
@m_my_Photo varchar(1000),
@net int
as

update GBApp..ChildrenInfo  set m_my_Photo=@m_my_Photo,net =@net,updatetime=GETDATE()
where gbid=@gbid

 exec gbapp..[UpdateGBRefreshTag] @gbid
GO
