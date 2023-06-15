class User < ActiveRecord::Base
  
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  def sum_points (question)
    if question.difficulty.to_i == 1
      self.points += 10
    elsif question.difficulty.to_i == 2
      self.points += 20
    else
      self.points += 30
    end
    self.update(points: self.points)
  end

  def rest_points (question)
    if question.difficulty.to_i == 1
      self.points -= 10
    elsif question.difficulty.to_i == 2
      self.points -= 20
    else
      self.points -= 30
    end
    self.update(points: self.points)
  end

end
