-- =====================================================================
-- Module 2 : ANSI SQL Using MySQL
-- Community Event Portal - 25 Query Exercises
-- Target: MySQL 8.0+ (window functions allowed)
-- =====================================================================
USE event_portal;

-- ---------------------------------------------------------------------
-- 1. User Upcoming Events
--    Show all upcoming events a user is registered for in their city,
--    sorted by date. (Parameterised here for user_id = 1.)
-- ---------------------------------------------------------------------
SELECT u.user_id, u.full_name, e.event_id, e.title, e.city, e.start_date
FROM Users u
JOIN Registrations r ON r.user_id  = u.user_id
JOIN Events        e ON e.event_id = r.event_id
WHERE u.user_id = 1
  AND e.status  = 'upcoming'
  AND e.city    = u.city
ORDER BY e.start_date;

-- ---------------------------------------------------------------------
-- 2. Top Rated Events
--    Events with the highest average rating, considering only those
--    with at least 10 feedback submissions.
-- ---------------------------------------------------------------------
SELECT e.event_id, e.title,
       AVG(f.rating)  AS avg_rating,
       COUNT(*)       AS feedback_count
FROM Events   e
JOIN Feedback f ON f.event_id = e.event_id
GROUP BY e.event_id, e.title
HAVING COUNT(*) >= 10
ORDER BY avg_rating DESC;

-- ---------------------------------------------------------------------
-- 3. Inactive Users
--    Users who have NOT registered for any event in the last 90 days.
-- ---------------------------------------------------------------------
SELECT u.user_id, u.full_name, u.email
FROM Users u
WHERE u.user_id NOT IN (
    SELECT r.user_id
    FROM Registrations r
    WHERE r.registration_date >= CURDATE() - INTERVAL 90 DAY
);

-- ---------------------------------------------------------------------
-- 4. Peak Session Hours
--    Count sessions scheduled between 10 AM and 12 PM for each event.
-- ---------------------------------------------------------------------
SELECT e.event_id, e.title,
       COUNT(s.session_id) AS sessions_10am_12pm
FROM Events    e
JOIN Sessions  s ON s.event_id = e.event_id
WHERE HOUR(s.start_time) >= 10
  AND HOUR(s.start_time) <  12
GROUP BY e.event_id, e.title
ORDER BY sessions_10am_12pm DESC;

-- ---------------------------------------------------------------------
-- 5. Most Active Cities
--    Top 5 cities by number of distinct user registrations.
-- ---------------------------------------------------------------------
SELECT u.city,
       COUNT(DISTINCT r.user_id) AS distinct_registered_users
FROM Users         u
JOIN Registrations r ON r.user_id = u.user_id
GROUP BY u.city
ORDER BY distinct_registered_users DESC
LIMIT 5;

-- ---------------------------------------------------------------------
-- 6. Event Resource Summary
--    Number of resources (pdf, image, link) uploaded per event.
-- ---------------------------------------------------------------------
SELECT e.event_id, e.title,
       SUM(r.resource_type = 'pdf')   AS pdf_count,
       SUM(r.resource_type = 'image') AS image_count,
       SUM(r.resource_type = 'link')  AS link_count,
       COUNT(r.resource_id)           AS total_resources
FROM Events     e
LEFT JOIN Resources r ON r.event_id = e.event_id
GROUP BY e.event_id, e.title
ORDER BY e.event_id;

-- ---------------------------------------------------------------------
-- 7. Low Feedback Alerts
--    Users who gave feedback with a rating < 3, with their comments
--    and the associated event names.
-- ---------------------------------------------------------------------
SELECT u.user_id, u.full_name, e.title AS event_name,
       f.rating, f.comments, f.feedback_date
FROM Feedback f
JOIN Users    u ON u.user_id  = f.user_id
JOIN Events   e ON e.event_id = f.event_id
WHERE f.rating < 3
ORDER BY f.rating, f.feedback_date;

-- ---------------------------------------------------------------------
-- 8. Sessions per Upcoming Event
--    All upcoming events with the count of sessions scheduled.
-- ---------------------------------------------------------------------
SELECT e.event_id, e.title,
       COUNT(s.session_id) AS session_count
FROM Events    e
LEFT JOIN Sessions s ON s.event_id = e.event_id
WHERE e.status = 'upcoming'
GROUP BY e.event_id, e.title
ORDER BY session_count DESC;

-- ---------------------------------------------------------------------
-- 9. Organizer Event Summary
--    For each organizer, number of events created broken down by status.
-- ---------------------------------------------------------------------
SELECT u.user_id AS organizer_id, u.full_name AS organizer_name,
       COUNT(*)                               AS total_events,
       SUM(e.status = 'upcoming')             AS upcoming_events,
       SUM(e.status = 'completed')            AS completed_events,
       SUM(e.status = 'cancelled')            AS cancelled_events
FROM Events e
JOIN Users  u ON u.user_id = e.organizer_id
GROUP BY u.user_id, u.full_name
ORDER BY total_events DESC;

-- ---------------------------------------------------------------------
-- 10. Feedback Gap
--     Events that had registrations but received no feedback at all.
-- ---------------------------------------------------------------------
SELECT DISTINCT e.event_id, e.title
FROM Events        e
JOIN Registrations r ON r.event_id = e.event_id
WHERE NOT EXISTS (
    SELECT 1 FROM Feedback f WHERE f.event_id = e.event_id
)
ORDER BY e.event_id;

-- ---------------------------------------------------------------------
-- 11. Daily New User Count
--     Number of users who registered each day in the last 7 days.
-- ---------------------------------------------------------------------
SELECT u.registration_date,
       COUNT(*) AS new_users
FROM Users u
WHERE u.registration_date >= CURDATE() - INTERVAL 7 DAY
GROUP BY u.registration_date
ORDER BY u.registration_date;

-- ---------------------------------------------------------------------
-- 12. Event with Maximum Sessions
--     Event(s) with the highest number of sessions.
-- ---------------------------------------------------------------------
SELECT e.event_id, e.title,
       COUNT(s.session_id) AS session_count
FROM Events    e
JOIN Sessions  s ON s.event_id = e.event_id
GROUP BY e.event_id, e.title
HAVING COUNT(s.session_id) = (
    SELECT MAX(cnt) FROM (
        SELECT COUNT(*) AS cnt
        FROM Sessions
        GROUP BY event_id
    ) AS session_counts
)
ORDER BY e.event_id;

-- ---------------------------------------------------------------------
-- 13. Average Rating per City
--     Average feedback rating of events conducted in each city.
-- ---------------------------------------------------------------------
SELECT e.city,
       AVG(f.rating)            AS avg_rating,
       COUNT(f.feedback_id)     AS feedback_count
FROM Events   e
JOIN Feedback f ON f.event_id = e.event_id
GROUP BY e.city
ORDER BY avg_rating DESC;

-- ---------------------------------------------------------------------
-- 14. Most Registered Events
--     Top 3 events by total number of user registrations.
-- ---------------------------------------------------------------------
SELECT e.event_id, e.title,
       COUNT(r.registration_id) AS total_registrations
FROM Events        e
JOIN Registrations r ON r.event_id = e.event_id
GROUP BY e.event_id, e.title
ORDER BY total_registrations DESC
LIMIT 3;

-- ---------------------------------------------------------------------
-- 15. Event Session Time Conflict
--     Overlapping sessions within the same event (start/end conflict).
-- ---------------------------------------------------------------------
SELECT s1.event_id,
       s1.session_id AS session_a, s1.title AS title_a,
       s1.start_time AS start_a,   s1.end_time AS end_a,
       s2.session_id AS session_b, s2.title AS title_b,
       s2.start_time AS start_b,   s2.end_time AS end_b
FROM Sessions s1
JOIN Sessions s2
  ON s1.event_id   = s2.event_id
 AND s1.session_id < s2.session_id           -- avoid self-match & duplicate pairs
 AND s1.start_time < s2.end_time             -- they overlap if A starts before B ends ...
 AND s2.start_time < s1.end_time             -- ... and B starts before A ends
ORDER BY s1.event_id, s1.session_id;

-- ---------------------------------------------------------------------
-- 16. Unregistered Active Users
--     Users who created an account in the last 30 days but have not
--     registered for any events.
-- ---------------------------------------------------------------------
SELECT u.user_id, u.full_name, u.email, u.registration_date
FROM Users u
WHERE u.registration_date >= CURDATE() - INTERVAL 30 DAY
  AND NOT EXISTS (
      SELECT 1 FROM Registrations r WHERE r.user_id = u.user_id
  )
ORDER BY u.registration_date DESC;

-- ---------------------------------------------------------------------
-- 17. Multi-Session Speakers
--     Speakers handling more than one session across all events.
-- ---------------------------------------------------------------------
SELECT s.speaker_name,
       COUNT(*) AS session_count
FROM Sessions s
GROUP BY s.speaker_name
HAVING COUNT(*) > 1
ORDER BY session_count DESC;

-- ---------------------------------------------------------------------
-- 18. Resource Availability Check
--     Events that do not have any resources uploaded.
-- ---------------------------------------------------------------------
SELECT e.event_id, e.title
FROM Events e
WHERE NOT EXISTS (
    SELECT 1 FROM Resources r WHERE r.event_id = e.event_id
)
ORDER BY e.event_id;

-- ---------------------------------------------------------------------
-- 19. Completed Events with Feedback Summary
--     For completed events, total registrations and average rating.
-- ---------------------------------------------------------------------
SELECT e.event_id, e.title,
       (SELECT COUNT(*) FROM Registrations r WHERE r.event_id = e.event_id) AS total_registrations,
       (SELECT AVG(f.rating) FROM Feedback f WHERE f.event_id = e.event_id)  AS avg_rating
FROM Events e
WHERE e.status = 'completed'
ORDER BY e.event_id;

-- ---------------------------------------------------------------------
-- 20. User Engagement Index
--     For each user, number of events attended (registered) and number
--     of feedbacks submitted.
-- ---------------------------------------------------------------------
SELECT u.user_id, u.full_name,
       (SELECT COUNT(*) FROM Registrations r WHERE r.user_id = u.user_id) AS events_registered,
       (SELECT COUNT(*) FROM Feedback      f WHERE f.user_id = u.user_id) AS feedbacks_submitted
FROM Users u
ORDER BY events_registered DESC, feedbacks_submitted DESC;

-- ---------------------------------------------------------------------
-- 21. Top Feedback Providers
--     Top 5 users who submitted the most feedback entries.
-- ---------------------------------------------------------------------
SELECT u.user_id, u.full_name,
       COUNT(f.feedback_id) AS feedback_count
FROM Users    u
JOIN Feedback f ON f.user_id = u.user_id
GROUP BY u.user_id, u.full_name
ORDER BY feedback_count DESC
LIMIT 5;

-- ---------------------------------------------------------------------
-- 22. Duplicate Registrations Check
--     Detect users registered more than once for the same event.
-- ---------------------------------------------------------------------
SELECT r.user_id, r.event_id,
       COUNT(*) AS registration_count
FROM Registrations r
GROUP BY r.user_id, r.event_id
HAVING COUNT(*) > 1
ORDER BY registration_count DESC;

-- ---------------------------------------------------------------------
-- 23. Registration Trends
--     Month-wise registration count over the past 12 months.
-- ---------------------------------------------------------------------
SELECT DATE_FORMAT(r.registration_date, '%Y-%m') AS registration_month,
       COUNT(*) AS registration_count
FROM Registrations r
WHERE r.registration_date >= CURDATE() - INTERVAL 12 MONTH
GROUP BY DATE_FORMAT(r.registration_date, '%Y-%m')
ORDER BY registration_month;

-- ---------------------------------------------------------------------
-- 24. Average Session Duration per Event
--     Average duration (in minutes) of sessions in each event.
-- ---------------------------------------------------------------------
SELECT e.event_id, e.title,
       AVG(TIMESTAMPDIFF(MINUTE, s.start_time, s.end_time)) AS avg_duration_minutes
FROM Events    e
JOIN Sessions  s ON s.event_id = e.event_id
GROUP BY e.event_id, e.title
ORDER BY avg_duration_minutes DESC;

-- ---------------------------------------------------------------------
-- 25. Events Without Sessions
--     Events that currently have no sessions scheduled.
-- ---------------------------------------------------------------------
SELECT e.event_id, e.title
FROM Events e
WHERE NOT EXISTS (
    SELECT 1 FROM Sessions s WHERE s.event_id = e.event_id
)
ORDER BY e.event_id;
