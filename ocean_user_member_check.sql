USE [ocean]
GO
/****** Object:  StoredProcedure [dbo].[ocean_user_member_check]    Script Date: 07/24/2015 18:10:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		SPWEB
-- Create date: 2014-07-29
-- Description:	회원 중복검사
-- =============================================
ALTER PROCEDURE [dbo].[ocean_user_member_check]
	 @actType	varchar(30) = ''
	,@id		varchar(20) = ''
	,@search	varchar(200) = ''
	,@idx		int = -1
AS
BEGIN
	SET NOCOUNT ON;
	
	IF @actType = 'id'
	BEGIN
		SELECT COUNT(*) AS [check] FROM [dbo].[OCEAN_USER_MEMBER] WHERE [UserId] = @search and [UserDelFg] = 0;
	END
	ELSE IF @actType = 'pwd'
	BEGIN
		SELECT
			pwdcompare(@search,[UserPass]) AS [check]
		FROM [dbo].[OCEAN_USER_MEMBER]
		WHERE [UserId] = @id;
	END
	ELSE IF @actType = 'sano'
	BEGIN
		SELECT COUNT(*) AS [check] FROM [dbo].[OCEAN_MEMBERSHIP] WHERE [sano] = @search
		and [State] = 0
		and [idx] != @idx;
	END
END