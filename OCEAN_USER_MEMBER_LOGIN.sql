USE [keti]
GO
/****** Object:  StoredProcedure [dbo].[OCEAN_USER_MEMBER_LOGIN]    Script Date: 07/21/2015 13:07:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SPWEB
-- Create date: 2012-10-08
-- Description:	회원 로그인
-- =============================================
ALTER PROCEDURE [dbo].[OCEAN_USER_MEMBER_LOGIN]
	 @UserId		VARCHAR(320)	= ''
	,@UserPass		VARCHAR(50)		= ''
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT 
		 [UserIdx]
		,[UserId]
		,[UserName]
		,[UserNameLast]
		,pwdcompare(@UserPass,[UserPass]) as [Pass]
		,[state]
		,[ceo]
		,[companyIdx]
	FROM [dbo].[OCEAN_USER_MEMBER]
	WHERE [UserId] = @UserId
	and [UserDelFg] = 0
	
END

