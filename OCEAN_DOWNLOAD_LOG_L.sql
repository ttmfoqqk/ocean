USE [keti]
GO
/****** Object:  StoredProcedure [dbo].[OCEAN_DOWNLOAD_LOG_L]    Script Date: 07/21/2015 17:23:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		SPWEB
-- Create date: 2014-12-15
-- Description:	다운로드 로그 리스트
-- =============================================
ALTER PROCEDURE [dbo].[OCEAN_DOWNLOAD_LOG_L]
	 @pageNo	int				= 1 
	,@rows		int				= 10
	,@title		VARCHAR(200)	= ''
	,@id		VARCHAR(200)	= ''
	,@name		VARCHAR(200)	= ''
	,@Indate	VARCHAR(10)		= ''
	,@Outdate	VARCHAR(10)		= ''
AS
BEGIN
	SET NOCOUNT ON;

	WITH LIST AS
	(
		SELECT row_number() over ( order by A.[idx] asc ) as [rownum]
			, count(*) over () as [tcount]
			,A.[date]
			,A.[ip]
			,B.[Title]
			,B.[File_name]
			,C.[UserId]
			,C.[UserName]
			,C.[UserNameLast]
		FROM [dbo].[OCEAN_DOWNLOAD_LOG] A
		INNER JOIN [dbo].[OCEAN_BOARD] B
		ON(A.[bidx] = B.[Idx])
		INNER JOIN [dbo].[OCEAN_USER_MEMBER] C
		ON(A.[uidx] = C.[UserIdx])
		
		WHERE CASE @title WHEN '' THEN '' ELSE B.[Title] END LIKE '%'+@title+'%'
		AND CASE @id WHEN '' THEN '' ELSE C.[UserId] END LIKE '%'+@id+'%'
		AND CASE @name WHEN '' THEN '' ELSE CONVERT(varchar,C.[UserName]+' '+ISNULL(C.[UserNamelast],''))  END LIKE '%'+@name+'%'

		AND CASE @Indate WHEN '' THEN '' ELSE CONVERT(VARCHAR,A.[date],23) END >= @Indate
		AND CASE @Outdate WHEN '' THEN '' ELSE CONVERT(VARCHAR,A.[date],23) END <= @Outdate
		
		AND B.[Dellfg] = 0
	)
	SELECT L.*
	FROM LIST L
	WHERE (tcount-rownum+1) BETWEEN dbo.fnc_row_fr(@pageNo,@rows,tcount) AND dbo.fnc_row_to(@pageNo,@rows,tcount)
	ORDER BY rownum desc

END

