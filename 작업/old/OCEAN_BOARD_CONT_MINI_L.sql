USE [ocean]
GO
/****** Object:  StoredProcedure [dbo].[OCEAN_BOARD_CONT_MINI_L]    Script Date: 08/03/2015 15:13:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: SPWEB
-- Create date: 2012-09-21
-- Description:	게시판 글 목록추출
-- =============================================
ALTER PROCEDURE [dbo].[OCEAN_BOARD_CONT_MINI_L]
	 @Key		INT = 0
	,@CNT		INT = 5
	,@tab		VARCHAR(10) = ''
	,@notice	VARCHAR(10) = ''
AS
BEGIN
	SET NOCOUNT ON;

    SELECT TOP(@CNT)
		 A.[Idx]
		,A.[Key]
		,A.[Ord_no]
		,A.[Depth_no]
		,A.[Parent_no]
		,A.[UserIdx]
		,A.[Title]
		,A.[Contants]
		,A.[File_name]
		,A.[Secret]
		,A.[Notice]
		,A.[Pass]
		,A.[Read_cnt]
		,A.[Dellfg]
		,A.[Ip]
		,CONVERT(VARCHAR,A.[Indate],23) AS [Indate]
		,A.[AdminIdx]
		,A.[CommentCnt]
		,A.[website]
		,A.[tag]
		,A.[tab]
		,A.[tab2]
	FROM [dbo].[OCEAN_BOARD] A
	INNER JOIN [dbo].[OCEAN_BOARD_CODE] B
	ON(A.[Key] = B.[Idx])
	WHERE A.[Dellfg] = 0
	AND B.[State] = 0
	AND A.[Key] = @Key
	AND CASE @tab WHEN '' THEN '' ELSE A.[tab] END = @tab
	AND CASE @notice WHEN '' THEN '' ELSE A.[notice] END = @notice
	order by A.[Parent_no] DESC, A.[Ord_no] ASC
END

