-- =====================================================================
-- Module 2 : ANSI SQL Using MySQL
-- Community Event Portal - Sample Data
-- =====================================================================
USE event_portal;

-- ---------------------------------------------------------------------
-- 1. Users  (rows 1-5 from the spec, plus a few extras)
-- ---------------------------------------------------------------------
INSERT INTO Users (user_id, full_name, email, city, registration_date) VALUES
    (1, 'Alice Johnson',   'alice@example.com',   'New York',    '2024-12-01'),
    (2, 'Bob Smith',       'bob@example.com',     'Los Angeles', '2024-12-05'),
    (3, 'Charlie Lee',     'charlie@example.com', 'Chicago',     '2024-12-10'),
    (4, 'Diana King',      'diana@example.com',   'New York',    '2025-01-15'),
    (5, 'Ethan Hunt',      'ethan@example.com',   'Los Angeles', '2025-02-01'),
    -- Extra users to make date-based queries meaningful (relative to today, 2026-05-29)
    (6, 'Fiona Carter',    'fiona@example.com',   'New York',    '2026-05-10'),
    (7, 'George Miller',   'george@example.com',  'Chicago',     '2026-05-20'),
    (8, 'Hannah Brooks',   'hannah@example.com',  'Los Angeles', '2026-05-25');

-- ---------------------------------------------------------------------
-- 2. Events  (3 rows from the spec, plus extras)
-- ---------------------------------------------------------------------
INSERT INTO Events (event_id, title, description, city, start_date, end_date, status, organizer_id) VALUES
    (1, 'Tech Innovators Meetup',        'A meetup for tech enthusiasts.',        'New York',    '2025-06-10 10:00:00', '2025-06-10 16:00:00', 'upcoming',  1),
    (2, 'AI & ML Conference',            'Conference on AI and ML advancements.', 'Chicago',     '2025-05-15 09:00:00', '2025-05-15 17:00:00', 'completed', 3),
    (3, 'Frontend Development Bootcamp', 'Hands-on training on frontend tech.',   'Los Angeles', '2025-07-01 10:00:00', '2025-07-03 16:00:00', 'upcoming',  2),
    -- Extra events for richer analytics
    (4, 'Cloud Computing Summit',        'Deep dive into cloud platforms.',       'New York',    '2026-06-20 09:00:00', '2026-06-20 18:00:00', 'upcoming',  1),
    (5, 'Data Science Workshop',         'Practical data science sessions.',      'Chicago',     '2025-03-10 09:00:00', '2025-03-10 17:00:00', 'completed', 3),
    (6, 'Cybersecurity Forum',           'Forum that got cancelled.',             'Los Angeles', '2025-08-05 09:00:00', '2025-08-05 17:00:00', 'cancelled', 2);

-- ---------------------------------------------------------------------
-- 3. Sessions  (4 rows from the spec, plus extras)
-- ---------------------------------------------------------------------
INSERT INTO Sessions (session_id, event_id, title, speaker_name, start_time, end_time) VALUES
    (1, 1, 'Opening Keynote',   'Dr. Tech',      '2025-06-10 10:00:00', '2025-06-10 11:00:00'),
    (2, 1, 'Future of Web Dev', 'Alice Johnson', '2025-06-10 11:15:00', '2025-06-10 12:30:00'),
    (3, 2, 'AI in Healthcare',  'Charlie Lee',   '2025-05-15 09:30:00', '2025-05-15 11:00:00'),
    (4, 3, 'Intro to HTML5',    'Bob Smith',     '2025-07-01 10:00:00', '2025-07-01 12:00:00'),
    -- Extra sessions: overlap test on event 1, multi-session speakers, peak-hour coverage
    (5, 1, 'Overlapping Panel', 'Dr. Tech',      '2025-06-10 10:30:00', '2025-06-10 11:30:00'),
    (6, 3, 'Advanced CSS',      'Bob Smith',     '2025-07-02 10:00:00', '2025-07-02 11:30:00'),
    (7, 2, 'ML Deep Dive',      'Charlie Lee',   '2025-05-15 11:30:00', '2025-05-15 13:00:00');

-- ---------------------------------------------------------------------
-- 4. Registrations  (5 rows from the spec, plus extras)
-- ---------------------------------------------------------------------
INSERT INTO Registrations (registration_id, user_id, event_id, registration_date) VALUES
    (1, 1, 1, '2025-05-01'),
    (2, 2, 1, '2025-05-02'),
    (3, 3, 2, '2025-04-30'),
    (4, 4, 2, '2025-04-28'),
    (5, 5, 3, '2025-06-15'),
    -- Extras: recent registrations (within 90 days of today), a duplicate, more spread
    (6,  6, 4, '2026-05-15'),
    (7,  7, 4, '2026-05-18'),
    (8,  8, 1, '2026-05-22'),
    (9,  1, 4, '2026-05-25'),
    (10, 1, 1, '2025-05-03'),   -- duplicate: user 1 registered for event 1 twice
    (11, 4, 5, '2025-03-01'),
    (12, 3, 5, '2025-03-02');

-- ---------------------------------------------------------------------
-- 5. Feedback  (3 rows from the spec, plus extras)
-- ---------------------------------------------------------------------
INSERT INTO Feedback (feedback_id, user_id, event_id, rating, comments, feedback_date) VALUES
    (1, 3, 2, 4, 'Great insights!',   '2025-05-16'),
    (2, 4, 2, 5, 'Very informative.', '2025-05-16'),
    (3, 2, 1, 3, 'Could be better.',  '2025-06-11'),
    -- Extras: a low rating (<3) for alert query, feedback on completed event 5
    (4, 1, 1, 2, 'Too crowded.',      '2025-06-11'),
    (5, 4, 5, 4, 'Solid workshop.',   '2025-03-11'),
    (6, 3, 5, 5, 'Loved it.',         '2025-03-11'),
    (7, 2, 5, 1, 'Not for me.',       '2025-03-12');

-- ---------------------------------------------------------------------
-- 6. Resources  (3 rows from the spec, plus extras)
-- ---------------------------------------------------------------------
INSERT INTO Resources (resource_id, event_id, resource_type, resource_url, uploaded_at) VALUES
    (1, 1, 'pdf',   'https://portal.com/resources/tech_meetup_agenda.pdf', '2025-05-01 10:00:00'),
    (2, 2, 'image', 'https://portal.com/resources/ai_poster.jpg',          '2025-04-20 09:00:00'),
    (3, 3, 'link',  'https://portal.com/resources/html5_docs',             '2025-06-25 15:00:00'),
    -- Extras to vary the resource summary
    (4, 1, 'image', 'https://portal.com/resources/tech_banner.jpg',        '2025-05-02 11:00:00'),
    (5, 1, 'link',  'https://portal.com/resources/tech_slides',            '2025-05-03 09:00:00'),
    (6, 2, 'pdf',   'https://portal.com/resources/ai_paper.pdf',           '2025-04-21 10:00:00');
