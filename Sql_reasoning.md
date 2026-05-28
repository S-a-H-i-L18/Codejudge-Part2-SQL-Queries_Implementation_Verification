# SQL Reasoning

# LEFT JOIN vs INNER JOIN

LEFT JOIN is more appropriate in the student enrollment query because we want to include students even if they are not enrolled in any course.

Using INNER JOIN would exclude such students.

---

# HAVING vs WHERE

HAVING is required in aggregation queries because filtering occurs after GROUP BY.

Example:
Finding students with more than 10 submissions uses HAVING COUNT(*) > 10.

WHERE cannot filter aggregate results.

---

# Use of Subquery

Subqueries help compare grouped values against overall aggregates.

Example:
Students whose average score is greater than the overall average score.

---

# Duplicate Record Risk

If duplicate enrollment records exist, course enrollment counts may become misleading.

This is why UNIQUE(student_id, course_id) is important.

---

# Edge Case Considered

contest_id in submissions may be NULL for practice submissions.

Queries were written so they do not incorrectly exclude such rows.