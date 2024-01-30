-- Create the Twitter_DB database
create database Twitter_DB;

-- Use the Twitter_DB database
use Twitter_DB;

-- create User table
CREATE TABLE users(
    id INT PRIMARY KEY,
    user_name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(15),
    created_at timestamp
);

-- create Tweet table
CREATE TABLE Tweet (
    tweet_id INT PRIMARY KEY,
    comment_id INT,
    user_id INT,
    content TEXT,
    parent_tweet_id INT,
    commented_content TEXT,
    twitted_at timestamp,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (parent_tweet_id) REFERENCES Tweet(tweet_id)
);

-- Create retweet table
CREATE TABLE Retweet (
    retweet_id INT PRIMARY KEY,
    parent_tweet_id INT,
    user_id INT,
    retweeted_at timestamp,
    FOREIGN KEY (parent_tweet_id) REFERENCES Tweet(tweet_id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Like table containing data for liking tweets, comments( which are treated as tweet )
CREATE TABLE Likes (
    like_id INT PRIMARY KEY,
    tweet_id INT,
    retweet_id INT,
    user_id INT,
    FOREIGN KEY (tweet_id) REFERENCES Tweet(tweet_id),
    FOREIGN KEY (retweet_id) REFERENCES Retweet(retweet_id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Follow table for storing who followed whom
CREATE TABLE Follow (
    follow_id INT PRIMARY KEY,
    follower_id INT,
    followed_id INT,
    FOREIGN KEY (follower_id) REFERENCES users(id),
    FOREIGN KEY (followed_id) REFERENCES users(id)
);

-- Inserting records into user table
INSERT INTO
    users (id, user_name, email, phone_number, created_at)
VALUES
    (
        1,
        'Prince Kumar',
        'Prince@example.com',
        '123-456-7890',
        '2024-01-28 12:00:00'
    ),
    (
        2,
        'Tejus Kumar',
        'dinesh@example.com',
        '987-654-3210',
        '2024-01-28 12:15:00'
    ),
    (
        3,
        'Purushottam Kashyap',
        'purushottam@example.com',
        '555-123-4567',
        '2024-01-28 12:30:00'
    ),
    (
        4,
        'Abhishek Kumar',
        'abhishek@example.com',
        '888-999-0000',
        '2024-01-28 12:45:00'
    );

-- Each tweet, whether an original post or a comment, is treated uniformly.
-- For original tweets, the comment_id is set to NULL. For comments, a separate
-- comment_id is generated along with the tweet_id, maintaining consistency in the database.
-- Inserting tweets (including comments treated as tweets)
INSERT INTO
    Tweet (
        tweet_id,
        comment_id,
        user_id,
        content,
        parent_tweet_id,
        commented_content,
        twitted_at
    )
VALUES
    (
        1,
        NULL,
        1,
        'First tweet by User 1',
        NULL,
        NULL,
        '2024-01-28 12:00:00'
    ),
    (
        2,
        NULL,
        2,
        'Hello Twitter! User 2 here.',
        NULL,
        NULL,
        '2024-01-28 12:15:00'
    ),
    (
        3,
        NULL,
        3,
        'Tweet from User 3. Exciting times!',
        NULL,
        NULL,
        '2024-01-28 12:30:00'
    ),
    (
        4,
        NULL,
        4,
        'Another original tweet by User 4',
        NULL,
        NULL,
        '2024-01-28 12:45:00'
    ),
    -- Commenting on tweets (treated as tweets)
    (
        5,
        1,
        2,
        NULL,
        1,
        'Replying to User 1\'s tweet. Nice!',
        '2024-01-28 13:00:00'
    ),
    (
        6,
        2,
        3,
        NULL,
        2,
        'Replying to User 2\'s tweet. Hello!',
        '2024-01-28 13:15:00'
    ),
    (
        7,
        5,
        4,
        NULL,
        1,
        'Replying to User 1\'s tweet. Excellent!',
        '2024-01-28 13:30:00'
    ),
    (
        8,
        6,
        1,
        NULL,
        2,
        'Replying to User 2\'s tweet. Noice!',
        '2024-01-28 13:45:00'
    );

-- Retweet table
INSERT INTO
    Retweet (
        retweet_id,
        parent_tweet_id,
        user_id,
        retweeted_at
    )
VALUES
    (1, 1, 3, '2024-01-28 15:00:00'),
    -- User 3 retweets Tweet 1
    (2, 2, 4, '2024-01-28 15:30:00');

-- User 4 retweets Tweet 2
-- Like table for liking tweet, comment (treated as tweet) and retweet also
INSERT INTO
    Likes (like_id, tweet_id, retweet_id, user_id)
VALUES
    (1, 1, NULL, 2),
    -- User 2 likes Tweet 1
    (2, NULL, 1, 3),
    -- User 3 likes Retweet 1
    (3, 2, NULL, 4),
    -- User 4 likes Tweet 2
    (4, 5, NULL, 1);

-- User 1 likes Tweet 5
-- Follow table
INSERT INTO
    Follow (follow_id, follower_id, followed_id)
VALUES
    (1, 1, 2),
    -- User 1 follows User 2
    (2, 2, 3),
    -- User 2 follows User 3
    (3, 3, 4);
    -- User 3 follows User 4




-------------------------------------------- SOLUTION of Assignment 3  --------------------------------------


-- Query_1: fetch all user name from database
select
    user_name
from
    users;


-- Query_2: Fetch all tweets of user by user id most recent tweets first.
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



-- Query_3: Fetch like count of particular tweet by tweet_id.
select
    count(*) as LikeCount
from
    Likes
where
    tweet_id = 2;



-- Query_4: fetch retweet count of particular tweet by tweet_id;
select
    count(*) as RetweetCount
from
    Retweet
where
    parent_tweet_id = 2;



-- Query_5: Fetch comment count of particular tweet by tweet_id.
SELECT
    COUNT(*) AS CommentCount
FROM
    Tweet
WHERE
    parent_tweet_id = 1;



-- Query_6: fetch all user's name who have retweeted particular tweet by tweet_id.
select
    users.user_name
from
    Retweet
    JOIN users on Retweet.user_id = users.id
where
    Retweet.parent_tweet_id = 2;



-- Query_7 :Fetch all commented tweet's content for a particular tweet by tweet id.
SELECT
    CommentedTweet.content
FROMx
    Tweet AS CommentedTweet
    JOIN Tweet AS Comment ON CommentedTweet.tweet_id = Comment.parent_tweet_id
WHERE
    Comment.parent_tweet_id = 2;



-- Query_8 :fetch user's timeline (All tweets from users whom I am following with content and user name who have tweeted it)
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
