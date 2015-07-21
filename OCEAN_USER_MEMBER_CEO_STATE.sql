USE [keti]
GO
/****** Object:  StoredProcedure [dbo].[OCEAN_USER_MEMBER_CEO_STATE]    Script Date: 07/21/2015 13:29:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author: SPWEB
-- Create date: 2014-12-30
-- Description:	회원 승인 리스트/업데이트
-- =============================================
ALTER PROCEDURE [dbo].[OCEAN_USER_MEMBER_CEO_STATE]
	 @idx			VARCHAR(max)	= ''
	,@companyIdx	INT				= 0
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @S VARCHAR (MAX)
	DECLARE @T TABLE(T_INT INT)
	SET @S = @idx

	WHILE CHARINDEX(',',@S)<>0
	BEGIN
		INSERT INTO @T(T_INT) VALUES( SUBSTRING(@S,1,CHARINDEX(',',@S)-1) )
		SET @S=SUBSTRING(@S,CHARINDEX(',',@S)+1,LEN(@S)) 
	END
	
	IF CHARINDEX(',',@S)=0
		BEGIN
		INSERT INTO @T(T_INT) VALUES( SUBSTRING(@S,1,LEN(@S)) )
	END
	
	
    
	SELECT
		 A.[UserIdx]
		,A.[UserId]
		,A.[UserName]
		,A.[UserNameLast]
		,A.[UserEmail]
		,A.[UserHPhone]
		,A.[UserHPhone1]
		,A.[UserHPhone2]
		,A.[UserHPhone3]
		,A.[companyIdx]
		,A.[UserPOsition]
		,B.[cName]
	FROM [dbo].[OCEAN_USER_MEMBER] A
	INNER JOIN [dbo].[OCEAN_MEMBERSHIP] B
	ON(A.[companyIdx] = B.[idx])
	WHERE A.[UserIdx] IN( SELECT T_INT FROM @T)
	AND A.[state] = 1
	AND A.[UserDelFg] = 0
	AND A.[ceo] = 0
	AND A.[companyIdx] = @companyIdx;
	
	UPDATE [dbo].[OCEAN_USER_MEMBER] SET
		[state] = 2
	WHERE [UserIdx] IN( SELECT T_INT FROM @T)
	AND [state] = 1
	AND [UserDelFg] = 0
	AND [ceo] = 0
	AND [companyIdx] = @companyIdx;


	
END


