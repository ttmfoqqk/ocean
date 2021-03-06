USE [ocean]
GO
/****** Object:  StoredProcedure [dbo].[OCEAN_BOARD_CONT_L]    Script Date: 08/04/2015 17:52:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: SPWEB
-- Create date: 2012-09-21
-- Description:	게시판 글 목록
-- =============================================
ALTER PROCEDURE [dbo].[OCEAN_BOARD_CONT_L]
	 @pageNo	INT			= 1 
	,@rows		INT			= 10
	,@Key		INT			= 0
	,@Title		VARCHAR(200)= ''
	,@UserId	VARCHAR(50)	= ''	
	,@UserName	VARCHAR(50)	= ''
	,@Indate	VARCHAR(10)	= ''
	,@Outdate	VARCHAR(10)	= ''
	
	,@sId		INT			= 0
	,@sName		INT			= 0
	,@sTitle	INT			= 0
	,@sContant	INT			= 0
	,@sWord		VARCHAR(MAX) = ''
	
	,@UserIdx	INT			= 0
	,@adminIdx	VARCHAR(10) = ''
	
	,@website	VARCHAR(200)= ''
	,@tag		VARCHAR(200)= ''
	
	,@tab		INT			= 0
	,@tab2		INT			= 0
	,@status	VARCHAR(10) = ''
AS
BEGIN
	SET NOCOUNT ON;

    WITH LIST AS
	(
		SELECT row_number() over (order by A.[Parent_no] asc, A.[Ord_no] desc) as [rownum]
			, count(*) over () as [tcount]
			,A.[Idx]
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
			,CONVERT(VARCHAR(16),A.[Indate],20) AS [Indate]
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
			,( CASE A.[AdminIdx] WHEN 0 THEN CONVERT(varchar,C.[UserName]+' '+ C.[UserNameLast]) ELSE D.[Name] END ) AS ContName
		FROM [dbo].[OCEAN_BOARD] A
		INNER JOIN [dbo].[OCEAN_BOARD_CODE] B
		ON(A.[Key] = B.[Idx])
		LEFT JOIN [dbo].[OCEAN_USER_MEMBER] C
		ON(A.[UserIdx] = C.[UserIdx])
		LEFT JOIN [dbo].[OCEAN_ADMIN_MEMBER] D
		ON(A.[AdminIdx] = D.[Idx])
		LEFT JOIN [dbo].[OCEAN_BOARD_TAP] E
		ON(A.[tab2] = E.[idx])
		WHERE A.[Dellfg] = 0
		/*
		WHERE (
			CASE A.[CommentCnt] 
			WHEN 0 THEN A.[Dellfg]
			ELSE (CASE @UserIdx WHEN 0 THEN '' ELSE A.[Dellfg] END) END 
		) = 0
		*/
		AND B.[State] = 0
		AND A.[Key] = @Key
		
		AND CASE @UserIdx  WHEN 0 THEN '' ELSE A.[UserIdx] END = @UserIdx
		AND CASE @adminIdx  WHEN '' THEN '' ELSE A.[AdminIdx] END = @adminIdx
		
		AND CASE @Title	WHEN '' THEN '' ELSE A.[Title] END LIKE '%'+ @Title +'%'
		AND (
			CASE @UserId	WHEN '' THEN '' ELSE C.[UserId] END LIKE '%'+ @UserId +'%' OR
			CASE @UserId	WHEN '' THEN '' ELSE D.[Id] END LIKE '%'+ @UserId +'%'			
		)
		AND (
			CASE @UserName	WHEN '' THEN '' ELSE C.[UserName] END LIKE '%'+ @UserName +'%' OR
			CASE @UserName	WHEN '' THEN '' ELSE D.[Name] END LIKE '%'+ @UserName +'%'
		)
		AND CASE @Indate	WHEN '' THEN '' ELSE CONVERT(VARCHAR,A.[Indate],23) END >= @Indate
		AND CASE @Outdate	WHEN '' THEN '' ELSE CONVERT(VARCHAR,A.[Indate],23) END <= @Outdate
		AND (
			CASE @sId WHEN 1 THEN ( CASE A.[AdminIdx] WHEN 0 THEN C.[UserId] ELSE D.[Name] END ) ELSE '' END LIKE '%'+@sWord+'%'
			OR CASE @sName WHEN 1 THEN ( CASE A.[AdminIdx] WHEN 0 THEN C.[UserName] ELSE D.[Name] END ) ELSE '' END LIKE '%'+@sWord+'%'
			OR CASE @sTitle WHEN 1 THEN [Title] ELSE '' END LIKE '%'+@sWord+'%'
			OR CASE @sContant WHEN 1 THEN [Contants] ELSE '' END LIKE '%'+@sWord+'%' 
		)
		
		AND CASE @website	WHEN '' THEN '' ELSE A.[website] END LIKE '%'+ @website +'%'
		AND CASE @tag	WHEN '' THEN '' ELSE A.[tag] END LIKE '%'+ @tag +'%'
		AND CASE @tab	WHEN 0 THEN '' ELSE A.[tab] END = @tab
		AND CASE @tab2	WHEN 0 THEN '' ELSE A.[tab2] END = @tab2
		AND CASE @status WHEN '' THEN '' ELSE A.[status] END = @status
		
		
	)
	SELECT L.*
	FROM LIST L
	WHERE (tcount-rownum+1) BETWEEN dbo.fnc_row_fr(@pageNo,@rows,tcount) AND dbo.fnc_row_to(@pageNo,@rows,tcount)
	ORDER BY rownum desc
	
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
		,A.[Secret]
		,A.[Notice]
		,A.[Pass]
		,A.[Read_cnt]
		,A.[Dellfg]
		,A.[Ip]
		,CONVERT(VARCHAR(16),A.[Indate],20) AS [Indate]
		,A.[AdminIdx]
		,A.[CommentCnt]
		,A.[website]
		,A.[tag]
		,A.[tab]
		,A.[status]
		,C.[UserId]
		,C.[UserName]
		,D.[Id]
		,D.[Name]
		,E.[name] AS [tab2Name]
		,( CASE A.[AdminIdx] WHEN 0 THEN C.[UserId] ELSE D.[Name] END ) AS ContId
		,( CASE A.[AdminIdx] WHEN 0 THEN CONVERT(varchar,C.[UserName]+' '+ C.[UserNameLast]) ELSE D.[Name] END ) AS ContName
	FROM [dbo].[OCEAN_BOARD] A
	INNER JOIN [dbo].[OCEAN_BOARD_CODE] B
	ON(A.[Key] = B.[Idx])
	LEFT JOIN [dbo].[OCEAN_USER_MEMBER] C
	ON(A.[UserIdx] = C.[UserIdx])
	LEFT JOIN [dbo].[OCEAN_ADMIN_MEMBER] D
	ON(A.[AdminIdx] = D.[Idx])
	LEFT JOIN [dbo].[OCEAN_BOARD_TAP] E
	ON(A.[tab2] = E.[idx])
	
	WHERE A.[Dellfg] = 0
	AND B.[State] = 0
	AND A.[Key] = @Key
	AND A.[Notice] = 1
	AND CASE @tab WHEN 0 THEN '' ELSE A.[tab] END = @tab
	order by [Parent_no] desc
		
END

