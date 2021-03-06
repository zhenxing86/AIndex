USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClassCode]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetClassCode]
@KindergartenCode varchar(3)
  AS
declare @OldClassCode as varchar(20)
declare @Id as varchar(3)
declare @ClassCode as varchar(20)
select @OldClassCode=(select max(Code) from T_Class  where substring(Code,1,3)=@KindergartenCode and substring(Code, 4,2)=substring(convert(char(4),datepart(year,GetDate())),3,2))
if @OldClassCode is Null
   select @ClassCode=@KindergartenCode+ substring(convert(char(4),datepart(year,GetDate())),3,2) + '01'
else
    begin
        select @Id=convert(varchar(2),convert(int,substring(@OldClassCode,6,2)+1))
        select @ClassCode=@KindergartenCode+ substring(convert(char(4),datepart(year,GetDate())),3,2)+ REPLICATE('0', 2-datalength(@Id))+@Id
    end
select @ClassCode
GO
