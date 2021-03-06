#
# Copyright (C) 2014 Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.
#

Enrollment.class_eval do
  after_save :recache_course_grade_distribution

  def recache_course_grade_distribution
    # workflow_state_changed? will be true for records that were new, so this
    # will also catch newly created enrollments.
    if student? && !fake_student? && workflow_state_changed?
      # the course may have gained/lost a 'valid' (non-fake active or completed
      # student enrollment), update its cached grade distribution.
      course.recache_grade_distribution
    end
    true
  end
end
