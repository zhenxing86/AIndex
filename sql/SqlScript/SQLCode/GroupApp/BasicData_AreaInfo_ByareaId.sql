USE [KinInfoApp]
GO
/****** Object:  StoredProcedure [dbo].[BasicData_AreaInfo_ByareaId]    Script Date: 2014/11/24 23:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[BasicData_AreaInfo_ByareaId]
@areaid int
as

declare @paid1 int,@astr varchar(100)

declare @paid2 int,@astr2 varchar(100),@astr3 varchar(100)

select @paid1=Superior,@astr=Title from BasicData..Area where ID =@areaid

select @paid2=Superior,@astr2=Title from BasicData..Area where ID =@paid1

select @astr3=Title from BasicData..Area where ID =@paid2

select @paid2,@astr3,@paid1,@astr2,@areaid,@astr
--a1,a1str,a2,a2str,a3,a3str


GO
