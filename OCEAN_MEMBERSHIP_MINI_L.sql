USE [keti]
GO
/****** Object:  StoredProcedure [dbo].[OCEAN_MEMBERSHIP_MINI_L]    Script Date: 08/03/2015 20:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author: SPWEB
-- Create date: 2014-12-17
-- Description:	기업회원 리스트 미니
-- =============================================
ALTER PROCEDURE [dbo].[OCEAN_MEMBERSHIP_MINI_L]
	@CHECK int = 0
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		 A.[idx]
		,A.[cName]
		,A.[files2]
		,B.[cnt]
	FROM [dbo].[OCEAN_MEMBERSHIP] A
	LEFT JOIN (
		select 
			 count(*) AS [cnt]
			,[companyIdx]
		FROM [dbo].[OCEAN_USER_MEMBER]
		where [UserDelFg] = 0
		and [state] = 0
		and [ceo] = 1
		group by [companyIdx]
	) B
	ON(A.[idx] = B.[companyIdx])
	where A.[State] = 0
	and CASE @CHECK WHEN 0 THEN '' ELSE B.[cnt] END IS NOT NULL
	order by A.[order] asc,A.[cName] asc,A.[idx] desc

END
