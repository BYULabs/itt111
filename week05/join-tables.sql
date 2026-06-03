-- ============================================================================
-- DATABASE: art_gallery
-- ============================================================================
USE art_gallery;

-- Preview all rows and columns from the artist table to check available records
SELECT * FROM artist;

-- Preview all rows and columns from the artwork table to check available records
SELECT * FROM artwork;

-- Two-Table INNER JOIN with a filter: 
-- Retrieves specific artwork details, matched strictly to their artist, 
-- and filters the results to only show pieces where the artist's first name is "Leonardo".
SELECT artfile, title, artyear, period, arttype, artlocation
FROM artist JOIN artwork
ON artist.artist_id = artwork.artist_id
WHERE fname = "Leonardo";

-- LEFT OUTER JOIN: 
-- This returns ALL artists from the left table (artist), even if they don't have 
-- any artworks listed in the artwork table. If an artist has no artwork, 
-- the 'title' and 'artlocation' columns will simply show NULL.
SELECT fname, lname, title, artlocation
FROM artist LEFT JOIN artwork
ON artist.artist_id = artwork.artist_id;

-- INNER JOIN (Default): 
-- Unlike the LEFT JOIN above, this will ONLY return artists who have a matching 
-- artwork in the artwork table. Artists without artworks are completely excluded.
SELECT fname, lname, title, artlocation
FROM artist JOIN artwork
ON artist.artist_id = artwork.artist_id;

-- LEFT OUTER JOIN (Duplicate query):
-- Repeats the Left Join logic to show all artists regardless of whether 
-- they have an associated artwork tracking record or not.
SELECT fname, lname, title, artlocation
FROM artist LEFT JOIN artwork
ON artist.artist_id = artwork.artist_id;