/* 
/*userId 칼럼 길이 변경*/
alter table [OCEAN_USER_MEMBER] alter column [UserId] varchar(320) null

/*userName(first name) 칼럼 길이 변경*/
alter table [OCEAN_USER_MEMBER] alter column [UserName] varchar(100) null

/*맴버 lastName,hphone,phone 칼럼 추가*/
alter table [OCEAN_USER_MEMBER] add [UserNameLast] varchar(100) null
alter table [OCEAN_USER_MEMBER] add [UserHPhone] varchar(200) null
alter table [OCEAN_USER_MEMBER] add [UserPhone] varchar(200) null



/*기업맴버 Country,bigo 칼럼 추가*/
alter table [OCEAN_MEMBERSHIP] add [Country] varchar(100) null
alter table [OCEAN_MEMBERSHIP] add [bigo] TEXT null
alter table [OCEAN_MEMBERSHIP] add [addr] varchar(max) null





/*OCEAN_BOARD 상태 칼럼 추가*/
alter table [OCEAN_BOARD] add [status] INT null

/*OCEAN_BOARD 답글 부모IDX 칼럼 추가*/
alter table [OCEAN_BOARD] add [parent_idx] INT null




/*커뮤니티 키 생성*/
INSERT INTO [keti].[dbo].[OCEAN_BOARD_CODE]([Type],[Name],[UseLv],[State],[Order],[Replylfg],[CommentFg])VALUES('NOTICE','커뮤니티',0,0,30,1,0)


/*기초코드 국가 키, 직원수 생성  -- IDENTITY 주의 */
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE1]([Name],[Order],[Bigo],[UsFg])VALUES('국가',40,'',0)
DECLARE @IDENTITY INT 
SET @IDENTITY = SCOPE_IDENTITY()
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Afghanistan',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Albania',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Algeria',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'American Samoa',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Andorra',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Angola',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Anguilla',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Antarctica',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Antigua and Barbuda',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Argentina',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Armenia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Aruba',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Australia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Austria',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Azerbaijan',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Bahamas',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Bahrain',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Bangladesh',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Barbados',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Belarus',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Belgium',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Belize',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Benin',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Bermuda',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Bhutan',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Bolivia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Bosnia and Herzegovina',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Botswana',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Brazil',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'British Indian Ocean Territory',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'British Virgin Islands',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Brunei',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Bulgaria',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Burkina Faso',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Burundi',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Cambodia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Cameroon',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Canada',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Cape Verde',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Cayman Islands',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Central African Republic',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Chad',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Chile',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'China',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Christmas Island',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Cocos (Keeling) Islands',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Colombia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Comoros',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Congo',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Cook Islands',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Costa Rica',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Croatia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Cuba',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Cura&ccedil;ao',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Cyprus',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Czech Republic',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'C&ocirc;te d&rsquo;Ivoire',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Democratic Republic of the Congo',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Denmark',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Djibouti',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Dominica',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Dominican Republic',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Ecuador',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Egypt',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'El Salvador',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Equatorial Guinea',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Eritrea',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Estonia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Ethiopia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Falkland Islands',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Faroe Islands',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Fiji',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Finland',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'France',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'French Guiana',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'French Polynesia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'French Southern Territories',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Gabon',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Gambia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Georgia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Germany',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Ghana',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Gibraltar',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Greece',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Greenland',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Grenada',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Guadeloupe',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Guam',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Guatemala',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Guernsey',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Guinea',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Guinea-Bissau',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Guyana',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Haiti',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Honduras',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Hong Kong S.A.R., China',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Hungary',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Iceland',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'India',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Indonesia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Iran',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Iraq',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Ireland',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Isle of Man',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Israel',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Italy',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Jamaica',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Japan',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Jersey',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Jordan',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Kazakhstan',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Kenya',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Kiribati',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Kuwait',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Kyrgyzstan',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Laos',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Latvia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Lebanon',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Lesotho',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Liberia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Libya',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Liechtenstein',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Lithuania',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Luxembourg',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Macao S.A.R., China',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Macedonia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Madagascar',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Malawi',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Malaysia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Maldives',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Mali',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Malta',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Marshall Islands',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Martinique',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Mauritania',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Mauritius',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Mayotte',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Mexico',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Micronesia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Moldova',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Monaco',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Mongolia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Montenegro',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Montserrat',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Morocco',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Mozambique',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Myanmar',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Namibia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Nauru',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Nepal',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Netherlands',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'New Caledonia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'New Zealand',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Nicaragua',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Niger',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Nigeria',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Niue',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Norfolk Island',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'North Korea',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Northern Mariana Islands',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Norway',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Oman',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Pakistan',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Palau',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Palestinian Territory',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Panama',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Papua New Guinea',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Paraguay',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Peru',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Philippines',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Pitcairn',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Poland',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Portugal',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Puerto Rico',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Qatar',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Romania',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Russia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Rwanda',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'R&eacute;union',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Saint Barth&eacute;lemy',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Saint Helena',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Saint Kitts and Nevis',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Saint Lucia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Saint Pierre and Miquelon',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Saint Vincent and the Grenadines',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Samoa',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'San Marino',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Sao Tome and Principe',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Saudi Arabia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Senegal',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Serbia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Seychelles',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Sierra Leone',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Singapore',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Slovakia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Slovenia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Solomon Islands',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Somalia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'South Africa',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'South Korea',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'South Sudan',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Spain',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Sri Lanka',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Sudan',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Suriname',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Svalbard and Jan Mayen',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Swaziland',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Sweden',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Switzerland',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Syria',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Taiwan',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Tajikistan',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Tanzania',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Thailand',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Timor-Leste',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Togo',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Tokelau',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Tonga',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Trinidad and Tobago',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Tunisia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Turkey',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Turkmenistan',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Turks and Caicos Islands',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Tuvalu',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'U.S. Virgin Islands',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Uganda',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Ukraine',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'United Arab Emirates',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'United Kingdom',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'United States',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'United States Minor Outlying Islands',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Uruguay',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Uzbekistan',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Vanuatu',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Vatican',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Venezuela',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Viet Nam',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Wallis and Futuna',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Western Sahara',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Yemen',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Zambia',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'Zimbabwe',0,0,'')


INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE1]([Name],[Order],[Bigo],[UsFg])VALUES('직원수',50,'',0)
DECLARE @IDENTITY INT 
SET @IDENTITY = SCOPE_IDENTITY()
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'0~49',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'50~99',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'99~499',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'500~999',0,0,'')
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'1000+',0,0,'')



/* 참고

	OCEAN_MEMBERSHIP_V 체크
	
	OCEAN_BOARD_CONT_L 수정
	OCEAN_BOARD_CONT_V 수정
	OCEAN_BOARD_CONT_P 수정
	OCEAN_BOARD_CONT_MINI_L 수정
	
	OCEAN_USER_MEMBER_P 수정
	OCEAN_USER_MEMBER_L 수정
	OCEAN_USER_MEMBER_LOGIN 수정
	OCEAN_USER_MEMBER_CEO_STATE 수정
	ocean_user_member_search 수정
	ocean_user_member_check 수정
	
	OCEAN_MEMBERSHIP_V 수정
	OCEAN_MEMBERSHIP_L 수정
	
	OCEAN_DOWNLOAD_LOG_L 수정
	
	OCEAN_COMM_CODE2_P 수정
*/

*/