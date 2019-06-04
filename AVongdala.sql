-- Creating store procedure for tblArtist
USE Group8_Spotify 

CREATE PROCEDURE usp_INSERT_ARTIST
@Fname varchar (30),
@Lname varchar(30),
@Bio varchar(1000),
@Pic varchar(500)

AS 

INSERT INTO tblARTIST(artistFName, artistLName, artistBio, artistPic)
VALUES (@Fname, @Lname, @Bio, @Pic)
GO

-- Populating tables with artist --
-- Justin Bieber--
EXECUTE usp_INSERT_ARTIST
 @Fname = 'Justin', 
 @Lname = 'Bieber', 
 @Bio = 'Justin Drew Bieber is a Canadian singer-songwriter. After talent 
		manager Scooter Braun discovered his YouTube videos covering songs, 
		he was signed to RBMG Records in 2008. Bieber then released his debut EP, 
		My World, in late 2009. It was certified Platinum in the United States.',
@Pic = 'http://t1.gstatic.com/images?q=tbn:ANd9GcTKk_JMWMC3exM1jA02NM0Yayfxa1k4rVyWKcd90SKbepitzLs5'
 
 -- Travis Scott -- 
 EXECUTE usp_INSERT_ARTIST
 @Fname = 'Travis',
 @LName = 'Scott',
 @Bio = 'Jacques Berman Webster II, known professionally as Travis Scott, is an American 
		rapper, singer, songwriter and record producer. In 2012, Scott signed his first major-label deal with Epic Records.',
@Pic = 'https://www.ticketnews.com/wp-content/uploads/travis-scott-2-970x350.jpg' 
 
 -- Snoop Dogg -- 
EXECUTE usp_INSERT_ARTIST
@Fname = 'Snoop',
@Lname = 'Dogg',
@Bio = 'Calvin Cordozar Broadus Jr., known professionally as Snoop Dogg, is an American rapper, singer-songwriter, 
		record producer, television personality, entrepreneur, and actor.',
@Pic = 'https://www.romania-insider.com/sites/default/files/styles/article_large_image/public/featured_images/Snoop-Dogg.jpg'

-- Drake --
EXECUTE usp_INSERT_ARTIST
@Fname = 'Drake',
@Lname = 'Graham',
@Bio = 'Aubrey Drake Graham is a Canadian rapper, singer, songwriter, actor, producer, and entrepreneur. 
		Drake gained recognition as an actor on the teen drama television series Degrassi: The Next Generation in the early 2000s.',
@Pic = 'https://static.stereogum.com/uploads/2017/11/Drake-1510152261-640x619.jpg'
		
-- Cardi B --
EXECUTE usp_INSERT_ARTIST
@Fname = 'Cardi',
@Lname = 'B',
@Bio = 'Belcalis Marlenis Almánzar, known professionally as Cardi B, is an American rapper, songwriter and television personality. 
		Born and raised in The Bronx, New York City, she became an Internet celebrity after several of her posts and videos went 
		viral on Vine and Instagram',
@Pic = 'https://www.etonline.com/sites/default/files/styles/max_1280x720/public/images/2019-01/cardi_0.jpg?itok=jG8orFge'



-- Creating store procedure for tblGenre
CREATE PROCEDURE usp_INSERT_GENRE
@GName varchar (100),
@GDescr varchar(500)

AS 

INSERT INTO tblGENRE(genreName, genreDescr)
VALUES (@GName, @GDescr)

-- Populating the table -- 
-- Rock -- 
EXECUTE usp_INSERT_GENRE
@GName = 'Rock',
@GDescr = 'Rock music is a broad genre of popular music that originated as "rock and roll" in the United States in the early 1950s.'

-- Pop --
EXECUTE usp_INSERT_GENRE
@GName = 'Pop',
@GDescr = 'Pop music is a genre of popular music that originated in its modern form in the United States and United Kingdom during the mid-1950s.'

-- Hip Hop --
EXECUTE usp_INSERT_GENRE
@GName = 'Hip Hop',
@GDescr = 'Hip hop music, also called hip-hop or rap music, is a music genre developed in the United States by inner-city African 
		   Americans and Latino Americans in the Bronx borough of New York City in the 1970s.'

-- Reggae --
EXECUTE usp_INSERT_GENRE
@GName = 'Reggae',
@GDescr = 'Reggae is a music genre that originated in Jamaica in the late 1960s. The term also denotes the modern popular music of
           Jamaica and its diaspora. '

-- Soul -- 
EXECUTE usp_INSERT_GENRE
@GName = 'Soul',
@GDescr = 'Soul music is a popular music genre that originated in the African American community in the United States in the 1950s and early 1960s.'


-- Creating store procedure for tblRECORDING
CREATE PROCEDURE usp_INSERT_RECORDING
@GenreName varchar (100),
@SongName varchar(100),
@GroupName varchar(100),
@RatingName varchar(100),
@RecordLength time(7)

AS 

DECLARE @songGroupID INT
DECLARE @genreID INT
DECLARE @recordingRatingID INT

SET @songGroupID = (SELECT SG.songGroupID 
					FROM tblSONG S
					JOIN tblSONG_GROUP SG ON S.songID = SG.songID
					JOIN tblRECORDING R ON SG.songGroupID = R.songGroupID
					WHERE S.songName = @SongName)

SET @genreID = (SELECT G.genreID
				FROM tblGENRE G 
				WHERE G.genreName = @GenreName)
				
SET @recordingRatingID = (SELECT RR.recordingRatingID 
						 FROM tblRECORDING_RATING RR
						 WHERE RR.ratingName = @RatingName)

BEGIN TRAN G1
INSERT INTO tblRECORDING(songGroupID,genreID, recordingRatingID, recordingLength)
VALUES (@songGroupID, @genreID, @recordingRatingID, @RecordLength)
COMMIT TRAN G1


-- Creating store procedure for tblRECORDING_ALBUM --
CREATE PROCEDURE usp_INSERT_RECORDING_ALBUM
@AlbumName varchar (200),
@AlbumDescr varchar(200),
@AlbumDate DATE,
@RecordLength time(7)

AS 

DECLARE @recordingID INT
DECLARE @albumID INT

SET @recordingID = (SELECT R.recordingID 
					FROM tblRECORDING R
					WHERE R.recordingLength = @RecordLength)

SET @albumID = (SELECT A.albumID 
				FROM tblALBUM A
				WHERE A.albumName = @AlbumName
				AND A.albumDescr = @albumDescr
				AND A.albumReleaseDate = @AlbumDate)
				
BEGIN TRAN G1
INSERT INTO tblRECORDING_ALBUM(recordingID, albumID)
VALUES(@recordingID, @albumID)
COMMIT TRAN G1












