USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[GetModel]    Script Date: 2014/11/24 23:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
-- Author:      Master谭
-- Create date: 2013-10-24
-- Description:	
-- Memo:		GetModel 1,'Object_Pic'
*/
CREATE PROC [dbo].[GetModel]
	@ID Bigint,
	@TbName varchar(50)
AS
BEGIN
	SET NOCOUNT ON
	IF @TbName = 'Object_M'	
	SELECT	o.ID, o.kid, isnull(s.Title,'未分类')Title, isnull(ss.Title,'未分类') SubTitle, 
					o.BarCode, o.Name, o.SortCode, o.SortSubCode, o.Qty, o.WarnQty, o.Unit, o.Size, 
					o.CrtDate, o.udate, o.Price, ISNULL(op.cnt,0) PicCnt
		FROM Object_M o 
			left join Sort s 
				on s.kid = o.kid 
				and s.SortCode = o.SortCode
			left join SortSub ss
				on s.kid = o.kid 
				and s.SortCode = o.SortCode 
				and ss.SortSubCode = o.SortSubCode 
			LEFT JOIN Object_PicCnt_v op
				on o.kid = op.kid
				and o.BarCode = op.BarCode
		where o.ID = @ID	
	ELSE IF @TbName = 'Sort'
	SELECT	ID, SortCode, Title, IsConsum, Audit
		FROM Sort
		WHERE ID = @ID
	ELSE IF @TbName = 'SortSub'
	SELECT	s.ID, s.SortCode, s.SortSubCode, sm.Title, s.Title SubTitle
		FROM SortSub s
			INNER JOIN Sort sm on s.SortCode = sm.SortCode and s.kid = sm.kid
		WHERE s.ID = @ID
	ELSE IF @TbName = 'Apply_M'
	SELECT ID, AppSigNo, Title, cid, Memo, RetDate
		FROM Apply_M
		WHERE ID = @ID
	ELSE IF @TbName = 'Apply'
		SELECT m.ID, m.AppSigNo, m.Title, u.name FirName, m.FirDate, u1.name AppName, c.cname,
		m.AppDate, u2.name AuditName, m.AuditDate, u3.name PassName,
		m.PassDate, u4.name ChkName, m.ChkDate, m.Memo, m.Status, m.RetDate, u5.Name NeedName, 
		m.NeedDate, ISNULL(oa.Audit,0) Audit, u2.userid AuditUserID
		FROM Apply_M m
		OUTER APPLY(
				SELECT TOP(1) 1 Audit
				FROM Apply_D d 
					inner join Object_M o 
					on d.kid = o.kid 
					and d.BarCode = o.BarCode 
					inner join Sort s 
					on s.kid = o.kid 
					and s.SortCode = o.SortCode 
					and s.Audit = 1
				WHERE d.kid = m.kid
					and d.AppSigNo = m.AppSigNo
			)oa
		left join BasicData..[user] u on m.FirUserid = u.userid 
		left join BasicData..[user] u1 on m.AppUserID = u1.userid 
		left join BasicData..[user] u2 on m.AuditUserID = u2.userid 
		left join BasicData..[user] u3 on m.PassUserID = u3.userid 
		left join BasicData..[user] u4 on m.ChkUserID = u4.userid 
		left join BasicData..[user] u5 on m.NeedUserID = u5.userid 
		left join BasicData..[class] c on m.cid = c.cid 				
			WHERE m.ID = @ID
	ELSE IF @TbName = 'Object_Pic'
	SELECT     ID, kid, BarCode, Title, FileName, FilePath, Crtdate
		FROM Object_Pic
		where ID = @ID
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'根据自增ID获取某个表的值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetModel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetModel', @level2type=N'PARAMETER',@level2name=N'@ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'表名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetModel', @level2type=N'PARAMETER',@level2name=N'@TbName'
GO
