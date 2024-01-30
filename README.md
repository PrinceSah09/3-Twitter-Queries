# Assignment-3-Twitter-Queries

## Answers of Assignment
 **1. Fetch all users name from database.**
```sql
 select
    user_name
from
    users;
```

 **2. Fetch all tweets of user by user id most recent tweets first.**
```sql
select
    Tweet.content,
    users.user_name,
    Tweet.twitted_at
from
    Tweet
    Join users on Tweet.user_id = users.id
where
    Tweet.user_id = 3
order by
    Tweet.twitted_at DESC; 
```

 3. Fetch like count of particular tweet by tweet id.
```sql
select
    count(*) as LikeCount
from
    Likes
where
    tweet_id = 2;
```

 **4. Fetch retweet count of particular tweet by tweet id.**
```sql
select
    count(*) as RetweetCount
from
    Retweet
where
    parent_tweet_id = 2;
```

 **5. Fetch comment count of particular tweet by tweet id.**
```sql
SELECT
    COUNT(*) AS CommentCount
FROM
    Tweet
WHERE
    parent_tweet_id = 1;
```

 **6. Fetch all users' names who have retweeted a particular tweet by tweet id.**
```sql
select
    users.user_name
from
    Retweet
    JOIN users on Retweet.user_id = users.id
where
    Retweet.parent_tweet_id = 2;
```
 **7. Fetch all commented tweet’s content for particular tweet by tweet id.**
```sql
SELECT
    CommentedTweet.content
FROMx
    Tweet AS CommentedTweet
    JOIN Tweet AS Comment ON CommentedTweet.tweet_id = Comment.parent_tweet_id
WHERE
    Comment.parent_tweet_id = 2
```

 **8. Fetch user’s timeline (All tweets from users whom I am following with tweet content and user name who has tweeted it)**
```sql
SELECT U.name, T.tweetContent FROM tweets T
JOIN users U ON T.userId = U.id
JOIN user_followers UF ON UF.followingId = T.userId
WHERE UF.followerId = 2
ORDER BY T.created_at DESC;
```
#
