USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[syn_all]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












--insert into datamonitor(kid)values(17709)
CREATE
 PROCEDURE [dbo].[syn_all]

as

declare @kid int

select top 1 @kid=kid from datamonitor

if(@kid>0)
begin
	exec [syn_stuinfo_update] @kid

	exec [syn_teainfo_update] @kid

	exec [syn_userinfo_delete] @kid

	delete datamonitor where kid=@kid
end









GO
