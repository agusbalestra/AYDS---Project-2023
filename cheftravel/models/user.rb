class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, length: { in: 3..20 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "debe ser una dirección de correo electrónico válida" } # verifica que haya un caracter antes y dsp del @
  validates :password, presence: true, length: { minimum: 4, too_short: "te queres ir hackeado?" }
  
  validate :password_match

  attr_accessor :reppw

  def password_match
    if password != reppw
      errors.add(:password_confirmation, "debe coincidir con la contraseña")
    end
  end

  def sum_points(question)
    if question.difficulty.to_i == 1
      self.points += 10
    elsif question.difficulty.to_i == 2
      self.points += 20
    else
      self.points += 30
    end
    self.update(points: self.points)
  end
  
  def rest_points(question)
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
