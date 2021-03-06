USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_photos_GetListByPage]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--用途：分页取相片信息 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 11:50:29
--[class_photos_GetListByPage] 72147,1,5
------------------------------------
CREATE PROCEDURE [dbo].[class_photos_GetListByPage]
@albumid int,
@page int,
@size int
 
 AS

	IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int
		
		SET @prep = @size * @page
		SET @ignore=@prep - @size

		DECLARE @tmptable TABLE
		(
			--定义临时表
			row int IDENTITY (1, 1),
			tmptableid bigint
		)
		
		
		if(@size=1)
		begin
		SET ROWCOUNT 1
		INSERT INTO @tmptable(tmptableid)
			SELECT
				photoid
			FROM
				class_photos
			WHERE
				albumid=@albumid AND status=1 and orderno=@page
			ORDER BY
				orderno desc
        end
		else
		begin
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
			SELECT
				photoid
			FROM
				class_photos
			WHERE
				albumid=@albumid AND status=1
			ORDER BY
				orderno desc
		end

			
			
			IF(@size=1)
			BEGIN

				SET ROWCOUNT @size
				SELECT
					photoid,albumid,title,filename,filepath,filesize,viewcount,commentcount,uploaddatetime,iscover,isfalshshow,dbo.IsNewPhoto(uploaddatetime) AS newphoto,orderno,net
				FROM
					@tmptable as tmptable
				INNER JOIN
					class_photos t1
				ON
					tmptable.tmptableid = t1.photoid							

					--DECLARE @photoid int
					--SELECT	@photoid=tmptableid FROM @tmptable WHERE row=@page
					--Update class_photos SET viewcount=viewcount+1 WHERE photoid=@photoid
					--Update class_photos SET viewcount=viewcount+1 WHERE orderno=@page and albumid=@albumid
			END
			else
			begin
				SET ROWCOUNT @size
			SELECT
				photoid,albumid,title,filename,filepath,filesize,viewcount,commentcount,uploaddatetime,iscover,isfalshshow,dbo.IsNewPhoto(uploaddatetime) AS newphoto,orderno,net
			FROM
				@tmptable as tmptable
			INNER JOIN
				class_photos t1
			ON
				tmptable.tmptableid = t1.photoid
			WHERE
				row > @ignore and albumid=@albumid and status=1 ORDER BY orderno desc
			end
	END
	ELSE
	BEGIN
		
		IF(@size=1)
		BEGIN
			SET ROWCOUNT 1
			SELECT
			photoid,albumid,title,filename,filepath,filesize,viewcount,commentcount,uploaddatetime,iscover,isfalshshow,dbo.IsNewPhoto(uploaddatetime) AS newphoto,orderno,net
		FROM
			class_photos t1
			where albumid=@albumid AND status=1 and orderno=@page
				order by orderno desc
			DECLARE @orderno int
			--SELECT	@orderno=MAX(orderno) FROM class_photos WHERE  albumid=@albumid
			--Update class_photos SET viewcount=viewcount+1 WHERE orderno=@page and albumid=@albumid
		END
		else
		begin
			SET ROWCOUNT @size
		SELECT
			photoid,albumid,title,filename,filepath,filesize,viewcount,commentcount,uploaddatetime,iscover,isfalshshow,dbo.IsNewPhoto(uploaddatetime) AS newphoto,orderno,net
		FROM
			class_photos t1
		where albumid=@albumid AND status=1
		order by orderno desc

		end
	END	












GO
