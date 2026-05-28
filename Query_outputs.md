# Query Outputs and Validation Notes

# 1. Active Students Query

Purpose:
Retrieve all active students.

Expected Output:
Displays student ID, name, email, batch and admission date.

Validation:
The dataset contains active and inactive students, so filtering by enrollment_status is logically correct.

---

# 2. Invalid Email Query

Purpose:
Find missing or malformed emails.

Expected Output:
Shows students with NULL or invalid email format.

Validation:
Email validation is important because email is treated as a candidate key.

---

# 3. Easy and Medium Problems

Purpose:
Retrieve lower difficulty problems.

Expected Output:
Displays problems with difficulty Easy or Medium.

Validation:
Difficulty values are categorical and suitable for filtering.

---

# 4. Latest Submissions

Purpose:
Show newest submissions.

Expected Output:
Latest 20 submissions ordered by timestamp.

Validation:
submitted_at is a timestamp field, making descending ordering meaningful.

---

# 5. Submission Join Query

Purpose:
Display submission details with student and problem information.

Expected Output:
Combines data from submissions, students and problems.

Validation:
Foreign key relationships make these joins logically valid.

---

# 6. Course Enrollment Counts

Purpose:
Count enrolled students per course.

Expected Output:
Displays course titles and total enrollments.

Validation:
GROUP BY is required because multiple enrollments exist per course.

---

# 7. Problems with Low Success Rate

Purpose:
Identify difficult problems.

Expected Output:
Problems where accepted submissions are below 40%.

Validation:
Accepted submissions represent successful attempts.

---

# 8. Problems Never Attempted

Purpose:
Find unused problems.

Expected Output:
Problems absent from submissions table.

Validation:
NOT IN subquery correctly identifies unattempted problems.