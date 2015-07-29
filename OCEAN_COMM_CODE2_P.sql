USE [keti]
GO
/****** Object:  StoredProcedure [dbo].[OCEAN_COMM_CODE2_P]    Script Date: 07/29/2015 22:39:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: SPWEB
-- Create date: 2012-09-14
-- Description:	기초코드1 읽기/쓰기
-- =============================================
ALTER PROCEDURE [dbo].[OCEAN_COMM_CODE2_P]
	 @actType	VARCHAR(10)	= ''
	,@Ord		int			= 0
	,@Idx		varchar(max)= ''
	,@PIdx		int			= 0
	,@UsFg		int			= 0
	,@Name		VARCHAR(50)	= ''
	,@Bigo		TEXT		= ''
AS
BEGIN
	SET NOCOUNT ON;
	IF @actType = 'VIEW'
		BEGIN
		SELECT 
			 [Idx]
			,[PIdx]
			,[Name]
			,[Order]
			,[Bigo]
			,[UsFg]
		FROM [dbo].[OCEAN_COMM_CODE2]
		WHERE [PIdx] = @PIdx
		AND CASE @Idx
		WHEN '' THEN ''
		ELSE [Idx]
		END = @Idx
		
		ORDER BY [Order] ASC,[Idx] ASC
	END
	ELSE IF @actType = 'INSERT'
		BEGIN
		INSERT INTO [dbo].[OCEAN_COMM_CODE2](
			 [PIdx]
			,[Name]
			,[Order]
			,[UsFg]
			,[Bigo]
		)VALUES(
			 @Idx
			,@Name
			,@Ord
			,@UsFg
			,@Bigo
		)
	END
	ELSE IF @actType = 'UPDATE'
		BEGIN
		UPDATE [dbo].[OCEAN_COMM_CODE2] SET
			 [Name]		= @Name
			,[Order]	= @Ord
			,[UsFg]		= @UsFg
			,[Bigo]		= @Bigo
		WHERE Idx = @Idx
	END
	ELSE IF @actType = 'DELETE'
		BEGIN
		
		DECLARE @S VARCHAR (max)
		DECLARE @T TABLE(T_INT INT)

		SET @S=@idx+','

		WHILE CHARINDEX(',',@S)<>0
			BEGIN

			--한문자씩 뽑아낸다-->임시테이블에 입력한다.
			INSERT INTO @T(T_INT) VALUES( SUBSTRING(@S,1,CHARINDEX(',',@S)-1) )
			--빼낸 문자는 뺀 나머지를 새롭게 저장한다.
			SET @S=SUBSTRING(@S,CHARINDEX(',',@S)+1,LEN(@S)) 
			
			IF CHARINDEX(',',@S)=0
			BEGIN
			INSERT INTO @T(T_INT) VALUES( SUBSTRING(@S,1,LEN(@S)) )
			END

		END
		
		DELETE [dbo].[OCEAN_COMM_CODE2] WHERE [Idx] in(SELECT T_INT FROM @T)
	END
	   
END

