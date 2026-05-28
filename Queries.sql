-- =========================================
-- BASIC RETRIEVAL AND FILTERING
-- =========================================

-- List all active students
SELECT student_id, full_name, email, batch_id, admission_date
FROM students
WHERE enrollment_status = 'Active';

-- Find students with missing or invalid emails
SELECT student_id, full_name, email
FROM students
WHERE email IS NULL
   OR email NOT LIKE '%@%.%';

-- List Easy and Medium problems
SELECT problem_id, title, difficulty
FROM problems
WHERE difficulty IN ('Easy', 'Medium');

-- Latest 20 submissions
SELECT *
FROM submissions
ORDER BY submitted_at DESC
LIMIT 20;

-- Failed or unsuccessful submissions
SELECT submission_id, student_id, status
FROM submissions
WHERE status <> 'Accepted';

-- =========================================
-- JOINS
-- =========================================

-- Submission details with student and problem info
SELECT
    s.submission_id,
    st.full_name,
    p.title,
    s.language,
    s.status,
    s.score,
    s.submitted_at
FROM submissions s
JOIN students st
    ON s.student_id = st.student_id
JOIN problems p
    ON s.problem_id = p.problem_id;

-- All students and enrollments
SELECT
    st.student_id,
    st.full_name,
    e.course_id,
    e.enrollment_status
FROM students st
LEFT JOIN enrollments e
    ON st.student_id = e.student_id;

-- Courses with enrolled student counts
SELECT
    c.course_id,
    c.course_title,
    COUNT(e.student_id) AS total_students
FROM courses c
LEFT JOIN enrollments e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_title;

-- Test case results with student and problem
SELECT
    tr.result_id,
    st.full_name,
    p.title,
    tr.result_status,
    tr.awarded_points
FROM test_results tr
JOIN submissions s
    ON tr.submission_id = s.submission_id
JOIN students st
    ON s.student_id = st.student_id
JOIN problems p
    ON s.problem_id = p.problem_id;

-- Students enrolled but never submitted
SELECT DISTINCT
    st.student_id,
    st.full_name
FROM students st
JOIN enrollments e
    ON st.student_id = e.student_id
LEFT JOIN submissions s
    ON st.student_id = s.student_id
WHERE s.submission_id IS NULL;

-- =========================================
-- AGGREGATION AND HAVING
-- =========================================

-- Count submissions by status
SELECT status, COUNT(*) AS total_submissions
FROM submissions
GROUP BY status;

-- Average score per problem
SELECT
    problem_id,
    AVG(score) AS average_score
FROM submissions
GROUP BY problem_id;

-- Students with more than 10 submissions
SELECT
    student_id,
    COUNT(*) AS submission_count
FROM submissions
GROUP BY student_id
HAVING COUNT(*) > 10;

-- Problems with success rate below 40%
SELECT
    problem_id,
    AVG(
        CASE
            WHEN status = 'Accepted' THEN 1.0
            ELSE 0
        END
    ) * 100 AS success_rate
FROM submissions
GROUP BY problem_id
HAVING success_rate < 40;

-- Top 10 most attempted problems
SELECT
    problem_id,
    COUNT(*) AS attempts
FROM submissions
GROUP BY problem_id
ORDER BY attempts DESC
LIMIT 10;

-- =========================================
-- SUBQUERIES
-- =========================================

-- Students scoring above overall average
SELECT
    student_id,
    AVG(score) AS avg_score
FROM submissions
GROUP BY student_id
HAVING AVG(score) >
(
    SELECT AVG(score)
    FROM submissions
);

-- Problems never attempted
SELECT
    problem_id,
    title
FROM problems
WHERE problem_id NOT IN
(
    SELECT DISTINCT problem_id
    FROM submissions
);

-- Students enrolled but never submitted
SELECT
    student_id,
    full_name
FROM students
WHERE student_id NOT IN
(
    SELECT DISTINCT student_id
    FROM submissions
);

-- Students who used both Python and Java
SELECT student_id
FROM submissions
WHERE language = 'Python'
INTERSECT
SELECT student_id
FROM submissions
WHERE language = 'Java';

-- Second highest score for a problem
SELECT DISTINCT score
FROM submissions
WHERE problem_id = 1
ORDER BY score DESC
LIMIT 1 OFFSET 1;