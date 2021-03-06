USE [ocean]
GO
/****** Object:  Table [dbo].[OCEAN_BANNER]    Script Date: 08/27/2015 18:38:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OCEAN_BANNER](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[position] [int] NULL,
	[name] [varchar](200) NULL,
	[image] [varchar](200) NULL,
	[link] [varchar](max) NULL,
	[target] [int] NULL,
	[order] [int] NULL,
	[is_use] [int] NULL,
	[created] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[OCEAN_BANNER_V]    Script Date: 08/27/2015 18:38:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: SPWEB
-- Create date: 2015-08-27
-- Description:	베너 상세
-- =============================================
CREATE PROCEDURE [dbo].[OCEAN_BANNER_V]
	@idx INT = 0
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
		 [idx]
		,[position]
		,[name]
		,[image]
		,[link]
		,[target]
		,[order]
		,[is_use]
		,[created]
	FROM [dbo].[OCEAN_BANNER]
	WHERE [idx] = @idx;

END
GO
/****** Object:  StoredProcedure [dbo].[OCEAN_BANNER_P]    Script Date: 08/27/2015 18:38:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: SPWEB
-- Create date: 2015-08-27
-- Description:	베너 등록/수정/삭제
-- =============================================
CREATE PROCEDURE [dbo].[OCEAN_BANNER_P]
	 @actType	varchar(20)		= ''
	,@idx		varchar(MAX)	= ''
	,@position	INT				= 0
	,@name		varchar(200)	= ''
	,@image		varchar(200)	= ''
	,@link		varchar(MAX)	= ''
	,@target	INT				= 0
	,@order		INT				= 100
	,@is_use	INT				= 0
AS
BEGIN
	SET NOCOUNT ON;

    IF @actType = 'INSERT'
	BEGIN

		INSERT INTO [dbo].[OCEAN_BANNER](
			 [position]
			,[name]
			,[image]
			,[link]
			,[target]
			,[order]
			,[is_use]
			,[created]
		)VALUES(
			 @position
			,@name
			,@image
			,@link
			,@target
			,@order
			,@is_use
			,GETDATE()
		)

	END
	ELSE IF @actType = 'UPDATE'
	BEGIN
		
		UPDATE [dbo].[OCEAN_BANNER] SET
			 [position]	= @position
			,[name]		= @name
			,[image]	= @image
			,[link]		= @link
			,[target]	= @target
			,[order]	= @order
			,[is_use]	= @is_use
		WHERE [idx] = @idx

	END
	ELSE IF @actType = 'DELETE'
	BEGIN
		DECLARE @S VARCHAR (max)
		DECLARE @T TABLE(T_INT INT)

		SET @S = @idx

		WHILE CHARINDEX(',',@S)<>0
			BEGIN
			INSERT INTO @T(T_INT) VALUES( SUBSTRING(@S,1,CHARINDEX(',',@S)-1) )
			SET @S=SUBSTRING(@S,CHARINDEX(',',@S)+1,LEN(@S))
		END
		
		IF CHARINDEX(',',@S) = 0
			BEGIN
			INSERT INTO @T(T_INT) VALUES( SUBSTRING(@S,1,LEN(@S)) )
		END
	
		DELETE FROM [dbo].[OCEAN_BANNER] WHERE [idx] in(SELECT T_INT FROM @T)

	END
END
GO
/****** Object:  StoredProcedure [dbo].[OCEAN_BANNER_L]    Script Date: 08/27/2015 18:38:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: SPWEB
-- Create date: 2015-08-27
-- Description:	베너 리스트
-- =============================================
CREATE PROCEDURE [dbo].[OCEAN_BANNER_L]
	 @pageNo	int				= 1 
	,@rows		int				= 10
	,@Indate	VARCHAR(10)		= ''
	,@Outdate	VARCHAR(10)		= ''
	,@name		VARCHAR(200)	= ''
	,@position	VARCHAR(10)		= ''
	,@is_use	VARCHAR(10)		= ''
AS
BEGIN
	SET NOCOUNT ON;

    WITH LIST AS
	(
		SELECT row_number() over ( order by [order] desc, [idx] asc ) as [rownum]
			, count(*) over () as [tcount]
			,[idx]
			,[position]
			,[name]
			,[image]
			,[link]
			,[target]
			,[order]
			,[is_use]
			,CONVERT(varchar,[created],23) as [created]
		FROM [dbo].[OCEAN_BANNER]
		WHERE CASE @name   WHEN '' THEN '' ELSE [name] END LIKE '%'+@name+'%'
		AND CASE @position WHEN '' THEN '' ELSE [position] END = @position
		AND CASE @is_use   WHEN '' THEN '' ELSE [is_use] END = @is_use
		AND CASE @Indate   WHEN '' THEN '' ELSE CONVERT(VARCHAR,[created],23) END >= @Indate
		AND CASE @Outdate  WHEN '' THEN '' ELSE CONVERT(VARCHAR,[created],23) END <= @Outdate
	)
	SELECT L.*
	FROM LIST L
	WHERE (tcount-rownum+1) BETWEEN dbo.fnc_row_fr(@pageNo,@rows,tcount) AND dbo.fnc_row_to(@pageNo,@rows,tcount)
	ORDER BY rownum desc
END
GO
/****** Object:  Default [DF_OCEAN_BANNER_order]    Script Date: 08/27/2015 18:38:59 ******/
ALTER TABLE [dbo].[OCEAN_BANNER] ADD  CONSTRAINT [DF_OCEAN_BANNER_order]  DEFAULT ((0)) FOR [order]
GO
/****** Object:  Default [DF_OCEAN_BANNER_is_use]    Script Date: 08/27/2015 18:38:59 ******/
ALTER TABLE [dbo].[OCEAN_BANNER] ADD  CONSTRAINT [DF_OCEAN_BANNER_is_use]  DEFAULT ((0)) FOR [is_use]
GO
