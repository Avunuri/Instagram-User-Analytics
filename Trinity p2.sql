-- Trainity Project 2 
-- Instagram User Analysis

use ig_clone;
describe users;
-- A) Marketing:

-- 1. Finding the 5 oldest users of the Instagram from the database.
select * from users;
select username,created_at from users order by created_at limit 5; 

-- 2. Finding the users who have never posted a single photo on Instagram. 
select * from users,photos;
select u.username from users u left join photos p on p.user_id=u.id where p.image_url is null order by u.username;

-- 3. Identify the winner of the content and provide their details to the team. 
select * from users,photos,likes;
select likes.photo_id,users.username, count(likes.user_id) as No_of_likes
from likes inner join photos on likes.photo_id=photos.id
inner join users on photos.user_id=users.id group by likes.photo_id,users.username order by No_of_likes desc ;

-- 4. Identify and suggest the top 5 most commonly used hashtags on the platform. 
select * from photo_tags,tags;
select t.tag_name,count(p.photo_id) as hashtag 
from photo_tags p inner join tags t on t.id=p.tag_id group by t.tag_name order by hashtag desc;

-- 5. What day of the week do most users register on? provide insights on when to schedule an ad campaign. 
select * from users;
select DATE_FORMAT((created_at), '%W') as day,count(username) from users group by 1 order by 2 desc;

-- B) Investor Metrics:

-- 6.  Provide how many times does average user posts on Instagram. 
--     Also, provide the total number of photos on Instagram/total number of users. 
select * from users,photos;
with base as(select u.id as user_id,count(p.id) as photo_id from users u left join photos p on p.user_id=u.id group by u.id)
select sum(photo_id) as total_photos,count(user_id) as total_users,sum(photo_id)/count(user_id) as photo_per_user
from base;

-- 7. Provide data on users (bots) who have liked every single photo on the site (since any normal user would not be able to do this).
select * from users,likes;
with base as(select u.username,count(l.photo_id) as likesss from likes l inner join users u on u.id=l.user_id
group by u.username)
select username,likesss from base where likesss=(select count(*) from photos) order by username;


 




