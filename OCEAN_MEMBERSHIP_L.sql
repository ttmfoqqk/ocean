USE [keti]
GO
/****** Object:  StoredProcedure [dbo].[OCEAN_MEMBERSHIP_L]    Script Date: 07/20/2015 19:23:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author: SPWEB
-- Create date: 2014-12-15
-- Description:	기업회원 리스트
-- =============================================
ALTER PROCEDURE [dbo].[OCEAN_MEMBERSHIP_L]
	 @pageNo	int				= 1 
	,@rows		int				= 10
	,@cName		VARCHAR(200)	= ''
	,@ceo		VARCHAR(200)	= ''
	,@sano		VARCHAR(50)		= ''
	,@State		VARCHAR(10)		= ''
	,@Indate	VARCHAR(10)		= ''
	,@Outdate	VARCHAR(10)		= ''
	,@Country	VARCHAR(100)	= ''
AS
BEGIN
	SET NOCOUNT ON;

    WITH LIST AS
	(
		SELECT row_number() over ( order by [idx] asc ) as [rownum]
			, count(*) over () as [tcount]
			,[idx]
			,[cName]
			,[ceo]
			,[sano]
			,CONVERT(varchar,[CDate],23) AS [CDate]
			,[addr1]
			,[addr2]
			,[cScale]
			,[cPhone]
			,[cSectors]
			,[homepage]
			,[cItems]
			,[cSales]
			,[cStaff]
			,[cCenter]
			,[business]
			,[business1]
			,[business2]
			,[business3]
			,[business4]
			,[business5]
			,[business6]
			,[business7]
			,[business8]
			,[business9]
			,[business10]
			,[business11]
			,[business12]
			,[iot_business]
			,[iot_business1]
			,[iot_business2]
			,[iot_business3]
			,[iot_business4]
			,[iot_business5]
			,[iot_business6]
			,[files1]
			,[files2]
			,[State]
			,CONVERT(varchar,[inDate],23) AS [inDate]
			,[Country]
			,[bigo]
			,ISNULL([addr],'') as [addr]
		FROM [dbo].[OCEAN_MEMBERSHIP]
		
		WHERE CASE @cName WHEN '' THEN '' ELSE [cName] END LIKE '%'+@cName+'%'
		AND CASE @sano WHEN '' THEN '' ELSE [sano] END LIKE '%'+@sano+'%'
		AND CASE @ceo WHEN '' THEN '' ELSE [ceo] END LIKE '%'+@ceo+'%'
		AND CASE @Country WHEN '' THEN '' ELSE [Country] END LIKE '%'+@Country+'%'
		
		AND CASE @State WHEN '' THEN '' ELSE [State] END = @State
		AND CASE @Indate WHEN '' THEN '' ELSE CONVERT(VARCHAR,[inDate],23) END >= @Indate
		AND CASE @Outdate WHEN '' THEN '' ELSE CONVERT(VARCHAR,[inDate],23) END <= @Outdate
	)
	SELECT L.*
	FROM LIST L
	WHERE (tcount-rownum+1) BETWEEN dbo.fnc_row_fr(@pageNo,@rows,tcount) AND dbo.fnc_row_to(@pageNo,@rows,tcount)
	ORDER BY rownum desc
END


