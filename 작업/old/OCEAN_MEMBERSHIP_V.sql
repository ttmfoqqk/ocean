USE [ocean]
GO
/****** Object:  StoredProcedure [dbo].[OCEAN_MEMBERSHIP_V]    Script Date: 08/04/2015 14:00:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		SPWEB
-- Create date: 2014-12-15
-- Description:	기업회원 정보보기
-- =============================================
ALTER PROCEDURE [dbo].[OCEAN_MEMBERSHIP_V]
	 @idx	int			= 0
	,@State	VARCHAR(10)	= ''
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT
		 [idx]
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
		,[inDate]
		,[addr]
		,[Country]
		,[bigo]
		,ISNULL([order],0) AS [order]
	FROM [dbo].[OCEAN_MEMBERSHIP]
	WHERE [idx] = @idx
	AND CASE @State WHEN '' THEN '' ELSE [State] END = @State
	
END
