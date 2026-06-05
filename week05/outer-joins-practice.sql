USE v_art;

-- INNER JOIN: returns only rows where the artist has matching artwork (matching artist_id in both tables)
SELECT fname, lname, title
FROM artist
    INNER JOIN artwork
    ON artist.artist_id = artwork.artist_id;
    
-- LEFT JOIN: returns all artists and matching artwork when available; title will be NULL if an artist has no artwork
SELECT fname, lname, title
FROM artist
    LEFT JOIN artwork
    ON artist.artist_id = artwork.artist_id;

-- RIGHT JOIN: returns all artists (because artist is on the right) and matching artwork when available;
-- this demonstrates the same matching as the LEFT JOIN above but with reversed table order
SELECT fname, lname, title
FROM artwork
    RIGHT JOIN artist
    ON artist.artist_id = artwork.artist_id;

USE magazine;

SELECT * FROM magazine;
SELECT * FROM subscriber;
SELECT * FROM subscription;


-- Quick look at tables to see raw data
SELECT * FROM magazine;
SELECT * FROM subscriber;
SELECT * FROM subscription;

-- INNER JOIN (alias `JOIN`): returns rows where a subscription exists for a magazine
SELECT magazineName, magazinePrice, subscriptionStartDate
FROM magazine m
    JOIN subscription s
    ON m.magazineKey = s.magazineKey;

-- LEFT JOIN: returns all magazines and matching subscriptions; NULLs for magazines without subscriptions
SELECT magazineName, magazinePrice, subscriptionStartDate
FROM magazine m
    LEFT JOIN subscription s
    ON m.magazineKey = s.magazineKey;

-- LEFT JOIN chain: include subscriber info when a subscription exists; subscriberLastName will be NULL for missing subscribers
SELECT magazineName, magazinePrice, subscriptionStartDate, subscriberLastName
FROM magazine m
    LEFT JOIN subscription s
    ON m.magazineKey = s.magazineKey
    LEFT JOIN subscriber sr
    ON s.subscriberKey = sr.subscriberKey;

-- RIGHT JOIN chain: include all subscriptions and their subscribers, even if the magazine record is missing
SELECT magazineName, magazinePrice, subscriptionStartDate, subscriberLastName
FROM magazine m
    RIGHT JOIN subscription s
    ON m.magazineKey = s.magazineKey
    RIGHT JOIN subscriber sr
    ON s.subscriberKey = sr.subscriberKey;

-- UNION of RIGHT JOIN and LEFT JOIN chains: demonstrates how to approximate a FULL OUTER JOIN
SELECT magazineName, magazinePrice, subscriptionStartDate, subscriberLastName
FROM magazine m
    RIGHT JOIN subscription s
    ON m.magazineKey = s.magazineKey
    RIGHT JOIN subscriber sr
    ON s.subscriberKey = sr.subscriberKey
UNION
SELECT magazineName, magazinePrice, subscriptionStartDate, subscriberLastName
FROM magazine m
    LEFT JOIN subscription s
    ON m.magazineKey = s.magazineKey
    LEFT JOIN subscriber sr
    ON s.subscriberKey = sr.subscriberKey;