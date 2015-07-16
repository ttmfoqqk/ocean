USE [keti]
GO
/****** Object:  StoredProcedure [dbo].[OCEAN_BOARD_CONT_V]    Script Date: 07/16/2015 20:53:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: SPWEB
-- Create date: 2012-09-24
-- Description:	게시판 글 상세
-- =============================================
ALTER PROCEDURE [dbo].[OCEAN_BOARD_CONT_V]
	 @Idx		INT			= 0
	,@BoardKey	INT			= 0
	,@actType	VARCHAR(10)	= ''
	,@Comment	INT			= 0
	,@UserIdx	INT			= 0
AS
BEGIN
	SET NOCOUNT ON;
	
	IF @actType = 'VIEW'
		BEGIN
		UPDATE [dbo].[OCEAN_BOARD] SET
			[Read_cnt] = [Read_cnt] + 1
		WHERE [Key] = @BoardKey
		AND [Idx] = @Idx
	END 

	SELECT 
		 A.[Idx]
		,A.[Key]
		,A.[Ord_no]
		,A.[Depth_no]
		,A.[Parent_no]
		,A.[UserIdx]
		,A.[Title]
		,A.[Contants]
		,A.[File_name]
		,A.[File_name2]
		,A.[File_name3]
		,A.[File_name4]
		,A.[File_name5]
		,A.[File_name6]
		,A.[File_name7]
		,A.[File_name8]
		,A.[File_name9]
		,A.[File_name10]
		,A.[Secret]
		,A.[Notice]
		,A.[Pass]
		,A.[Read_cnt]
		,A.[Dellfg]
		,A.[Ip]
		,A.[Indate]
		,A.[AdminIdx]
		,A.[CommentCnt]
		,A.[website]
		,A.[tag]
		,A.[tab]
		,A.[tab2]
		,A.[status]
		,E.[name] AS [tab2Name]
		,C.[UserId]
		,C.[UserName]
		,D.[Id]
		,D.[Name]
		,( CASE A.[AdminIdx] WHEN 0 THEN C.[UserId] ELSE D.[Name] END ) AS ContId
		,( CASE A.[AdminIdx] WHEN 0 THEN C.[UserName] ELSE D.[Name] END ) AS ContName
	FROM [dbo].[OCEAN_BOARD] A
	INNER JOIN [dbo].[OCEAN_BOARD_CODE] B
	ON(A.[Key] = B.[Idx])
	LEFT JOIN [dbo].[OCEAN_USER_MEMBER] C
	ON(A.[UserIdx] = C.[UserIdx])
	LEFT JOIN [dbo].[OCEAN_ADMIN_MEMBER] D
	ON(A.[AdminIdx] = D.[Idx])
	LEFT JOIN [dbo].[OCEAN_BOARD_TAP] E
	ON(A.[tab2] = E.[idx])
	
	WHERE A.[Key] = @BoardKey
	AND A.[Idx] = @Idx
	AND CASE @UserIdx WHEN 0 THEN '' ELSE A.[UserIdx] END = @UserIdx;

	SELECT 
		 A.[Idx]
		,A.[BoardKey]
		,A.[ContIdx]
		,A.[UserIdx]
		,A.[Contants]
		,A.[Ip]
		,A.[Dellfg]
		,CONVERT(VARCHAR,A.[Indate],23) AS [Indate]
		,A.[AdminIdx]
		,A.[Ord_no]
		,A.[Depth_no]
		,A.[Parent_no]
		,( CASE A.[UserIdx] WHEN 0 THEN D.[Name] ELSE C.[UserId] END ) AS ContId
		,( CASE A.[UserIdx] WHEN 0 THEN D.[Name] ELSE C.[UserName] END ) AS ContName
	FROM [dbo].[OCEAN_BOARD_COMMENT] A
	LEFT JOIN [dbo].[OCEAN_USER_MEMBER] C
	ON(A.[UserIdx] = C.[UserIdx])
	LEFT JOIN [dbo].[OCEAN_ADMIN_MEMBER] D
	ON(A.[AdminIdx] = D.[Idx])
	WHERE A.[Dellfg] = 0
	AND A.[ContIdx] = @Idx
	AND A.[BoardKey] = @BoardKey
	AND CASE @Comment WHEN 0 then A.[Idx] ELSE '' END = 0
	order by A.[Parent_no] desc, A.[Ord_no] asc;


END

