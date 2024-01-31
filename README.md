# Assignment-3-Twitter-Queries

## Note: All data are stored inside the repo file (Twitter_Querry.sql) 
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
FROM
    Tweet AS CommentedTweet
    JOIN Tweet AS Comment ON CommentedTweet.tweet_id = Comment.parent_tweet_id
WHERE
    Comment.parent_tweet_id = 2
```

 **8. Fetch user’s timeline (All tweets from users whom I am following with tweet content and user name who has tweeted it)**
```sql
SELECT
    Tweet.content,
    users.user_name AS UserName
FROM
    Tweet
    JOIN users ON Tweet.user_id = users.id
WHERE
    Tweet.user_id IN (
        SELECT
            followed_id
        FROM
            Follow
        WHERE
            follower_id = 1
    )
ORDER BY
    Tweet.twitted_at DESC;
```

