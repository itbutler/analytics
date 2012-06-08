GradeCalculator.class_eval do
  # after recomputing current scores on enrollments in the course, recache its
  # grade distribution
  def recompute_and_save_scores_with_cached_grade_distribution
    recompute_and_save_scores_without_cached_grade_distribution
    unless @current_updates.empty? && @final_updates.empty?
      @course.recache_grade_distribution
    end
  end
  alias_method_chain :recompute_and_save_scores, :cached_grade_distribution
end