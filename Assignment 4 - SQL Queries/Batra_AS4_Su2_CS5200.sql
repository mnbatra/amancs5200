/*.Tried to use both equijoins and LEFT Joins Deleted all new line characters to enable rapid copy-paste */
/* Queried table playlist to get playlist id of Brazilian music and Grunge 
Queried table media_Types to get the ids of MPEG formats
Used key ids instead of substring to avoid any mismatches */
/* QUERY 1 */

SELECT DISTINCT LastName as "Customer LastName", Email as "Customer Email" FROM customers,invoices WHERE customers.CustomerId = invoices.CustomerId;

/* QUERY 2 */

SELECT albums.Title as "Album Name", artists.Name as "Artist Name" FROM albums,artists WHERE albums.ArtistId=artists.ArtistId;

/* QUERY 3 */
SELECT State, count(DISTINCT customers.customerId) as "Total Customers" FROM customers WHERE State IS NOT NULL GROUP by State ORDER By State;

/* QUERY 4 */

SELECT DISTINCT State as "States With 10+ Customers" FROM customers WHERE STATE IS NOT NULL GROUP by STATE HAVING count(Distinct CustomerId) >10;

/* QUERY TEST FOR MORE THAN TWO CUSTOMERS
SELECT DISTINCT State FROM customers 
WHERE STATE IS NOT NULL GROUP by STATE 
HAVING count(Distinct CustomerId) >2;*/

/* QUERY 5 */

SELECT DISTINCT artists.Name as "Artist with album name containing: Symphony" from artists,albums WHERE artists.ArtistId=albums.ArtistId AND albums.Title like "%symphony%";

/* QUERY 6 */

SELECT DISTINCT artists.name as "Artists who played MPEG in Grunge & Brazilian Music" FROM artists, albums, tracks, playlists, playlist_track WHERE artists.ArtistId=albums.ArtistId AND albums.AlbumId=tracks.AlbumId AND tracks.TrackId=playlist_track.TrackId AND playlists.PlaylistId=playlist_track.PlaylistId AND playlists.PlaylistId IN (11,16) AND tracks.MediaTypeId IN (1,3) ORDER by artists.Name;

/* QUERY 7 */

SELECT Count(*) as "Artists with 10MPEG Tracks" FROM(SELECT DISTINCT artists.Name FROM tracks LEFT JOIN albums on tracks.AlbumId = albums.AlbumId LEFT JOIN artists on albums.ArtistId = artists.ArtistId WHERE tracks.MediaTypeId in (1,3) GROUP BY artists.ArtistId HAVING COUNT(tracks.TrackId)>=10);
/* QUERY 8 */

SELECT playlists.PlaylistId as "Playlist ID", playlists.Name as "Playlist Name", ROUND(sum(tracks.Milliseconds)/3600000.00,2) AS PlayTime FROM playlist_track LEFT JOIN tracks on playlist_track.TrackId=tracks.TrackId LEFT JOIN playlists ON playlist_track.PlaylistId=playlists.PlaylistId GROUP by playlist_track.PlaylistId HAVING PlayTime>=2;