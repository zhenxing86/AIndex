USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStudyNo]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_GetStudyNo]
@ClassCode varchar(10)
  AS
declare @OldStudyNo as varchar(20)
declare @Id as varchar(3)
declare @StudyNo as varchar(20)
select @OldStudyNo=(select max(StudyNo) from T_Child  where substring(StudyNo,1,7)=@ClassCode)
if @OldStudyNo is Null
   select @StudyNo=@ClassCode+'001'
else
    begin
        select @Id=convert(varchar(3),convert(int,substring(@OldStudyNo,8,3)+1))
        select @StudyNo=@ClassCode+REPLICATE('0', 3-datalength(@Id))+@Id        
    end
select @StudyNo
GO
