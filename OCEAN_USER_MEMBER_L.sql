USE [keti]
GO
/****** Object:  StoredProcedure [dbo].[OCEAN_USER_MEMBER_L]    Script Date: 07/20/2015 14:52:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: SPWEB
-- Create date: 2012-09-20
-- Description:	회원 리스트
-- =============================================
ALTER PROCEDURE [dbo].[OCEAN_USER_MEMBER_L]
	 @pageNo		int			= 1 
	,@rows			int			= 10
	,@UserId		VARCHAR(50)	= ''
	,@Hphone3		VARCHAR(30)	= ''
	,@UserName		VARCHAR(50)	= ''
	,@delFg			VARCHAR(1)	= ''
	,@State			VARCHAR(1)	= ''
	,@Indate		VARCHAR(10)	= ''
	,@Outdate		VARCHAR(10)	= ''
	,@UserIdx		INT			= 0
	,@companyIdx	VARCHAR(50)	= ''
	,@ceoFg			VARCHAR(1)	= ''
AS
BEGIN
	SET NOCOUNT ON;

    WITH LIST AS
	(
		SELECT row_number() over ( order by A.[UserIdx] asc ) as [rownum]
			, count(*) over () as [tcount]
			,A.[UserIdx]
			,A.[UserId]
			,A.[UserName]
			,A.[UserNameLast]
			,A.[UserEmail]
			,CONVERT(VARCHAR,A.[UserIndate],23) AS [UserIndate]
			,A.[UserIndate] AS [UserIndate_full]
			,CONVERT(VARCHAR,A.[UserOutdate],23) AS [UserOutdate]
			,A.[UserDelFg]
			,A.[UserBigo]
			,A.[UserHPhone]
			,A.[UserHPhone1]
			,A.[UserHPhone2]
			,A.[UserHPhone3]
			,A.[UserPhone]
			,A.[UserPhone1]
			,A.[UserPhone2]
			,A.[UserPhone3]
			,A.[UserFax1]
			,A.[UserFax2]
			,A.[UserFax3]
			,A.[companyIdx]
			,A.[state]
			,A.[ceo]
			,A.[UserPOsition]
			,B.[cName]
		FROM [dbo].[OCEAN_USER_MEMBER] A
		LEFT JOIN [dbo].[OCEAN_MEMBERSHIP] B
		ON(A.[companyIdx] = B.[idx])
		
		WHERE 
			CASE @UserId WHEN '' THEN '' ELSE CONVERT(varchar,A.[UserId] +' '+ isnull(A.[UserEmail],'') ) END LIKE '%'+@UserId+'%'
		
		AND 
			CASE @UserName WHEN '' THEN '' 
			ELSE CONVERT(varchar,A.[UserName]+' '+ISNULL(A.[UserNamelast],'')) 
			END LIKE '%'+@UserName+'%'
		
		AND 
			CASE @Hphone3 WHEN '' THEN '' 
			ELSE CONVERT(varchar, ISNULL(A.[UserHPhone1]+'-'+A.[UserHPhone2]+'-'+A.[UserHPhone3],'') + ISNULL(A.[UserHPhone],'') )
			END LIKE '%'+@Hphone3+'%'
			
		AND CASE @Indate WHEN '' THEN '' ELSE CONVERT(VARCHAR,A.[UserIndate],23) END >= @Indate
		AND CASE @Outdate WHEN '' THEN '' ELSE CONVERT(VARCHAR,A.[UserIndate],23) END <= @Outdate
		AND CASE @delFg WHEN '' THEN '' ELSE A.[UserDelFg] END = @delFg
		AND CASE @State WHEN '' THEN '' ELSE A.[state] END = @State
		AND CASE @UserIdx WHEN '' THEN '' ELSE A.[UserIdx] END = @UserIdx
		AND CASE @companyIdx WHEN '' THEN '' ELSE A.[companyIdx] END = @companyIdx
		AND CASE @ceoFg WHEN '' THEN '' ELSE A.[ceo] END = @ceoFg

	)
	SELECT L.*
	FROM LIST L
	WHERE (tcount-rownum+1) BETWEEN dbo.fnc_row_fr(@pageNo,@rows,tcount) AND dbo.fnc_row_to(@pageNo,@rows,tcount)
	ORDER BY rownum desc
END

